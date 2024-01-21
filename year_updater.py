import re
from datetime import datetime
from datetime import date, timedelta
from pathlib import Path
from dateutil import relativedelta

BASE_PATH = Path(r'E:\DEV\UNI\DAS\Etzi\API\db\scripts')
SQL_FILES = [
    '1_Init_DML.sql',
    '2_Subjects.sql',
    '3_Subject_call.sql',
    '4_Lectures.sql',
    '5_Subject_call_attendance.sql',
    '6_Subject_enrollment.sql',
]

DD_MM_YYYY_RE = re.compile(r'(\d{2}-\d{2}-\d{4})')
YYYY_MM_DD_RE = re.compile(r'(\d{4}-\d{2}-\d{2})')

YEAR_DIFFERENCE = 1


def get_new_date(old_date) -> date:
    new_year_value = old_date.year + YEAR_DIFFERENCE
    if old_date.month == 9 and old_date.day == 1:
        return date(new_year_value, old_date.month, old_date.day)
    else:
        # Return the same weekday as the original year
        delta = relativedelta.relativedelta(years=YEAR_DIFFERENCE, year=old_date.year, month=old_date.month, day=old_date.day, weekday=relativedelta.weekdays[old_date.weekday()](-1))
        new_date = old_date + delta
        return new_date


def update_year(sql_file):
    with open(sql_file, 'r', encoding='utf8') as f:
        sql = f.read()

    # --------------------------------------
    # Update years with the format 'DD-MM-YY'
    # Get all the years with the format 'DD-MM-YYYY'
    years = DD_MM_YYYY_RE.findall(sql)

    # Parse the years to datetime objects
    years = [datetime.strptime(year, '%d-%m-%Y') for year in years]

    # Update the years
    years_updated = [get_new_date(year) for year in years]

    # Replace the years in the sql
    sql = DD_MM_YYYY_RE.sub(lambda _: years_updated.pop(0).strftime('%d-%m-%Y'), sql)

    # --------------------------------------
    # Update years with the format 'YYYY-MM-DD'
    # Get all the years with the format 'YYYY-MM-DD'
    years = YYYY_MM_DD_RE.findall(sql)

    # Parse the years to datetime objects
    years = [datetime.strptime(year, '%Y-%m-%d') for year in years]

    # Update the years
    years_updated = [get_new_date(year) for year in years]

    # Replace the years in the sql
    sql = YYYY_MM_DD_RE.sub(lambda _: years_updated.pop(0).strftime('%Y-%m-%d'), sql)

    # --------------------------------------
    # Write the updated sql
    with open(sql_file.with_suffix('.sql'), 'w', encoding='utf8') as f:
        f.write(sql)
    pass

    # --------------------------------------


if __name__ == '__main__':
    for _sql_file in SQL_FILES:
        update_year(BASE_PATH / _sql_file)
