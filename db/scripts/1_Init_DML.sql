/*  DATA  */

-- Degree
INSERT INTO degree (name)
VALUES ('Grado en Ingeniería Informática de Gestión y Sistemas de Información');

--Students
INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('987654', '$2b$12$it1yAsTjOAhORqDfVHhVuORd0Lak7bPA81tquuaieOVrlWYF6iERu', 'Sub', 'Woolfer', 'swoolfer001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('900900', '$2b$12$sqI9UrJ8kkXu72bC0A3rmuMiaeMCa9r3zP17A9Zew0QByVlnmhZjy', 'Rosa', 'Linn', 'rlinn001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('123456', '$2b$12$GGXnub988UpgdPTVR4XFLeyh7wWMjFs7Dle6aZtdjcVzkJeSQWG5C', 'Citi', 'Zeni', 'czeni001@ikasle.ehu.eus',
        'Grado en Ingeniería Informática de Gestión y Sistemas de Información');

INSERT INTO student (ldap, password, name, surname, email, enrolled_degree)
VALUES ('915018', '$2b$12$i5q1V3D46r5H1RZsKGbWueLvjGZqwfiVr55rL0hN2hcrFfdui486y', 'Iria', 'San Miguel', 'isanmiguel008@ikasle.ehu.eus',
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


-- Buildings
INSERT INTO building (id, abbreviation, name, address)
VALUES ('1', 'I', 'EIB/BIE II - I',
        'Escuela de Ingeniería de Bilbao, Calle Rafael Moreno Pitxitxi, 2-3, 48013 Bilbao, Biscay');
INSERT INTO building (id, abbreviation, name, address)
VALUES ('2', 'M', 'EIB/BIE II - M', 'Escuela de Ingeniería de Bilbao, Calle Rafael Moreno Pitxitxi, 2-3, 48013 Bilbao, Biscay');


INSERT INTO building (id, abbreviation, name, address)
VALUES ('3', 'B', 'EIB/BIE I - B', 'Escuela de Ingeniería de Bilbao, Plaza Ingeniero Torres Quevedo, 1, 48013 Bilbao, Biscay');

INSERT INTO building (id, abbreviation, name, address)
VALUES ('4', 'D', 'EIB/BIE I - D', 'Escuela de Ingeniería de Bilbao, Ingeniero Torres Quevedo Plaza, 1, 48013 Bilbao, Biscay');

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

INSERT INTO lecture_room (number, floor, building)
VALUES (10, 3, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 3, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (20, 3, 3); -- Iker Sobrón
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 2, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 2, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 2, 3); -- Mikel Villamañe
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 1, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 1, 3);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 1, 3);

INSERT INTO lecture_room (number, floor, building)
VALUES (10, 3, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 3, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (20, 3, 4); -- Iker Sobrón
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 2, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 2, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 2, 4); -- Mikel Villamañe
INSERT INTO lecture_room (number, floor, building)
VALUES (10, 1, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (12, 1, 4);
INSERT INTO lecture_room (number, floor, building)
VALUES (23, 1, 4);

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

