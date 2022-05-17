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

    # Relations
    subject_enrollments = relationship("SubjectEnrollment", order_by="[SubjectEnrollment.academic_year, SubjectEnrollment.subject_name]")
    subject_call_attendances = relationship("SubjectCallAttendance", order_by="[SubjectCallAttendance.academic_year, SubjectCallAttendance.subject_name]")


class AcademicYear(Base):
    __tablename__ = "academic_year"

    start_date = Column(DATE, primary_key=True, index=True)
    end_date = Column(DATE)


class Subject(Base):
    __tablename__ = "subject"

    name = Column(TEXT, primary_key=True, index=True)
    academic_year_start = Column(DATE, ForeignKey("academic_year.start_date"), name="academic_year", primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("degree.name"), primary_key=True, index=True)

    type = Column(VARCHAR(20))
    credits = Column(SMALLINT)

    # Relationships
    academic_year = relationship('AcademicYear')
    # TODO: Add tutorials


class SubjectCall(Base):
    __tablename__ = "subject_call"

    subject_name = Column(TEXT, ForeignKey("subject.name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("subject.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("subject.degree"), primary_key=True, index=True)

    call_type = Column(VARCHAR(12), primary_key=True, index=True)
    exam_date = Column(TIMESTAMP)

    # Relationships
    subject = relationship('Subject')


class SubjectCallAttendance:
    __tablename__ = "subject_call_attendance"

    student_ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    subject_name = Column(TEXT, ForeignKey("subject_call.subject_name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("subject_call.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("subject_call.degree"), primary_key=True, index=True)
    call_type = Column(VARCHAR(12), primary_key=True, index=True)

    grade = Column(VARCHAR(5), default='')
    distinction = Column(BOOLEAN, default=False)

    # Relationships
    subject_call = relationship('SubjectCall')


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

    # Relationships
    tutorials = relationship('Tutorial', back_populates="professor")


class Tutorial:
    __tablename__ = "tutorial"

    professor_email = Column(TEXT, ForeignKey("professor.email"), primary_key=True, index=True)

    room_number = Column(SMALLINT, ForeignKey("lecture_room.number"))
    room_floor = Column(SMALLINT, ForeignKey("lecture_room.floor"))
    room_building = Column(TEXT, ForeignKey("lecture_room.building"))

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    # Relationships
    professor = relationship('Professor', back_populates="tutorials")
    lecture_room = relationship('LectureRoom')


class Lecture:
    __tablename__ = "lecture"

    subject_name = Column(TEXT, ForeignKey("subject.name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("subject.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("subject.degree"), primary_key=True, index=True)

    subgroup = Column(SMALLINT, primary_key=True, index=True)

    professor_email = Column(TEXT, ForeignKey("professor.email"))

    room_number = Column(SMALLINT, ForeignKey("lecture_room.number"))
    room_floor = Column(SMALLINT, ForeignKey("lecture_room.floor"))
    room_building = Column(TEXT, ForeignKey("lecture_room.building"))

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    # Relationships
    subject = relationship('Subject')
    professor = relationship('Professor')
    lecture_room = relationship('LectureRoom')


class SubjectEnrollment:
    __tablename__ = "subject_enrollment"

    student_ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    subject_name = Column(TEXT, ForeignKey("subject.name"), primary_key=True, index=True)
    academic_year = Column(DATE, ForeignKey("subject.academic_year"), primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("subject.degree"), primary_key=True, index=True)

    subgroup = Column(SMALLINT)

    # Relationships
    subject = relationship('Subject')
