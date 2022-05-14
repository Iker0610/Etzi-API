import random
from datetime import date, timedelta, datetime

intro_sql = 'INSERT INTO subject_call_attendance (student_ldap, subject_name, academic_year, degree, call_type, grade, distinction)'

alumnos = ['987654', '900900', '123456']

asignarturas = {
    'Primero': ['Análisis matemático', 'Cálculo', 'Fundamentos de Tecnología de Computadores',
                'Estructura de Computadores', 'Matemática Discreta', 'Principios de Diseño de Sistemas Digitales',
                'Programación básica', 'Metodología de la programación', 'Programación modular y orientación a objetos',
                'Álgebra'],
    'Segundo': ['Arquitectura de computadores', 'Bases de datos', 'Economía y administración de empresas',
                'Estructuras de datos y algoritmos', 'Ingeniería del software',
                'Lenguajes, computación y sistemas inteligentes', 'Introducción a los sistemas operativos',
                'Investigación operativa', 'Introducción a las redes de computadores',
                'Métodos estadísticos de la ingeniería'],
    'Tercero': ['Análisis y diseño de sistemas de información', 'Diseño de bases de datos',
                'Organización de la producción', 'Sistemas de gestión integrada',
                'Sistemas de Gestión de seguridad de sistemas de información', 'Administración de bases de datos',
                'Gestión de proyectos', 'Sistemas web', 'Sistemas de apoyo a la decisión',
                'Software de gestión de empresa'],
    'Cuarto': ['Minería de datos', 'Administración de sistemas', 'Aspectos profesionales de la informática',
               'Norma y uso de la lengua vasca', 'Programación práctica de PLCs', 'Redes y servicios móviles',
               'Regulación automática', 'Servicios multimedia', 'Técnicas de inteligencia artificial',
               'Comunicación en euskera: áreas técnicas', 'Desarrollo avanzado de software',
               'Desarrollo de aplicaciones web enriquecidas', 'Despliegue y gestión de redes y servicios',
               'English for information technology', 'Modelado y simulación de sistemas', 'Robótica',
               'Servicios telemáticos avanzados', 'Software para matemática aplicada'
               ]
}
anios = {
    'Primero': '2018-09-07',
    'Segundo': '2019-09-07',
    'Tercero': '2020-09-07',
    'Cuarto': '2021-09-07'
}

call_type = ['Ordinaria', 'Extraordinaria']

subgroup = {
    'Minería de datos': [1, 2],
    'Administración de sistemas': [1, 2],
    'Aspectos profesionales de la informática': [1],
    'Norma y uso de la lengua vasca': [-1],
    'Programación práctica de PLCs': [1, 2],
    'Redes y servicios móviles': [1, 2],
    'Regulación automática': [1, 2],
    'Servicios multimedia': [1, 2],
    'Técnicas de inteligencia artificial': [1, 2],
    'Comunicación en euskera: áreas técnicas': [1, 2],
    'Desarrollo avanzado de software': [1, 2],
    'Desarrollo de aplicaciones web enriquecidas': [-1],
    'Despliegue y gestión de redes y servicios': [1, 2],
    'English for information technology': [-1],
    'Modelado y simulación de sistemas': [1, 2],
    'Robótica': [1, 2],
    'Servicios telemáticos avanzados': [1],
    'Software para matemática aplicada': [-1]
}

# ----------------------------------------------------------------------------------------------------------------------


if __name__ == '__main__':
    alum_subject = {
        'Primero': {
            '987654': [],
            '900900': [],
            '123456': []
        },
        'Segundo': {
            '987654': [],
            '900900': [],
            '123456': []
        },
        'Tercero': {
            '987654': [],
            '900900': [],
            '123456': []
        },
        'Cuarto': {
            '987654': [],
            '900900': [],
            '123456': []
        }
    }
    subject_enrrollment = ''

    for year, subjects in asignarturas.items():
        for user in alumnos:
            if year != 'Cuarto':
                for i in range(9):
                    subject = random.choice(subjects)
                    alum_subject[year][user].append(subject)
                    subject_enrrollment += f"INSERT INTO subject_enrollment (ldap, lecture_name, academic_year, degree, subgroup) VALUES ('{user}', '{subject}', '{anios[year]}', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', -1) \n\n"
            else:
                for i in range(5):
                    subject = random.choice(subjects)
                    alum_subject[year][user].append(subject)
                    subject_enrrollment += f"INSERT INTO subject_enrollment (ldap, lecture_name, academic_year, degree, subgroup) VALUES ('{user}', '{subject}', '{anios[year]}', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', {random.choice(subgroup[subject])}) \n\n"

    with open('./db/6_Subject_enrollment.sql', 'w', encoding='utf8') as file:
        file.write(subject_enrrollment)

    subject_enrrollment_call = ''
    for year, subjects in asignarturas.items():
        for user in alumnos:
            for subject in alum_subject[year][user]:
                conv = random.choice(call_type)
                nota = round(random.uniform(0, 10), 1)
                if nota < 5:
                    subject_enrrollment_call += f"INSERT INTO subject_call_attendance (student_ldap, subject_name, academic_year, degree, call_type, grade, distinction) VALUES ('{user}', '{subject}', '{anios[year]}', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 'Ordinaria', '{nota}', false) \n\n"
                    notaextr = round(random.uniform(5, 10), 1)
                    matricula = 'false'
                    if notaextr > 9.5:
                        matricula = 'true'
                    subject_enrrollment_call += f"INSERT INTO subject_call_attendance (student_ldap, subject_name, academic_year, degree, call_type, grade, distinction) VALUES ('{user}', '{subject}', '{anios[year]}', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 'Extraordinaria', '{notaextr}', {matricula}) \n\n"

                else:
                    matricula = 'false'
                    if nota > 9.5:
                        matricula = 'true'
                    subject_enrrollment_call += f"INSERT INTO subject_call_attendance (student_ldap, subject_name, academic_year, degree, call_type, grade, distinction) VALUES ('{user}', '{subject}', '{anios[year]}', 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', 'Ordinaria', '{nota}', {matricula}) \n\n"

    with open('./db/5_Subject_call_attendance.sql', 'w', encoding='utf8') as file2:
        file2.write(subject_enrrollment_call)
