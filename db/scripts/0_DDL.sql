/*  ENTITIES  */

CREATE TABLE degree
(
    name TEXT NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE student
(
    ldap            CHAR(6)     NOT NULL,
    password        bytea       NOT NULL,

    name            VARCHAR(30) NOT NULL,
    surname         VARCHAR(40) NOT NULL,
    email           TEXT        NOT NULL,

    enrolled_degree TEXT        NOT NULL,

    profile_image   TEXT        NOT NULL DEFAULT '/etzi/images/placeholder.png',

    PRIMARY KEY (ldap),
    FOREIGN KEY (enrolled_degree) REFERENCES degree (name)
);

CREATE TABLE academic_year
(
    start_date DATE NOT NULL,
    end_date   DATE NOT NULL,

    PRIMARY KEY (start_date)
);

CREATE TABLE subject
(
    name          TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    degree        TEXT        NOT NULL,

    type          VARCHAR(20) NOT NULL,
    credits       SMALLINT    NOT NULL,

    PRIMARY KEY (name, academic_year, degree),
    FOREIGN KEY (academic_year) REFERENCES academic_year (start_date),
    FOREIGN KEY (degree) REFERENCES degree (name)
);

CREATE TABLE subject_call
(
    subject_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    degree        TEXT        NOT NULL,

    call_type     VARCHAR(14) NOT NULL,
    exam_date     TIMESTAMP   NOT NULL,

    PRIMARY KEY (subject_name, academic_year, degree, call_type),
    FOREIGN KEY (subject_name, academic_year, degree) REFERENCES subject (name, academic_year, degree)
);

CREATE TABLE subject_call_attendance
(
    student_ldap  CHAR(6)     NOT NULL,

    subject_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    degree        TEXT        NOT NULL,

    call_type     VARCHAR(12) NOT NULL,
    grade         VARCHAR(5)  NOT NULL DEFAULT '',
    distinction   BOOLEAN     NOT NULL DEFAULT FALSE,

    PRIMARY KEY (student_ldap, subject_name, academic_year, degree, call_type),
    FOREIGN KEY (student_ldap) REFERENCES student (ldap),
    FOREIGN KEY (subject_name, academic_year, degree, call_type) REFERENCES subject_call (subject_name, academic_year, degree, call_type)
);

CREATE TABLE building
(
    id           TEXT NOT NULL,
    abbreviation TEXT NOT NULL,
    name         TEXT NOT NULL,
    direction    TEXT NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE lecture_room
(
    number   SMALLINT NOT NULL,
    floor    SMALLINT NOT NULL,
    building TEXT     NOT NULL,

    PRIMARY KEY (number, floor, building),
    FOREIGN KEY (building) REFERENCES building (id)
);

CREATE TABLE professor
(
    name    VARCHAR(30) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    email   TEXT        NOT NULL,

    PRIMARY KEY (email)
);

CREATE TABLE tutorial
(
    professor_email TEXT      NOT NULL,

    room_number     SMALLINT  NOT NULL,
    room_floor      SMALLINT  NOT NULL,
    room_building   TEXT      NOT NULL,

    start_date      TIMESTAMP NOT NULL,
    end_date        TIMESTAMP NOT NULL,

    PRIMARY KEY (professor_email, start_date),
    FOREIGN KEY (professor_email) REFERENCES professor (email),
    FOREIGN KEY (room_number, room_floor, room_building) REFERENCES lecture_room (number, floor, building)
);

CREATE TABLE lecture
(
    subject_name    TEXT      NOT NULL,
    academic_year   DATE      NOT NULL,
    degree          TEXT      NOT NULL,

    subgroup        SMALLINT  NOT NULL DEFAULT -1,

    professor_email TEXT      NOT NULL,

    room_number     SMALLINT  NOT NULL,
    room_floor      SMALLINT  NOT NULL,
    room_building   TEXT      NOT NULL,

    start_date      TIMESTAMP NOT NULL,
    end_date        TIMESTAMP NOT NULL,

    PRIMARY KEY (subject_name, academic_year, degree, start_date, subgroup),
    FOREIGN KEY (subject_name, academic_year, degree) REFERENCES subject (name, academic_year, degree),
    FOREIGN KEY (professor_email) REFERENCES professor (email),
    FOREIGN KEY (room_number, room_floor, room_building) REFERENCES lecture_room (number, floor, building)
);

CREATE TABLE subject_enrollment
(
    ldap          CHAR(6)  NOT NULL,

    subject_name  TEXT     NOT NULL,
    academic_year DATE     NOT NULL,
    degree        TEXT     NOT NULL,

    subgroup      SMALLINT NOT NULL,

    PRIMARY KEY (ldap, subject_name, academic_year, degree),
    FOREIGN KEY (ldap) REFERENCES student (ldap),
    FOREIGN KEY (subject_name, academic_year, degree) REFERENCES subject (name, academic_year, degree)
);