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
