from sqlalchemy import Column, TEXT, VARCHAR, LargeBinary, CHAR, DATE, ForeignKey, SMALLINT, TIMESTAMP, BOOLEAN
from sqlalchemy.orm import relationship

from .database import Base


class Degree(Base):
    __tablename__ = "degree"

    name = Column(TEXT, primary_key=True, index=True)


class Student(Base):
    __tablename__ = "student"

    ldap = Column(CHAR(length=6), primary_key=True, index=True)
    password = Column(LargeBinary)

    name = Column(VARCHAR(30))
    surname = Column(VARCHAR(40))
    email = Column(TEXT)

    enrolled_degree = Column(TEXT, ForeignKey("degree.name"))

    profile_image_url = Column(TEXT, name='profile_image', default="/etzi/images/placeholder.png")


class AcademicYear(Base):
    __tablename__ = "academic_year"

    start_date = Column(DATE, primary_key=True, index=True)
    end_date = Column(DATE)


class Lecture(Base):
    __tablename__ = "lecture"

    name = Column(TEXT, primary_key=True, index=True)
    academic_year_start = Column(DATE, ForeignKey("academic_year.start_date"), name="academic_year", primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("degree.name"), primary_key=True, index=True)

    type = Column(VARCHAR(20))
    credits = Column(SMALLINT)

    # Relationships
    academic_year = relationship('AcademicYear')


class LectureCall(Base):
    __tablename__ = "lecture_call"

    lecture_name = Column(TEXT, ForeignKey("lecture.lecture_name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("lecture.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("lecture.degree"), primary_key=True, index=True)

    call_type = Column(VARCHAR(12), primary_key=True, index=True)
    exam_date = Column(TIMESTAMP)

    # Relationships
    lecture = relationship('Lecture')


class LectureCallAttendance:
    __tablename__ = "lecture_call_attendance"

    student_ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    lecture_name = Column(TEXT, ForeignKey("lecture.lecture_name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("lecture.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("lecture.degree"), primary_key=True, index=True)
    call_type = Column(VARCHAR(12), ForeignKey("lecture.degree"), primary_key=True, index=True)

    grade = Column(VARCHAR(5), default='')
    distinction = Column(BOOLEAN, default=False)

    # Relationships
    lecture_call = relationship('LectureCall')
    student = relationship('Student')


class Building:
    __tablename__ = "building"

    id = Column(TEXT, primary_key=True, index=True)
    abbreviation = Column(TEXT)
    name = Column(TEXT)
    direction = Column(TEXT, primary_key=True, index=True)


class LectureRoom:
    __tablename__ = "lecture_room"

    number = Column(SMALLINT, primary_key=True, index=True)
    floor = Column(SMALLINT, primary_key=True, index=True)
    building_id = Column(TEXT, ForeignKey("building.id"), name="building", primary_key=True, index=True)

    # Relationships
    building = relationship('Building')


class Professor:
    __tablename__ = "professor"

    email = Column(TEXT, primary_key=True, index=True)
    name = Column(VARCHAR(30))
    surname = Column(VARCHAR(40))


class Tutorial:
    __tablename__ = "tutorial"

    professor_email = Column(TEXT, ForeignKey("professor.email"), primary_key=True, index=True)

    room_number = Column(SMALLINT, ForeignKey("lecture_room.number"))
    room_floor = Column(SMALLINT, ForeignKey("lecture_room.floor"))
    room_building = Column(TEXT, ForeignKey("lecture_room.building"))

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    # Relationships
    professor = relationship('Professor')
    lecture_room = relationship('LectureRoom')


class LectureClass:
    __tablename__ = "lecture_class"

    lecture_name = Column(TEXT, ForeignKey("lecture.lecture_name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("lecture.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("lecture.degree"), primary_key=True, index=True)

    subgroup = Column(SMALLINT, primary_key=True, index=True)

    professor_email = Column(TEXT, ForeignKey("professor.email"))

    room_number = Column(SMALLINT, ForeignKey("lecture_room.number"))
    room_floor = Column(SMALLINT, ForeignKey("lecture_room.floor"))
    room_building = Column(TEXT, ForeignKey("lecture_room.building"))

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    # Relationships
    lecture = relationship('Lecture')
    professor = relationship('Professor')
    lecture_room = relationship('LectureRoom')


class LectureEnrollment:
    __tablename__ = "lecture_enrollment"

    student_ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    lecture_name = Column(TEXT, ForeignKey("lecture.lecture_name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("lecture.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("lecture.degree"), primary_key=True, index=True)

    subgroup = Column(SMALLINT)

    # Relationships
    lecture = relationship('Lecture')
    student = relationship('Student')
