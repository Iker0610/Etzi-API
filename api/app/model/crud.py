from datetime import date

from sqlalchemy import and_, or_, func
from sqlalchemy.engine import row
from sqlalchemy.orm import Session, contains_eager

from .entities import *
from .. import api_models


def get_users(db: Session, skip: int = 0, limit: int = 100) -> list[row]:
    return db.query(Student.ldap, Student.password).offset(skip).limit(limit).all()


# --------------------------------------------------------------------


def get_user_ldap(db: Session, ldap: str) -> str | None:
    return db.query(Student.ldap).filter(Student.ldap == ldap).first()


def get_user_password(db: Session, ldap: str) -> bytes | None:
    result = db.query(Student.password).filter(Student.ldap == ldap).first()
    return result.password if result else result


def get_student_data(db: Session, ldap: str) -> Student | None:
    return db.query(Student).filter(Student.ldap == ldap).first()


# --------------------------------------------------------------------

def get_student_timetable(db: Session, ldap: str) -> list[Lecture]:
    return db.query(Lecture) \
        .select_from(Student) \
        .filter(Student.ldap == ldap) \
        .join(Student.subject_enrollments) \
        .join(Subject) \
        .join(AcademicYear) \
        .filter(and_(Subject.academic_year.has(AcademicYear.start_date <= date.today()), Subject.academic_year.has(date.today() <= AcademicYear.end_date))) \
        .join(Lecture) \
        .filter(or_(Lecture.subgroup == -1, SubjectEnrollment.subgroup == Lecture.subgroup)) \
        .order_by(Lecture.start_date).all()


def get_student_tutorials(db: Session, ldap: str):
    return db.query(Subject) \
        .select_from(Student) \
        .filter(Student.ldap == ldap) \
        .join(Student.subject_enrollments) \
        .join(Subject) \
        .join(AcademicYear) \
        .filter(and_(Subject.academic_year.has(AcademicYear.start_date <= date.today()), Subject.academic_year.has(date.today() <= AcademicYear.end_date))) \
        .filter(date.today() <= func.DATE(Tutorial.start_date)) \
        .order_by(Subject.name).all()


def get_student_record(db: Session, ldap: str):
    return db.query(SubjectEnrollment) \
        .select_from(Student) \
        .filter(Student.ldap == ldap) \
        .outerjoin(Student.subject_enrollments) \
        .outerjoin(SubjectEnrollment.subject_calls) \
        .outerjoin(SubjectCallAttendance, and_(SubjectCall.subject_call_attendances, SubjectCallAttendance.student_ldap == ldap)) \
        .options(contains_eager(SubjectEnrollment.subject_calls, SubjectCall.subject_call_attendances)) \
        .order_by(SubjectEnrollment.academic_year) \
        .order_by(SubjectEnrollment.subject_name) \
        .order_by(SubjectCall.exam_date).all()


# --------------------------------------------------------------------


def get_user_profile_image_url(db: Session, ldap: str) -> str | None:
    result = db.query(Student.profile_image_url).filter(Student.ldap == ldap).first()
    return result.profile_image_url if result else result


def set_user_profile_image_url(db: Session, user: str | Student, url: str) -> bool:
    if isinstance(user, str):
        user = get_student_data(db, user)

    if user:
        user.profile_image_url = url
        db.commit()
        db.refresh(user)

    return bool(user)


# --------------------------------------------------------------------

def create_user(db: Session, user: api_models.UserAuth) -> Student | None:
    if get_user_ldap(db, ldap=user.ldap):
        return None
    else:
        db_user = Student(ldap=user.ldap, password=user.hashed_password())
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user
