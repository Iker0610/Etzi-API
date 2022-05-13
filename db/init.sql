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

CREATE TABLE lecture
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

CREATE TABLE lecture_call
(
    lecture_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    degree        TEXT        NOT NULL,

    call_type     VARCHAR(12) NOT NULL,
    exam_date     TIMESTAMP   NOT NULL,

    PRIMARY KEY (lecture_name, academic_year, degree, call_type),
    FOREIGN KEY (lecture_name, academic_year, degree) REFERENCES lecture (name, academic_year, degree)
);

CREATE TABLE lecture_call_attendance
(
    student_ldap  CHAR(6)     NOT NULL,

    lecture_name  TEXT        NOT NULL,
    academic_year DATE        NOT NULL,
    degree        TEXT        NOT NULL,

    call_type     VARCHAR(12) NOT NULL,

    PRIMARY KEY (student_ldap, lecture_name, academic_year, degree, call_type),
    FOREIGN KEY (student_ldap) REFERENCES student (ldap),
    FOREIGN KEY (lecture_name, academic_year, degree, call_type) REFERENCES lecture_call (lecture_name, academic_year, degree, call_type)
);

CREATE TABLE building
(
    id           TEXT NOT NULL,
    abbreviation TEXT NOT NULL,
    name         TEXT NOT NULL,
    direction    TEXT NOT NULL,

    PRIMARY KEY (id, direction)
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

CREATE TABLE lecture_class
(
    lecture_name    TEXT      NOT NULL,
    academic_year   DATE      NOT NULL,
    degree          TEXT      NOT NULL,

    subgroup        SMALLINT  NOT NULL,

    professor_email TEXT      NOT NULL,

    room_number     SMALLINT  NOT NULL,
    room_floor      SMALLINT  NOT NULL,
    room_building   TEXT      NOT NULL,

    start_date      TIMESTAMP NOT NULL,
    end_date        TIMESTAMP NOT NULL,

    PRIMARY KEY (lecture_name, academic_year, degree, start_date, subgroup),
    FOREIGN KEY (lecture_name, academic_year, degree) REFERENCES lecture (name, academic_year, degree),
    FOREIGN KEY (professor_email) REFERENCES professor (email),
    FOREIGN KEY (room_number, room_floor, room_building) REFERENCES lecture_room (number, floor, building)
);

CREATE TABLE lecture_enrollment
(
    ldap          CHAR(6)  NOT NULL,

    lecture_name  TEXT     NOT NULL,
    academic_year DATE     NOT NULL,
    degree        TEXT     NOT NULL,

    subgroup      SMALLINT NOT NULL,

    PRIMARY KEY (ldap, lecture_name, academic_year, degree),
    FOREIGN KEY (ldap) REFERENCES student (ldap),
    FOREIGN KEY (lecture_name, academic_year, degree) REFERENCES lecture (name, academic_year, degree)
);

--------------------------------------------------------
/*  DATA  */

-- Degree
INSERT INTO degree (name)
VALUES ('Grado en Ingeniería Informática de Gestión y Sistemas de Información');

--Students
INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('987654', 'alguna', 'Sub', 'Woolfer', 'swoolfer@ikasle.ehu.eus', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('900900', 'ya se verá', 'Rosa', 'Linn', 'rlinn001@ikasle.ehu.eus', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('123456', 'ya se verá', 'Citi', 'Zeni', 'czeni001@ikasle.ehu.eus', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
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
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Análisis matemático', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Cálculo', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Fundamentos de Tecnología de Computadores', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Estructura de Computadores', 6, 'Obligatoria', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Matemática Discreta', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Principios de Diseño de Sistemas Digitales', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Programación básica', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Metodología de la programación', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Programación modular y orientación a objetos', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Álgebra', 6, 'Básica de rama', TO_DATE('01-09-2018', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

-- 2nd year
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Arquitectura de computadores', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Economía y administración de empresas', 6, 'Básica de rama', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Estructuras de datos y algoritmos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Ingeniería del software', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Lenguajes, computación y sistemas inteligentes', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Introducción a los sistemas operativos', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Investigación operativa', 6, 'Básica de rama', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Introducción a las redes de computadores', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Métodos estadísticos de la ingeniería', 6, 'Obligatoria', TO_DATE('01-09-2019', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

-- 3rd year
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Análisis y diseño de sistemas de información', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Diseño de bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Organización de la producción', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Sistemas de gestión integrada', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Sistemas de Gestión de seguridad de sistemas de información', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Administración de bases de datos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Gestión de proyectos', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Sistemas web', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Sistemas de apoyo a la decisión', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Software de gestión de empresa', 6, 'Obligatoria', TO_DATE('01-09-2020', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

-- 4th year
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Minería de datos', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Administración de sistemas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Aspectos profesionales de la informática', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Norma y uso de la lengua vasca', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Programación práctica de PLCs', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Redes y servicios móviles', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Regulación automática', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Servicios multimedia', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Técnicas de inteligencia artificial', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Comunicación en euskera: áreas técnicas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Desarrollo avanzado de software', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Desarrollo de aplicaciones web enriquecidas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Despliegue y gestión de redes y servicios', 4, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('English for information technology', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Modelado y simulación de sistemas', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Robótica', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Servicios telemáticos avanzados', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Software para matemática aplicada', 6, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
INSERT INTO lecture (name, credits, type, academic_year, degree)
VALUES ('Trabajo fin de grado', 12, 'Optativa', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información');