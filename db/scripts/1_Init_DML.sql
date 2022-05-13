/*  DATA  */

-- Degree
INSERT INTO degree (name)
VALUES ('Grado en Ingeniería Informática de Gestión y Sistemas de Información');

--Students
INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('987654', 'alguna', 'Sub', 'Woolfer', 'swoolfer001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('900900', 'ya se verá', 'Rosa', 'Linn', 'rlinn001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('123456', 'ya se verá', 'Citi', 'Zeni', 'czeni001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');
--Academic year
INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2021', 'DD-MM-YYYY'), TO_DATE('31-07-2022', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2020', 'DD-MM-YYYY'), TO_DATE('31-07-2021', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2019', 'DD-MM-YYYY'), TO_DATE('31-07-2020', 'DD-MM-YYYY'));

INSERT INTO academic_year (start_date, end_date)
VALUES (TO_DATE('01-09-2018', 'DD-MM-YYYY'), TO_DATE('31-07-2019', 'DD-MM-YYYY'));

-- Lecture rooms
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 3, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 3, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (20, 3, 1); -- Koldobika Gojenola
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 2, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 2, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 2, 1); -- Alicia Pérez
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 1, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 1, 1);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 1, 1); -- Aitziber Atutxa

INSERT INTO lecture_room (number, floor, building)
VALUES (10, 3, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 3, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (20, 3, 2); -- Iker Sobrón
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 2, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 2, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 2, 2); -- Mikel Villamañe
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 1, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 1, 2);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 1, 2);
-- María Luz Álvarez

-- Profesors
INSERT INTO professor (name, surname, email)
VALUES ('Alicia', 'Pérez', 'alicia.perez@ehu.eus');
INSERT INTO professor (name, surname, email)
VALUES ('Aitziber', 'Atutxa', 'aitziber.atutxa@ehu.eus');
INSERT INTO professor (name, surname, email)
VALUES ('Koldobika', 'Gojenola', 'koldo.gojenola@ehu.eus');

INSERT INTO professor (name, surname, email)
VALUES ('Iker', 'Sobrón', 'iker.sobron@ehu.eus');
INSERT INTO professor (name, surname, email)
VALUES ('Mikel', 'Villamañe', 'mikel.villamane@ehu.eus');
INSERT INTO professor (name, surname, email)
VALUES ('María Luz', 'Álvarez', 'marialuz.alvarez@ehu.eus');

-- Tutorials
-- Alicia
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('alicia.perez@ehu.eus', 23, 2, 1, '2022-05-30 15:00:00', '2022-05-30 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('alicia.perez@ehu.eus', 23, 2, 1, '2022-06-02 16:00:00', '2022-06-02 18:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('alicia.perez@ehu.eus', 23, 2, 1, '2022-06-04 15:00:00', '2022-05-04 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('alicia.perez@ehu.eus', 23, 2, 1, '2022-06-09 16:00:00', '2022-06-09 18:00:00');
-- Iker
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('iker.sobron@ehu.eus', 20, 3, 2, '2022-05-27 11:00:00', '2022-05-27 14:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('iker.sobron@ehu.eus', 20, 3, 2, '2022-06-01 11:00:00', '2022-06-03 14:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('iker.sobron@ehu.eus', 20, 3, 2, '2022-06-03 11:00:00', '2022-06-03 14:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('iker.sobron@ehu.eus', 20, 3, 2, '2022-06-09 11:00:00', '2022-06-09 14:00:00');
-- Mikel
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('mikel.villamane@ehu.eus', 23, 2, 2, '2022-05-30 15:00:00', '2022-05-30 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('mikel.villamane@ehu.eus', 23, 2, 2, '2022-06-02 16:00:00', '2022-06-02 18:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('mikel.villamane@ehu.eus', 23, 2, 2, '2022-06-04 15:00:00', '2022-05-04 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('mikel.villamane@ehu.eus', 23, 2, 2, '2022-06-09 16:00:00', '2022-06-09 18:00:00');
-- Mariluz
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('marialuz.alvarez@ehu.eus', 23, 1, 2, '2022-05-30 15:00:00', '2022-05-30 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('marialuz.alvarez@ehu.eus', 23, 1, 2, '2022-06-02 16:00:00', '2022-06-02 18:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('marialuz.alvarez@ehu.eus', 23, 1, 2, '2022-06-04 15:00:00', '2022-05-04 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('marialuz.alvarez@ehu.eus', 23, 1, 2, '2022-06-09 16:00:00', '2022-06-09 18:00:00');
-- Aitziber
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('aitziber.atutxa@ehu.eus', 23, 2, 1, '2022-05-30 15:00:00', '2022-05-30 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('aitziber.atutxa@ehu.eus', 23, 2, 1, '2022-06-02 16:00:00', '2022-06-02 18:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('aitziber.atutxa@ehu.eus', 23, 2, 1, '2022-06-04 15:00:00', '2022-05-04 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('aitziber.atutxa@ehu.eus', 23, 2, 1, '2022-06-09 16:00:00', '2022-06-09 18:00:00');
-- Koldo
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('koldo.gojenola@ehu.eus', 20, 3, 1, '2022-05-30 15:00:00', '2022-05-30 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('koldo.gojenola@ehu.eus', 20, 3, 1, '2022-06-02 16:00:00', '2022-06-02 18:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('koldo.gojenola@ehu.eus', 20, 3, 1, '2022-06-04 15:00:00', '2022-05-04 17:00:00');
INSERT INTO tutorial (professor_email, room_number, room_floor, room_building, start_date, end_date)
VALUES ('koldo.gojenola@ehu.eus', 20, 3, 1, '2022-06-09 16:00:00', '2022-06-09 18:00:00');


-- Subject Enrollment
/*
    INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('987654', 'alguna', 'Sub', 'Woolfer', 'swoolfer001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('900900', 'ya se verá', 'Rosa', 'Linn', 'rlinn001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('123456', 'ya se verá', 'Citi', 'Zeni', 'czeni001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');*/
INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('987654', 'Minería de datos', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('987654', 'Norma y uso de la lengua vasca', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', -1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('987654', 'Desarrollo avanzado de software', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 2);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('987654', 'Servicios telemáticos avanzados', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);


INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('900900', 'Minería de datos', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 2);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('900900', 'Técnicas de inteligencia artificial', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('900900', 'Robótica', '2022-09-07', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('900900', 'Despliegue y gestión de redes y servicios', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);


INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('123456', 'Minería de datos', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 2);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('123456', 'Administración de sistemas', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('123456', 'Comunicación en euskera: áreas técnicas', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 1);

INSERT INTO lecture_enrollment (ldap, lecture_name, academic_year, degree, subgroup)
VALUES ('123456', 'English for information technology', '2022-09-07',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información', -1);
