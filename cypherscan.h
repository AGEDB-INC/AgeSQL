/*
 * psql - the PostgreSQL interactive terminal
 *
 * Copyright (c) 2000-2022, PostgreSQL Global Development Group
 *
 * src/bin/psql/cypherscan.h
 */
#ifndef CYPHERSCAN_H
#define CYPHERSCAN_H

#include "fe_utils/psqlscan.h"
void psql_scan_cypher_command(char *);
char *convert_to_psql_command(char *);

#endif   /* CYPHERSCAN_H */
