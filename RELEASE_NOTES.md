## AgeSQL 1.0.0 Beta - Release Notes

### Improvements

PR #5 - Adds support for MATCH, WHERE, WITH, and RETURN clauses with semicolon commands.

PR #8 - Implements compatibility with the CREATE GRAPH command.

PR #11 - Adds support for all permutations of MATCH command.

PR #12 - Adds support for CREATE clause. 

PR #13 - Compatibility with utility functions such as CREATE VLABEL, CREATE ELABEL, ALTER GRAPH, DROP GRAPH, LOAD LABELS, and LOAD EDGES.

PR #14 - Supports return typecast in the conversion to the SQL clause.

PR #15 - Adds support for label inheritance, SET GRAPH, and SET GRAPH_PATH.

PR #16 - Provides Cypher DDL, Cypher DML, and Cypher DML 2 compatibility.

PR #18 - Includes TABLESPACE, REINDEX, and COMMENT clauses.

PR #19 - Implements substring and shows graph path functions.

PR #20 - Includes support for Cypher Eager, Cypher Expression, and Cypher Shortest Path commands.

PR #22 - Improves conflict prevention with PostgreSQL clauses and added support for REINDEX and COMMENT commands.

PR #23 - Adds EXPLAIN functionality.

PR #24 and #27 - Updates README with information about AgeSQL installation, setup, and examples for a quick start.

PR #25 - Refactor `convert_to_psql_command` Function for Improved Efficiency.

PR #26 and #28 - Adds support for user-defined function clauses.

### Bug Fixes

PR #1 - Addresses warnings and errors, including typos and incompatible pointer types.

PR #6 - Resolves tokenization of the RETURN key error, segmentation faults from INTEGER tokens, incorrect return lists, and other bugs.

PR #10 - Fixes missing rules for MATCH and CREATE clauses.

PR #12 - Resolves issues with empty graph names in the MATCH command, removes string comparison from the parser, and fix the parser's returning value.

PR #17 - Fixes Cypher syntax checker and issue with sending a query.

PR #18 - Fixes a bug in the RETURN clause to prevent generating garbage in the returning list, eliminates string comparisons, and addresses bugs in MATCH and CREATE clauses.

PR #29 and #30 - Addresses bugs with tokens and functions.

PR #31 and #32 - Reformatted code for better organization, added more information into README, and fixed bug with CREATE FUNCTION clause.