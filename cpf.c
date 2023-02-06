#include "postgres.h"
#include "fmgr.h"
#include "utils/fmgrprotos.h"
#include "utils/palloc.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(cpfout);

Datum
cpfout(PG_FUNCTION_ARGS)
{
	int64		val = PG_GETARG_INT64(0);
	int			group[4];
	char	   *result;

	/* 000.000.000-00 */
	group[0] = (val / 100000000) % 1000;	/* first group of three digits */
	group[1] = (val / 100000) % 1000;	/* second group of three digits */
	group[2] = (val / 100) % 1000;	/* third group of three digits */
	group[3] = (val % 100);		/* check digits (last two digits) */

	result = psprintf("%03d.%03d.%03d-%02d", group[0], group[1], group[2], group[3]);

	PG_RETURN_CSTRING(result);
}

/* https://pt.wikipedia.org/wiki/Cadastro_de_Pessoas_F%C3%ADsicas */
static int
compute_cpf_check_digits(long int cpf)
{
	int			i = 0,
				d = 0,
				d1 = 0,
				d2 = 0;

	/* remove last two digits */
	cpf = cpf / 100;

	do
	{
		d = cpf % 10;
		d1 = d1 + d * (9 - (i % 10));
		d2 = d2 + d * (9 - ((i++ + 1) % 10));
		cpf = cpf / 10;
	} while (cpf > 0);

	d1 = (d1 % 11) % 10;
	d2 = d2 + d1 * 9;
	d2 = (d2 % 11) % 10;

	return (d1 * 10) + d2;
}

static void
validate_cpf(int64 cpf)
{
	char	   *out;
	int			i;

	/* Check sizes */
	if (cpf < 100 || cpf > 99999999999)
	{
		ereport(ERROR,
				(errcode(ERRCODE_WRONG_OBJECT_TYPE),
				 errmsg("invalid CPF"),
				 errdetail("CPF should not be less than 100 and greater than 99999999999.")));
	}

	/* Check if all digits are the same. */
	out = psprintf("%011ld", cpf);
	for (i = 1; i < 11 && out[i] == out[0]; i++)
	{
		if (i == 10)
		{
			ereport(ERROR,
					(errcode(ERRCODE_WRONG_OBJECT_TYPE),
					 errmsg("invalid CPF"),
					 errdetail("All CPF digits should not be equal.")));
		}
	}

	if (compute_cpf_check_digits(cpf) != (cpf % 100))
	{
		ereport(ERROR,
				(errcode(ERRCODE_WRONG_OBJECT_TYPE),
				 errmsg("invalid CPF"),
				 errdetail("Invalid check digit for the CPF.")));
	}
}

PG_FUNCTION_INFO_V1(cpfin);

Datum
cpfin(PG_FUNCTION_ARGS)
{
	int64		value = DirectFunctionCall1(int8in, PG_GETARG_DATUM(0));

	validate_cpf(value);

	PG_RETURN_INT64(value);
}
