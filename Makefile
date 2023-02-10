MODULE_big = pg_toolkit_brazil
OBJS = cpf.o cnpj.o

REGRESS = cpf cnpj

EXTENSION = pg_toolkit_brazil
DATA = pg_toolkit_brazil--0.1.sql
PGFILEDESC = "pg_toolkit_brazil - PostgreSQL extension that provides Brazilian specific data types and functions"

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

pgindent:
	$(shell scripts/run_pgindent.sh)	