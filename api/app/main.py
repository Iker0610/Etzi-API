from mimetypes import guess_extension
from os import environ
from pathlib import Path

import bcrypt
import firebase_admin
from fastapi import Depends, FastAPI, HTTPException, status, UploadFile
from fastapi.responses import FileResponse, RedirectResponse
from fastapi.security import OAuth2PasswordRequestFormStrict
from firebase_admin import credentials, messaging
from sqlalchemy.orm import Session
from unidecode import unidecode

from . import api_models
from .api_models import Message, FirebaseClientToken
from .auth_utils import get_verified_current_user, create_access_token, CREDENTIALS_EXCEPTION, create_refresh_token, TokenResponse, decode_token, OAuth2RefreshTokenForm
from .model import crud
from .model.database import get_db

VALID_IMAGE_MIME_TYPES = ['image/jpeg', 'image/png', 'image/webp']

description: str = """
This api allows you to authorize as an UPV/EHU student and retrieve user data.

*An internal auth-token is required for al entry-points.*


## Entry Points

### Authentication
With these entry points you can **authenticate users** and **get and refresh access tokens** in order to access other API end points.

---

### Users/Profile
With these entry points you can **retrieve user data**.

---

### Notifications
With these entry points you can **send notifications via FCM** to UPV/EHU students.
"""

app = FastAPI(
    title="Etzi API",
    description=description,
    version="0.0.0-alpha",
    license_info={
        "name": "Apache 2.0",
        "url": "https://www.apache.org/licenses/LICENSE-2.0.html",
    },
)

# ---------------------------------------------------------
#  Firebase
# ---------------------------------------------------------
cred = credentials.Certificate(environ['FIREBASE_CREDENTIALS'])
firebase_admin.initialize_app(cred)


# ---------------------------------------------------------
#  Entry-Points
# ---------------------------------------------------------

@app.get("/", include_in_schema=False)
async def root():
    return RedirectResponse(url='/docs')


@app.post("/auth/token", tags=['Authentication'],
          response_model=TokenResponse, status_code=status.HTTP_200_OK,
          responses={401: {"description": "Could not validate credentials."}},
          )
async def authenticate(form_data: OAuth2PasswordRequestFormStrict = Depends(), db: Session = Depends(get_db)):
    hashed_password = crud.get_user_password(db, ldap=form_data.username)

    if hashed_password is None or not bcrypt.checkpw(form_data.password.encode('utf-8'), hashed_password):
        raise CREDENTIALS_EXCEPTION

    access_token, expire_in_seconds = create_access_token(data={"sub": form_data.username})
    return {
        "token_type": "bearer",
        "expires_in": expire_in_seconds,
        "access_token": access_token,
        'refresh_token': create_refresh_token(data={"sub": form_data.username}),
    }


@app.post("/auth/refresh", tags=['Authentication'],
          response_model=TokenResponse, status_code=status.HTTP_200_OK,
          responses={
              401: {"description": "Could not validate credentials."},
              403: {"description": "This user does not exist anymore."}
          })
async def refresh(form_data: OAuth2RefreshTokenForm = Depends(), db: Session = Depends(get_db)):
    try:
        token = form_data.refresh_token
        ldap = decode_token(token).get('sub')

        # Validate email
        if crud.get_user_password(db, ldap=ldap):
            # Create and return token
            access_token, expire_in_seconds = create_access_token(data={"sub": ldap})
            return {
                "token_type": "bearer",
                "expires_in": expire_in_seconds,
                "access_token": access_token,
                'refresh_token': create_refresh_token(data={"sub": ldap}),
            }
        else:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="This user does not exist.")

    except Exception:
        raise CREDENTIALS_EXCEPTION


# ---------------------------------------------------------

@app.post("/users", tags=["Users"],
          response_model=api_models.User, status_code=status.HTTP_201_CREATED,
          responses={400: {"description": "Password is not valid."}, 409: {"description": "ldap already registered."}}, )
async def create_user(user: api_models.UserAuth, db: Session = Depends(get_db)):
    if len(user.password) < 5:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Password is not valid.")

    if not (db_user := crud.create_user(db=db, user=user)):
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="ldap already registered.")
    return db_user


@app.get("/users", response_model=list[api_models.User], status_code=status.HTTP_200_OK, tags=["Users"])
async def get_users(skip: int = 0, limit: int = 100, _: str = Depends(get_verified_current_user), db: Session = Depends(get_db)):
    return crud.get_users(db, skip, limit)


# ---------------------------------------------------------


@app.get("/profile/image", tags=["Profile"],
         status_code=status.HTTP_200_OK, response_class=FileResponse,
         responses={404: {"description": "User doesn't exists."}})
async def get_user_profile_image(current_user: str = Depends(get_verified_current_user), db: Session = Depends(get_db)):
    if not (user_profile_image_url := crud.get_user_profile_image_url(db, ldap=current_user)):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User doesn't exists.")

    if Path(user_profile_image_url).exists():
        return FileResponse(user_profile_image_url, filename=Path(user_profile_image_url).name)
    else:
        return FileResponse(f"{environ['IMAGES_PATH']}/placeholder.png", filename="placeholder.png")


@app.put("/profile/image", tags=["Profile"],
         status_code=status.HTTP_204_NO_CONTENT,
         responses={404: {"description": "User doesn't exists."}, 400: {"description": f"File is not a valid image file. Valid types: {', '.join(VALID_IMAGE_MIME_TYPES)}"}})
async def set_user_profile_image(file: UploadFile, current_user: str = Depends(get_verified_current_user), db: Session = Depends(get_db)):
    if not (user := crud.get_user(db, current_user)):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User doesn't exists.")

    if file.content_type not in VALID_IMAGE_MIME_TYPES:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=f"File is not a valid image file. Valid types: {', '.join(VALID_IMAGE_MIME_TYPES)}")

    file_extension = guess_extension(file.content_type)
    path = f"{environ['IMAGES_PATH']}/{current_user}{file_extension}"

    if crud.set_user_profile_image_url(db, user, path):
        contents = await file.read()
        with open(path, 'wb') as f:
            f.write(contents)


# ---------------------------------------------------------

@app.post('/notifications/subscribe', status_code=status.HTTP_202_ACCEPTED, tags=["Notifications"])
def suscribe_user_to_alert(token: FirebaseClientToken, current_user: str = Depends(get_verified_current_user)):
    # Procesamos el nombre de la provincia quitando espacios y tíldes y se suscribe al usuario
    messaging.subscribe_to_topic([token.fcm_client_token], unidecode(current_user.replace(' ', '_')))
    messaging.subscribe_to_topic([token.fcm_client_token], 'All')


async def send_notification(message: Message, topic: str = 'All'):
    messaging.send(
        messaging.Message(
            data={k: f'{v}' for k, v in dict(message).items()},
            topic=unidecode(topic.replace(' ', '_'))
        )
    )

    messaging.send(
        messaging.Message(
            notification=messaging.Notification(
                **dict(message)
            ),
            topic=unidecode(topic.replace(' ', '_'))
        )
    )


@app.post("/notifications", tags=["Notifications"])
async def send_broadcast_notification(message: Message, _: str = Depends(get_verified_current_user)):
    await send_notification(message)


@app.post("/notifications/{ldap}", tags=["Notifications"])
async def send_notification_to_user(ldap: str, message: Message, _: str = Depends(get_verified_current_user)):
    await send_notification(message, ldap)
