CREATE USER dev
IDENTIFIED BY dev
DEFAULT TABLESPACE users;

GRANT CONNECT, RESOURCE TO dev;