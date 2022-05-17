from sqlalchemy.engine import row
from sqlalchemy.orm import Session

from . import entities
from .. import api_models


def get_users(db: Session, skip: int = 0, limit: int = 100) -> list[row]:
    return db.query(entities.Student.ldap, entities.Student.password).offset(skip).limit(limit).all()


# --------------------------------------------------------------------


def get_user_ldap(db: Session, ldap: str) -> str | None:
    return db.query(entities.Student.ldap).filter(entities.Student.ldap == ldap).first()


def get_user_password(db: Session, ldap: str) -> bytes | None:
    result = db.query(entities.Student.password).filter(entities.Student.ldap == ldap).first()
    return result.password if result else result


def get_student_data(db: Session, ldap: str) -> entities.Student | None:
    return db.query(entities.Student).filter(entities.Student.ldap == ldap).first()


# --------------------------------------------------------------------

def get_student_timetable(db: Session, ldap: str) -> list[entities.Lecture]:
    return db.query(entities.Lecture) \
        .select_from(entities.Student) \
        .join(entities.Student.subject_enrollments) \
        .join(entities.Subject) \
        .join(entities.Lecture) \
        .filter(entities.Student.ldap == ldap) \
        .filter(entities.Lecture.subgroup == -1 or entities.SubjectEnrollment.subgroup == entities.Lecture.subgroup) \
        .order_by(entities.Lecture.start_date).all()


# --------------------------------------------------------------------

def get_user_profile_image_url(db: Session, ldap: str) -> str | None:
    result = db.query(entities.Student.profile_image_url).filter(entities.Student.ldap == ldap).first()
    return result.profile_image_url if result else result


def set_user_profile_image_url(db: Session, user: str | entities.Student, url: str) -> bool:
    if isinstance(user, str):
        user = get_student_data(db, user)

    if user:
        user.profile_image_url = url
        db.commit()
        db.refresh(user)

    return bool(user)

# --------------------------------------------------------------------

def create_user(db: Session, user: api_models.UserAuth) -> entities.Student | None:
    if get_user_ldap(db, ldap=user.ldap):
        return None
    else:
        db_user = entities.Student(ldap=user.ldap, password=user.hashed_password())
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user
