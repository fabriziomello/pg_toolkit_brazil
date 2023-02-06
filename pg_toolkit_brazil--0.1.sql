/* pg_toolkit_brazil/pg_toolkit_brazil--0.1.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_toolkit_brazil" to load this file. \quit

CREATE TYPE cpf;

--
--  Input and output functions.
--
CREATE FUNCTION cpfin(cstring)
RETURNS cpf
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpfout(cpf)
RETURNS cstring
AS 'MODULE_PATHNAME'    
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpfrecv(internal)
RETURNS cpf
AS 'int8recv'
LANGUAGE internal STABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpfsend(cpf)
RETURNS bytea
AS 'int8send'
LANGUAGE internal STABLE STRICT PARALLEL SAFE;

--
--  Type definition
--
CREATE TYPE cpf (
    INPUT   = cpfin,
    OUTPUT  = cpfout,
    RECEIVE = cpfrecv,
    SEND    = cpfsend,
    LIKE    = int8
);

CREATE TYPE cnpj;

--
--  Input and output functions.
--
CREATE FUNCTION cnpjin(cstring)
RETURNS cnpj
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpjout(cnpj)
RETURNS cstring
AS 'MODULE_PATHNAME'    
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpjrecv(internal)
RETURNS cnpj
AS 'int8recv'
LANGUAGE internal STABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpjsend(cnpj)
RETURNS bytea
AS 'int8send'
LANGUAGE internal STABLE STRICT PARALLEL SAFE;

--
--  Type definition
--
CREATE TYPE cnpj (
    INPUT   = cnpjin,
    OUTPUT  = cnpjout,
    RECEIVE = cnpjrecv,
    SEND    = cnpjsend,
    LIKE    = int8
);
