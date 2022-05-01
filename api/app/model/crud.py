from sqlalchemy.engine import row
from sqlalchemy.orm import Session

from . import entities
from .. import api_models


def get_user(db: Session, ldap: str) -> entities.User | None:
    return db.query(entities.User).filter(entities.User.ldap == ldap).first()


def get_users(db: Session, skip: int = 0, limit: int = 100) -> list[row]:
    return db.query(entities.User.ldap).offset(skip).limit(limit).all()


def get_user_password(db: Session, ldap: str) -> bytes | None:
    result = db.query(entities.User.hashed_password).filter(entities.User.ldap == ldap).first()
    return result.hashed_password if result else result


def get_user_profile_image_url(db: Session, ldap: str) -> str | None:
    result = db.query(entities.User.profile_image_url).filter(entities.User.ldap == ldap).first()
    return result.profile_image_url if result else result


def set_user_profile_image_url(db: Session, user: str | entities.User, url: str) -> bool:
    if isinstance(user, str):
        user = get_user(db, user)

    if user:
        user.profile_image_url = url
        db.commit()
        db.refresh(user)

    return bool(user)


def create_user(db: Session, user: api_models.UserAuth) -> entities.User | None:
    if get_user(db, ldap=user.ldap):
        return None
    else:
        db_user = entities.User(ldap=user.ldap, hashed_password=user.hashed_password())
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user
