CREATE TABLE empresa(cnpj cnpj);
\d empresa

-- Banco do Brasil's cnpj
INSERT INTO empresa VALUES (cnpj '00000000000191');
-- Petrobras' cnpj
INSERT INTO empresa VALUES (cnpj '33000167066129');
-- Eletrobras' cnpj
INSERT INTO empresa VALUES (cnpj '00.001.180/0001-26');
SELECT * FROM empresa ORDER BY cnpj;

-- Invalid digit
SELECT cnpj '00000000000001';

-- cnpj bigger than expected
SELECT cnpj '100000000000191';

-- Formatted cnpj
SELECT cnpj '33.000.167/0661-29';

-- Invalid format
SELECT cnpj '33000.167/0661-29';

-- bigint cast
SELECT 33000167066129::cnpj;

-- operators
SELECT cnpj '00000000000191' = cnpj '00.001.180/0001-26';
SELECT cnpj '00000000000191' <> cnpj '00.001.180/0001-26';
SELECT cnpj '00000000000191' < cnpj '00.001.180/0001-26';
SELECT cnpj '00000000000191' <= cnpj '00.001.180/0001-26';
SELECT cnpj '00000000000191' >= cnpj '00.001.180/0001-26';
SELECT cnpj '00000000000191' > cnpj '00.001.180/0001-26';
