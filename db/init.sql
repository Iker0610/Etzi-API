CREATE TABLE users
(
    ldap          CHAR(6),
    password      bytea,
    profile_image TEXT,

    PRIMARY KEY (ldap)
)
