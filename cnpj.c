#include "postgres.h"
#include "fmgr.h"
#include "utils/fmgrprotos.h"
#include "utils/palloc.h"

PG_FUNCTION_INFO_V1(cnpjout);

/* https://pt.wikipedia.org/wiki/Cadastro_Nacional_da_Pessoa_Jur%C3%ADdica */
Datum
cnpjout(PG_FUNCTION_ARGS)
{
	int64		val = PG_GETARG_INT64(0);
	int			group[5];
	char	   *result;

	/* XX.XXX.XXX/YYYY-ZZ */
	group[0] = (val / 1000000000000 ) % 100;	/* first group of three digits */
	group[1] = (val / 1000000000) % 1000;	/* second group of three digits */
	group[2] = (val / 1000000) % 1000;	/* third group of three digits */
	group[3] = (val / 100) % 10000;	/* third group of three digits */
	group[4] = (val % 100);		/* check digits (last two digits) */

	result = psprintf("%02d.%03d.%03d/%04d-%02d",
			group[0], group[1], group[2], group[3], group[4]);

	PG_RETURN_CSTRING(result);
}

static int
compute_cnpj_check_digits(long int cnpj)
{
	int		i = 0;
	long int	d1 = 0,
			d2 = 0;
	long int	d[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0};


	/* remove last digit */
	cnpj = cnpj / 10;

	for (i = 12; i >= 0; i--)
	{
		d[i] = cnpj % 10;
		cnpj = cnpj / 10;
	}

	d1 = (5 * d[0]) + (4 * d[1]) + (3 * d[2]) + (2 * d[3]);
	d1 += (9 * d[4]) + (8 * d[5]) + (7 * d[6]) + (6 * d[7]);
	d1 += (5 * d[8]) + (4 * d[9]) + (3 * d[10]) + (2 * d[11]);
	d1 = 11 - (d1 % 11);
	if (d1 >= 10) d1 = 0;

	d2 = (6 * d[0]) + (5 * d[1]) + (4 * d[2]) + (3 * d[3]);
	d2 += (2 * d[4]) + (9 * d[5]) + (8 * d[6]) + (7 * d[7]);
	d2 += (6 * d[8]) + (5 * d[9]) + (4 * d[10]) + (3 * d[11]);
	d2 += (2 * d[12]);
	d2 = 11 - (d2 % 11);
	if (d2 >= 10) d2 = 0;

	return (d1 * 10) + d2;
}

static void
validate_cnpj(int64 cnpj)
{
	int check_digits = 0;
	/* Check sizes */
	if (cnpj > 99999999999999L)
	{
		ereport(ERROR,
				(errcode(ERRCODE_WRONG_OBJECT_TYPE),
				 errmsg("invalid CNPJ"),
				 errdetail("CNPJ should be less than 99999999999999.")));
	}
	check_digits = compute_cnpj_check_digits(cnpj);
	if (check_digits != (cnpj % 100))
	{
		ereport(ERROR,
				(errcode(ERRCODE_WRONG_OBJECT_TYPE),
				 errmsg("invalid CNPJ"),
				 errdetail("Invalid check digit for the CNPJ. (%02d != %02ld)", check_digits, cnpj % 100)));
	}
}

PG_FUNCTION_INFO_V1(cnpjin);

Datum
cnpjin(PG_FUNCTION_ARGS)
{
	int64		value = DirectFunctionCall1(int8in, PG_GETARG_DATUM(0));

	validate_cnpj(value);

	PG_RETURN_INT64(value);
}
