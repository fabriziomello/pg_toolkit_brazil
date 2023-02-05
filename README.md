# pg_toolkit_brazil
PostgreSQ: extension that provides Brazilian specific data types, functions and operators.

## Supported PostgreSQL versions

The aim of the project is support as many community-supported major versions of Postgres as possible. Currently, the following versions of PostgreSQL are supported:

11, 12, 13, 14 and 15.

## Installation

```sh
$ git clone https://github.com/fabriziomello/pg_toolkit_brazil.git
$ cd pg_toolkit_brazil
# Make sure your path includes the bin directory that contains the correct `pg_config`
$ PATH=/path/to/pg/bin:$PATH
$ USE_PGXS=1 make
$ USE_PGXS=1 make install
```

## Tests

```sh
$ USE_PGXS=1 make installcheck
```

Please feel free to [open a PR](https://github.com/fabriziomello/pg_toolkit_brazil/pull/new/master).

## Authors

- [Fabrízio de Royes Mello](mailto:fabriziomello@gmail.com)

## License

PostgreSQL server source code, used under the [PostgreSQL license](https://www.postgresql.org/about/licence/).<br>
Portions Copyright (c) 1996-2023, The PostgreSQL Global Development Group<br>
Portions Copyright (c) 1994, The Regents of the University of California

All other parts are licensed under the 3-clause BSD license, see LICENSE file for details.<br>
Copyright (c) 2020, Fabrízio de Royes Mello <fabriziomello@gmail.com>
