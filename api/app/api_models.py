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


class TutorialWithoutProfessor(OrmBase):
    lecture_room: LectureRoom
    start_date: datetime
    end_date: datetime


class Tutorial(TutorialWithoutProfessor):
    professor: Professor


class ProfessorWithTutorials(Professor):
    tutorials: Tutorial


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

# FCM
class Message(BaseModel):
    title: str
    body: str | None


class FirebaseClientToken(BaseModel):
    fcm_client_token: str
