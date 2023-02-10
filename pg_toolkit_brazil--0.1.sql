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
-- Type casting functions.
--

CREATE FUNCTION cpfbigint(bigint)
RETURNS cpf
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;


--
--  Implicit and assignment type casts.
--

CREATE CAST (bigint AS cpf) WITH FUNCTION cpfbigint(bigint) AS IMPLICIT;

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

--
-- Support functions for indexing.
--

CREATE FUNCTION cpf_cmp(cpf, cpf)
RETURNS int4
AS 'btint8cmp'
LANGUAGE internal STRICT IMMUTABLE PARALLEL SAFE;

--
-- The btree indexing operator class.
--

CREATE OPERATOR CLASS cpf_ops
DEFAULT FOR TYPE CPF USING btree AS
    OPERATOR    1   <  (cpf, cpf),
    OPERATOR    2   <= (cpf, cpf),
    OPERATOR    3   =  (cpf, cpf),
    OPERATOR    4   >= (cpf, cpf),
    OPERATOR    5   >  (cpf, cpf),
    FUNCTION    1   cpf_cmp(cpf, cpf);


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

--
--  Implicit and assignment type casts.
--

CREATE CAST (bigint AS cnpj) WITHOUT FUNCTION AS IMPLICIT;

--
-- Operator Functions.
--

CREATE FUNCTION cnpj_eq( cnpj, cnpj )
RETURNS bool
AS 'int8eq'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpj_ne( cnpj, cnpj )
RETURNS bool
AS 'int8ne'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpj_lt( cnpj, cnpj )
RETURNS bool
AS 'int8lt'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpj_le( cnpj, cnpj )
RETURNS bool
AS 'int8le'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpj_gt( cnpj, cnpj )
RETURNS bool
AS 'int8gt'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION cnpj_ge( cnpj, cnpj )
RETURNS bool
AS 'int8ge'
LANGUAGE internal IMMUTABLE STRICT PARALLEL SAFE;

--
-- Operators.
--

CREATE OPERATOR = (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    COMMUTATOR = =,
    NEGATOR    = <>,
    PROCEDURE  = cnpj_eq,
    RESTRICT   = eqsel,
    JOIN       = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    NEGATOR    = =,
    COMMUTATOR = <>,
    PROCEDURE  = cnpj_ne,
    RESTRICT   = neqsel,
    JOIN       = neqjoinsel
);

CREATE OPERATOR < (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    NEGATOR    = >=,
    COMMUTATOR = >,
    PROCEDURE  = cnpj_lt,
    RESTRICT   = scalarltsel,
    JOIN       = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    NEGATOR    = >,
    COMMUTATOR = >=,
    PROCEDURE  = cnpj_le,
    RESTRICT   = scalarltsel,
    JOIN       = scalarltjoinsel
);

CREATE OPERATOR >= (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    NEGATOR    = <,
    COMMUTATOR = <=,
    PROCEDURE  = cnpj_ge,
    RESTRICT   = scalargtsel,
    JOIN       = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG    = CNPJ,
    RIGHTARG   = CNPJ,
    NEGATOR    = <=,
    COMMUTATOR = <,
    PROCEDURE  = cnpj_gt,
    RESTRICT   = scalargtsel,
    JOIN       = scalargtjoinsel
);

--
-- Support functions for indexing.
--

CREATE FUNCTION cnpj_cmp(cnpj, cnpj)
RETURNS int4
AS 'btint8cmp'
LANGUAGE internal STRICT IMMUTABLE PARALLEL SAFE;

--
-- The btree indexing operator class.
--

CREATE OPERATOR CLASS cnpj_ops
DEFAULT FOR TYPE CNPJ USING btree AS
    OPERATOR    1   <  (cnpj, cnpj),
    OPERATOR    2   <= (cnpj, cnpj),
    OPERATOR    3   =  (cnpj, cnpj),
    OPERATOR    4   >= (cnpj, cnpj),
    OPERATOR    5   >  (cnpj, cnpj),
    FUNCTION    1   cnpj_cmp(cnpj, cnpj);


