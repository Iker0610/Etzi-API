from datetime import datetime, date

import bcrypt
from pydantic import BaseModel, validator
from sqlalchemy.orm import Query


class OrmBase(BaseModel):
    # Pre-processing validator that evaluates lazy relationships before any other validation
    # NOTE: If high throughput/performance is a concern, you can/should probably apply
    #       this validator in a more targeted fashion instead of a wildcard in a base class.
    #       This approach is by no means slow, but adds a minor amount of overhead for every field
    @validator("*", pre=True)
    def evaluate_lazy_columns(cls, v):
        if isinstance(v, Query):
            return v.all()
        return v

    class Config:
        orm_mode = True


class User(OrmBase):
    ldap: str


class UserAuth(User):
    password: str

    def hashed_password(self) -> bytes:
        bytePwd = self.password.encode('utf-8')

        # Hash password with salt
        return bcrypt.hashpw(bytePwd, bcrypt.gensalt())


class StudentData(OrmBase):
    ldap: str

    name: str
    surname: str
    email: str

    enrolled_degree: str


# --------------------------------------------------------------------
class AcademicYear(OrmBase):
    start_date: date
    end_date: date


class Building(OrmBase):
    id: str
    abbreviation: str
    name: str
    address: str


class LectureRoom(OrmBase):
    number: int
    floor: int
    building: Building


# --------------------------------------------------------------------

class Professor(OrmBase):
    email: str
    name: str
    surname: str


class Tutorial(OrmBase):
    lecture_room: LectureRoom
    start_date: datetime
    end_date: datetime


# class TutorialWithProfessor(Tutorial):
#     professor: Professor


class ProfessorWithTutorials(Professor):
    tutorials: list[Tutorial]


class SubjectWithTutorials(OrmBase):
    name: str
    professors: list[ProfessorWithTutorials]


# --------------------------------------------------------------------

class Lecture(OrmBase):
    subject_name: str
    academic_year: date
    degree: str

    subgroup: int

    start_date: datetime
    end_date: datetime

    professor: Professor
    lecture_room: LectureRoom


# --------------------------------------------------------------------

class Subject(OrmBase):
    name: str
    academic_year_start: date
    degree: str
    type: str
    credits: int
    course: int


class SubjectCallAttendance(OrmBase):
    # student_ldap: str
    grade: str
    distinction: bool
    provisional: bool


class SubjectCall(OrmBase):
    call_type: str
    exam_date: datetime
    subject_call_attendances: list[SubjectCallAttendance]


class SubjectEnrollment(OrmBase):
    subject: Subject
    subgroup: int
    subject_calls: list[SubjectCall]


# --------------------------------------------------------------------

class ProvisionalGrade(BaseModel):
    student_ldap: str
    subject_name: str
    academic_year: date
    degree: str
    call_type: str

    grade: float
    distinction: bool


class ProvisionalGradePetition(BaseModel):
    auth_token: str
    provisional_grade: ProvisionalGrade


# --------------------------------------------------------------------


# FCM
class Message(BaseModel):
    title: str
    body: str | None


class FirebaseClientToken(BaseModel):
    fcm_client_token: str
