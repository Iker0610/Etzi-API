CREATE TABLE student
(
    ldap          CHAR(6)     NOT NULL,
    password      bytea       NOT NULL,

    name          VARCHAR(30) NOT NULL,
    surname       VARCHAR(40) NOT NULL,
    email         TEXT        NOT NULL,

    profile_image TEXT        NOT NULL DEFAULT '/etzi/images/placeholder.png',

    PRIMARY KEY (ldap)
);

CREATE TABLE academic_year
(
    start_date DATE NOT NULL,
    end_date   DATE NOT NULL,

    PRIMARY KEY (start_date)
);

CREATE TABLE lecture
(
    name          TEXT        NOT NULL,
    credits       SMALLINT    NOT NULL,
    type          VARCHAR(20) NOT NULL,

    academic_year DATE        NOT NULL,

    PRIMARY KEY (name, academic_year),
    FOREIGN KEY (academic_year) REFERENCES academic_year (start_date)
);

CREATE TABLE lecture_call
(
    lecture_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    call_type     VARCHAR(12) NOT NULL,
    exam_date     TIMESTAMP   NOT NULL,

    PRIMARY KEY (lecture_name, academic_year, call_type),
    FOREIGN KEY (lecture_name, academic_year) REFERENCES lecture (name, academic_year)
);

CREATE TABLE lecture_call_attendance
(
    student_ldap  CHAR(6)     NOT NULL,
    lecture_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    call_type     VARCHAR(12) NOT NULL,

    PRIMARY KEY (student_ldap, lecture_name, academic_year, call_type),
    FOREIGN KEY (student_ldap) REFERENCES student (ldap),
    FOREIGN KEY (lecture_name, academic_year, call_type) REFERENCES lecture_call (lecture_name, academic_year, call_type)
);

CREATE TABLE building
(
    id        TEXT NOT NULL,
    name      TEXT NOT NULL,
    direction TEXT NOT NULL,

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

CREATE TABLE tutorials
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

-- TODO: FINISH: Add lecture info
CREATE TABLE lecture_class
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


--------------------------------------------------------
--Students
INSERT INTO student (ldap, password, name, surname, email)
VALUES ('987654', 'alguna', 'Sub', 'Woolfer', 'swoolfer@ikasle.ehu.eus');

INSERT INTO student (ldap, password, name, surname, email)
VALUES ('900900', 'ya se verá', 'Rosa', 'Linn', 'rlinn001@ikasle.ehu.eus');

INSERT INTO student (ldap, password, name, surname, email)
VALUES ('123456', 'ya se verá', 'Citi', 'Zeni', 'czeni001@ikasle.ehu.eus');
--Academic year
INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2021', 'DD-MM-YYYY'), TO_DATE('31-07-2022', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2020', 'DD-MM-YYYY'), TO_DATE('31-07-2021', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2019', 'DD-MM-YYYY'), TO_DATE('31-07-2020', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2018', 'DD-MM-YYYY'), TO_DATE('31-07-2019', 'DD-MM-YYYY'));

-- Lectures
-- 1st year
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Análisis matemático', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Cálculo', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Fundamentos de Tecnología de Computadores', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Estructura de Computadores', 6, 'Obligatoria', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Matemática Discreta', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Principios de Diseño de Sistemas Digitales', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Programación básica', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Metodología de la programación', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Programación modular y orientación a objetos', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Álgebra', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'));

-- 2nd year
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Arquitectura de computadores', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Economía y administración de empresas', 6, 'Básica de rama', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Estructuras de datos y algoritmos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Ingeniería del software', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Lenguajes, computación y sistemas inteligentes', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Introducción a los sistemas operativos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Investigación operativa', 6, 'Básica de rama', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Introducción a las redes de computadores', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Métodos estadísticos de la ingeniería', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'));

-- 3rd year
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Análisis y diseño de sistemas de información', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Diseño de bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Organización de la producción', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Sistemas de gestión integrada', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Sistemas de Gestión de seguridad de sistemas de información', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Administración de bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Gestión de proyectos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Sistemas web', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Sistemas de apoyo a la decisión', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Software de gestión de empresa', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'));

-- 4th year
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Minería de datos', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Administración de sistemas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Aspectos profesionales de la informática', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Norma y uso de la lengua vasca', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Programación práctica de PLCs', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Redes y servicios móviles', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Regulación automática', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Servicios multimedia', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Técnicas de inteligencia artificial', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Comunicación en euskera: áreas técnicas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Desarrollo avanzado de software', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Desarrollo de aplicaciones web enriquecidas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Despliegue y gestión de redes y servicios', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('English for information technology', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Modelado y simulación de sistemas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Robótica', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Servicios telemáticos avanzados', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Software para matemática aplicada', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));
INSERT INTO lecture (name, credits, type, academic_year)
VALUES ('Trabajo fin de grado', 12, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'));