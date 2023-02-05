#include "postgres.h"
#include "fmgr.h"
#include "utils/palloc.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(cpfout);

Datum
cpfout(PG_FUNCTION_ARGS)
{
	int64		val = PG_GETARG_INT64(0);
	int			group1 = (val / 100000000) % 1000;
	int			group2 = (val / 100000) % 1000;
	int			group3 = (val / 100) % 1000;
	int			group4 = (val % 100);
	char	   *result;

	result = psprintf("%03d.%03d.%03d-%02d", group1, group2, group3, group4);

	PG_RETURN_CSTRING(result);
}
