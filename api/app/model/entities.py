from sqlalchemy import Column, String, VARCHAR, LargeBinary

from .database import Base


class User(Base):
    __tablename__ = "users"

    ldap = Column(VARCHAR(length=20), name="ldap", primary_key=True, index=True)
    hashed_password = Column(LargeBinary, name='password')
    profile_image_url = Column(String, name='profile_image', default="/etzi/images/placeholder.png")
