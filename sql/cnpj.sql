CREATE EXTENSION pg_toolkit_brazil;

CREATE TABLE empresa(cnpj cnpj);
\d empresa
INSERT INTO empresa VALUES (cnpj '00000000000000');
SELECT * FROM empresa;

DELETE FROM empresa;
INSERT INTO empresa VALUES (cnpj '33000167066129');
SELECT * FROM empresa;
SELECT cnpj '00000000000001';
