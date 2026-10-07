CREATE USER projeto@localhost IDENTIFIED BY 'PLACEHOLDER';
GRANT ALL ON agrodados.* TO projeto@localhost;
SHOW GRANTS FOR projeto@localhost;