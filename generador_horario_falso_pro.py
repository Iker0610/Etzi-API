import random
from datetime import date, timedelta, datetime

intro_sql = 'INSERT INTO lecture_class (lecture_name, academic_year, degree, subgroup, professor_email, room_number, room_floor, room_building, start_date, end_date)'

professors = ['alicia.perez@ehu.eus', 'aitziber.atutxa@ehu.eus', 'koldo.gojenola@ehu.eus', 'iker.sobron@ehu.eus', 'mikel.villamane@ehu.eus', 'marialuz.alvarez@ehu.eus']
aulas = [[10, 3, 1], [12, 3, 1], [10, 2, 1], [12, 2, 1], [10, 1, 1], [12, 1, 1], [10, 3, 2], [12, 3, 2], [10, 2, 2], [12, 2, 2], [10, 1, 2], [12, 1, 2]]
asignaturas = {
    'Minería de datos': {
        'profesores': ['alicia.perez@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[0]},
            {'dia_semana': 3, 'hora': 15, 'minuto': 0, 'duracion': 1, 'grupo': -1, 'room': aulas[0]},
            {'dia_semana': 2, 'hora': 17, 'minuto': 0, 'duracion': 2, 'grupo': 1, 'room': aulas[3]},
            {'dia_semana': 2, 'hora': 15, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[3]},
        ]
    },
    'Administración de sistemas': {
        'profesores': ['aitziber.atutxa@ehu.eus', 'iker.sobron@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[0]},
            {'dia_semana': 2, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': 1, 'room': aulas[0]},
            {'dia_semana': 3, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': 2, 'room': aulas[0]},
        ]
    },
    'Aspectos profesionales de la informática': {
        'profesores': ['mikel.villamane@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[2]},
            {'dia_semana': 2, 'hora': 15, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[3]},
        ]
    },
    'Norma y uso de la lengua vasca': {
        'profesores': ['mikel.villamane@ehu.eus', 'koldo.gojenola@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 2, 'hora': 8, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[2]},
            {'dia_semana': 4, 'hora': 8, 'minuto': 0, 'duracion': 1, 'grupo': -1, 'room': aulas[3]},
        ]
    },
    'Programación práctica de PLCs': {
        'profesores': ['marialuz.alvarez@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[7]},
            {'dia_semana': 1, 'hora': 18, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[4]},
            {'dia_semana': 2, 'hora': 18, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[6]},

        ]
    },
    'Redes y servicios móviles': {
        'profesores': ['marialuz.alvarez@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[5]},
            {'dia_semana': 3, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': 1, 'room': aulas[3]},
            {'dia_semana': 4, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': 2, 'room': aulas[2]},
        ]
    },
    'Regulación automática': {
        'profesores': ['aitziber.atutxa@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[3]},
            {'dia_semana': 0, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': 1, 'room': aulas[4]},
            {'dia_semana': 1, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': 2, 'room': aulas[6]},
        ]
    },
    'Servicios multimedia': {
        'profesores': ['koldo.gojenola@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 18, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[2]},
            {'dia_semana': 0, 'hora': 20, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[10]},
            {'dia_semana': 1, 'hora': 20, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[8]},
        ]
    },
    'Técnicas de inteligencia artificial': {
        'profesores': ['aitziber.atutxa@ehu.eus', 'koldo.gojenola@ehu.eus'],
        'cuatri': 1,
        'clases': [
            {'dia_semana': 0, 'hora': 10, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[7]},
            {'dia_semana': 0, 'hora': 12, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[6]},
            {'dia_semana': 1, 'hora': 12, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[4]},
        ]
    },
    'Comunicación en euskera: áreas técnicas': {
        'profesores': ['mikel.villamane@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 0, 'hora': 8, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[2]},
            {'dia_semana': 0, 'hora': 10, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[0]},
            {'dia_semana': 1, 'hora': 10, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[0]},
        ]
    },
    'Desarrollo avanzado de software': {
        'profesores': ['iker.sobron@ehu.eus', 'mikel.villamane@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 1, 'hora': 15, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[0]},
            {'dia_semana': 2, 'hora': 15, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[0]},
            {'dia_semana': 3, 'hora': 15, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[0]},
        ]
    },
    'Desarrollo de aplicaciones web enriquecidas': {
        'profesores': ['mikel.villamane@ehu.eus'],
        'cuatri': 2,
        'clases': []
    },
    'Despliegue y gestión de redes y servicios': {
        'profesores': ['alicia.perez@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 4, 'hora': 9, 'minuto': 0, 'duracion': 3, 'grupo': -1, 'room': aulas[9]},
            {'dia_semana': 1, 'hora': 11, 'minuto': 0, 'duracion': 1, 'grupo': -1, 'room': aulas[9]},
            {'dia_semana': 3, 'hora': 12, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[3]},
            {'dia_semana': 3, 'hora': 14, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[3]},
        ]
    },
    'English for information technology': {
        'profesores': ['aitziber.atutxa@ehu.eus', 'alicia.perez@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 3, 'hora': 10, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[5]},
            {'dia_semana': 4, 'hora': 10, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[5]},
        ]
    },
    'Modelado y simulación de sistemas': {
        'profesores': ['iker.sobron@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 4, 'hora': 18, 'minuto': 0, 'duracion': 3, 'grupo': -1, 'room': aulas[2]},
            {'dia_semana': 0, 'hora': 10, 'minuto': 0, 'duracion': 2, 'grupo': 1, 'room': aulas[3]},
            {'dia_semana': 0, 'hora': 12, 'minuto': 0, 'duracion': 2, 'grupo': 2, 'room': aulas[3]},
        ]
    },
    'Robótica': {
        'profesores': ['koldo.gojenola@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 2, 'hora': 9, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[5]},
            {'dia_semana': 1, 'hora': 11, 'minuto': 0, 'duracion': 1, 'grupo': -1, 'room': aulas[5]},
            {'dia_semana': 2, 'hora': 13, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[6]},
            {'dia_semana': 2, 'hora': 14, 'minuto': 0, 'duracion': 1, 'grupo': 2, 'room': aulas[6]},
        ]
    },
    'Servicios telemáticos avanzados': {
        'profesores': ['marialuz.alvarez@ehu.eus'],
        'cuatri': 2,
        'clases': [
            {'dia_semana': 2, 'hora': 9, 'minuto': 0, 'duracion': 2, 'grupo': -1, 'room': aulas[10]},
            {'dia_semana': 3, 'hora': 11, 'minuto': 0, 'duracion': 1, 'grupo': -1, 'room': aulas[10]},
            {'dia_semana': 3, 'hora': 13, 'minuto': 0, 'duracion': 1, 'grupo': 1, 'room': aulas[9]},
        ]
    },
    'Software para matemática aplicada': {
        'profesores': ['alicia.perez@ehu.eus', 'mikel.villamane@ehu.eus'],
        'cuatri': 2,
        'clases': []
    },
}


# ----------------------------------------------------------------------------------------------------------------------

def lista_fechas(inicio: date, fin: date):
    delta = fin - inicio
    return [(inicio + timedelta(days=i)) for i in range(delta.days + 1) if (inicio + timedelta(days=i)).weekday() < 5]


def generar_fechas_falsas() -> tuple[list[date], list[date]]:
    lista_fechas_primer_cuatri = lista_fechas(date(2021, 9, 7), date(2021, 12, 22))
    lista_fechas_segundo_cuatri = lista_fechas(date(2022, 1, 24), date(2022, 5, 29))

    return lista_fechas_primer_cuatri, lista_fechas_segundo_cuatri


# ----------------------------------------------------------------------------------------------------------------------


if __name__ == '__main__':
    listas_fechas = generar_fechas_falsas()

    with open('./db/horario.sql', 'w', encoding='utf8') as f:
        for subject, data in asignaturas.items():
            lista_fechas: list[date] = listas_fechas[data['cuatri'] - 1]
            for date_ in iter(lista_fechas):
                weekday = date_.weekday()

                for clase in data['clases']:
                    if clase['dia_semana'] == weekday:
                        start_time = datetime(date_.year, date_.month, date_.day, clase['hora'], clase['minuto'])
                        end_time = start_time + timedelta(hours=clase['duracion'])

                        f.write(intro_sql + '\n')
                        f.write(f"VALUES ('{subject}', TO_DATE('01-09-2021', 'DD-MM-YYYY'), 'Grado en Ingeniería Informática de Gestión y Sistemas de Información', '{clase['grupo']}', '{random.choice(data['profesores'])}', {clase['room'][0]}, {clase['room'][1]}, '{clase['room'][2]}', '{start_time.strftime('%Y-%m-%d %H:%M:%S')}', '{end_time.strftime('%Y-%m-%d %H:%M:%S')}');")
                        f.write('\n\n')
