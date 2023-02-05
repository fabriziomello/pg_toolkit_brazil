CREATE EXTENSION pg_toolkit_brazil;

CREATE TABLE pessoa(cpf cpf);
\d pessoa
INSERT INTO pessoa VALUES (cpf '40100276300');
SELECT * FROM pessoa;
