from sqlalchemy import Column, TEXT, VARCHAR, LargeBinary, CHAR, DATE, ForeignKey, SMALLINT, TIMESTAMP, BOOLEAN, ForeignKeyConstraint
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


class AcademicYear(Base):
    __tablename__ = "academic_year"

    start_date = Column(DATE, primary_key=True, index=True)
    end_date = Column(DATE)


class Subject(Base):
    __tablename__ = "subject"

    name = Column(TEXT, primary_key=True, index=True)
    academic_year_start = Column(DATE, ForeignKey("academic_year.start_date"), name="academic_year", primary_key=True, index=True)
    degree = Column(TEXT, ForeignKey("degree.name"), primary_key=True, index=True)

    course = Column(SMALLINT)
    type = Column(VARCHAR(20))
    credits = Column(SMALLINT)

    # Relationships
    academic_year = relationship('AcademicYear')
    professors = relationship(
        'Professor',
        primaryjoin="and_(Subject.name == Lecture.subject_name, "
                    "Subject.academic_year_start == Lecture.academic_year, "
                    "Subject.degree == Lecture.degree)",
        secondaryjoin="Lecture.professor_email == Professor.email",
        secondary="outerjoin(Lecture, Professor)"
    )


class SubjectCall(Base):
    __tablename__ = "subject_call"

    subject_name = Column(TEXT, primary_key=True, index=True)
    academic_year = Column(DATE, primary_key=True, index=True)
    degree = Column(TEXT, primary_key=True, index=True)

    call_type = Column(VARCHAR(14), primary_key=True, index=True)
    exam_date = Column(TIMESTAMP)

    __table_args__ = (
        ForeignKeyConstraint(("subject_name", "academic_year", "degree"), ["subject.name", "subject.academic_year", "subject.degree"]),
    )

    # Relationships
    subject_call_attendances = relationship('SubjectCallAttendance', lazy='joined')


class SubjectCallAttendance(Base):
    __tablename__ = "subject_call_attendance"

    student_ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    subject_name = Column(TEXT, primary_key=True, index=True)
    academic_year = Column(DATE, primary_key=True, index=True)
    degree = Column(TEXT, primary_key=True, index=True)
    call_type = Column(VARCHAR(14), primary_key=True, index=True)

    grade = Column(VARCHAR(5), default='')
    distinction = Column(BOOLEAN, default=False)
    provisional = Column(BOOLEAN, default=True)

    __table_args__ = (
        ForeignKeyConstraint(("subject_name", "academic_year", "degree", "call_type"), ["subject_call.subject_name", "subject_call.academic_year", "subject_call.degree", "subject_call.call_type"]),
    )


class Building(Base):
    __tablename__ = "building"

    id = Column(TEXT, primary_key=True, index=True)
    abbreviation = Column(TEXT)
    name = Column(TEXT)
    address = Column(TEXT, primary_key=True, index=True)


class LectureRoom(Base):
    __tablename__ = "lecture_room"

    number = Column(SMALLINT, primary_key=True, index=True)
    floor = Column(SMALLINT, primary_key=True, index=True)
    building_id = Column(TEXT, ForeignKey("building.id"), name="building", primary_key=True, index=True)

    # Relationships
    building = relationship('Building')


class Professor(Base):
    __tablename__ = "professor"

    email = Column(TEXT, primary_key=True, index=True)
    name = Column(VARCHAR(30))
    surname = Column(VARCHAR(40))

    # Relationships
    tutorials = relationship('Tutorial', back_populates="professor")


class Tutorial(Base):
    __tablename__ = "tutorial"

    professor_email = Column(TEXT, ForeignKey("professor.email"), primary_key=True, index=True)

    room_number = Column(SMALLINT)
    room_floor = Column(SMALLINT)
    room_building = Column(TEXT)

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    __table_args__ = (
        ForeignKeyConstraint(("room_number", "room_floor", "room_building"), ["lecture_room.number", "lecture_room.floor", "lecture_room.building"]),
    )

    # Relationships
    professor = relationship('Professor', back_populates="tutorials")
    lecture_room = relationship('LectureRoom')


class Lecture(Base):
    __tablename__ = "lecture"

    subject_name = Column(TEXT)
    academic_year = Column(DATE, ForeignKey("academic_year.start_date"))
    degree = Column(TEXT)

    subgroup = Column(SMALLINT, primary_key=True, index=True)

    professor_email = Column(TEXT, ForeignKey("professor.email"))

    room_number = Column(SMALLINT)
    room_floor = Column(SMALLINT)
    room_building = Column(TEXT)

    start_date = Column(TIMESTAMP, primary_key=True, index=True)
    end_date = Column(TIMESTAMP)

    __table_args__ = (
        ForeignKeyConstraint(("subject_name", "academic_year", "degree"), ["subject.name", "subject.academic_year", "subject.degree"]),
        ForeignKeyConstraint(("room_number", "room_floor", "room_building"), ["lecture_room.number", "lecture_room.floor", "lecture_room.building"]),
    )

    # Relationships
    professor = relationship('Professor')
    lecture_room = relationship('LectureRoom')
    academic_year_data = relationship('AcademicYear')


class SubjectEnrollment(Base):
    __tablename__ = "subject_enrollment"

    ldap = Column(CHAR(6), ForeignKey("student.ldap"), primary_key=True, index=True)

    subject_name = Column(TEXT, primary_key=True, index=True)
    academic_year = Column(DATE, primary_key=True, index=True)
    degree = Column(TEXT, primary_key=True, index=True)

    subgroup = Column(SMALLINT)

    __table_args__ = (
        ForeignKeyConstraint(("subject_name", "academic_year", "degree"), ["subject.name", "subject.academic_year", "subject.degree"]),
    )

    # Relationships
    subject = relationship("Subject")
    subject_calls = relationship(
        'SubjectCall',
        primaryjoin="and_(Subject.name == SubjectEnrollment.subject_name, "
                    "Subject.academic_year_start == SubjectEnrollment.academic_year, "
                    "Subject.degree == SubjectEnrollment.degree)",

        secondaryjoin="and_(Subject.name == SubjectCall.subject_name, "
                      "Subject.academic_year_start == SubjectCall.academic_year, "
                      "Subject.degree == SubjectCall.degree)",

        secondary="outerjoin(Subject, SubjectCall)",
    )
