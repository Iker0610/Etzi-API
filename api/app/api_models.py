import bcrypt
from pydantic import BaseModel


class User(BaseModel):
    ldap: str

    class Config:
        orm_mode = True


class UserAuth(User):
    password: str

    def hashed_password(self) -> bytes:
        bytePwd = self.password.encode('utf-8')

        # Hash password with salt
        return bcrypt.hashpw(bytePwd, bcrypt.gensalt())


class Message(BaseModel):
    title: str
    body: str | None


class FirebaseClientToken(BaseModel):
    fcm_client_token: str
