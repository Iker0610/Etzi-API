from os import environ

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Variables de entorno
POSTGRES_USER = environ['POSTGRES_USER']
POSTGRES_PASSWORD = environ['POSTGRES_PASSWORD']
POSTGRES_IP = environ['POSTGRES_IP']
POSTGRES_DB = environ['POSTGRES_DB']

# Inicialización de la base de datos
SQLALCHEMY_DATABASE_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_IP}/{POSTGRES_DB}"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
