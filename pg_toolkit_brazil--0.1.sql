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

--
--  Implicit and assignment type casts.
--

CREATE CAST (bigint AS cpf) WITHOUT FUNCTION AS IMPLICIT;

--
-- Operator Functions.
--

CREATE FUNCTION cpf_eq( cpf, cpf )
RETURNS bool
AS 'int8eq'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpf_ne( cpf, cpf )
RETURNS bool
AS 'int8ne'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpf_lt( cpf, cpf )
RETURNS bool
AS 'int8lt'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpf_le( cpf, cpf )
RETURNS bool
AS 'int8le'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpf_gt( cpf, cpf )
RETURNS bool
AS 'int8gt'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cpf_ge( cpf, cpf )
RETURNS bool
AS 'int8ge'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

--
-- Operators.
--

CREATE OPERATOR = (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    COMMUTATOR = =,
    NEGATOR    = <>,
    PROCEDURE  = cpf_eq,
    RESTRICT   = eqsel,
    JOIN       = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    NEGATOR    = =,
    COMMUTATOR = <>,
    PROCEDURE  = cpf_ne,
    RESTRICT   = neqsel,
    JOIN       = neqjoinsel
);

CREATE OPERATOR < (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    NEGATOR    = >=,
    COMMUTATOR = >,
    PROCEDURE  = cpf_lt,
    RESTRICT   = scalarltsel,
    JOIN       = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    NEGATOR    = >,
    COMMUTATOR = >=,
    PROCEDURE  = cpf_le,
    RESTRICT   = scalarltsel,
    JOIN       = scalarltjoinsel
);

CREATE OPERATOR >= (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    NEGATOR    = <,
    COMMUTATOR = <=,
    PROCEDURE  = cpf_ge,
    RESTRICT   = scalargtsel,
    JOIN       = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG    = CPF,
    RIGHTARG   = CPF,
    NEGATOR    = <=,
    COMMUTATOR = <,
    PROCEDURE  = cpf_gt,
    RESTRICT   = scalargtsel,
    JOIN       = scalargtjoinsel
);
