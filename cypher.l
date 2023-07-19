%option nounput
%option noinput
%option noyywrap

%{
#include "postgres_fe.h"
#include "psqlscanslash.h"
#include "common/logging.h"
#include "fe_utils/conditional.h"
#include "libpq-fe.h"
#include "cypherscan.h"
#include "cypher.tab.h"
%}

%%
[ \t\n] ;
"-" { return DASH; }
"<" { return LT; }
">" { return GT; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }
"(" { return LPAREN; }
")" { return RPAREN; }
":" { return COLON; }
"|" { return PIPE; }
"," { return COMMA; }
";" { return SEMICOLON; }
"{" { return LBRACE; }
"}" { return RBRACE; }
"*" { return ASTERISK; }
"." { return DOT; }
"+" { return PLUS; }
"/" { return SLASH; }
"=" { return EQUALS; }
"$" { return DOLLAR; }
"!" { return EXCLAMATION; }
"=~" { return EQUALSTILDE; }
"%" { return PERCENT; }
"^" { return CARET; }

"OPTIONAL"|"optional" { return OPTIONAL; }
"MATCH"|"match" { return MATCH; }
"ONLY"|"only" { return ONLY; }
"ON"|"on" { return ON; }
"CREATE"|"create" { return CREATE; }
"GRAPH"|"graph" { return GRAPH; }
"VLABEL"|"vlabel" { return VLABEL; }
"ELABEL"|"elabel" { return ELABEL; }
"CONSTRAINT"|"constraint" { return CONSTRAINT; }
"ASSERT"|"assert" { return ASSERT; }
"UNIQUE"|"unique" { return UNIQUE; }
"INHERITS"|"inherits" { return INHERITS; }
"TABLESPACE"|"tablespace" { return TABLESPACE; }
"DROP"|"drop" { return DROP; }
"IF"|"if" { return IF; }
"CASCADE"|"cascade" { return CASCADE; }
"ALTER"|"alter" { return ALTER; }
"STORAGE"|"storage" { return STORAGE; }
"RENAME TO"|"rename to" { return RENAME; }
"OWNER TO"|"owner to" { return OWNER; }
"CLUSTER"|"cluster" { return CLUSTER; }
"UNLOGGED"|"unlogged" { return UNLOGGED; }
"LOGGED"|"logged" { return LOGGED; }
"INHERIT"|"inherit" { return INHERIT; }
"NO INHERIT"|"no inherit" { return NOINHERIT; }
"DISABLE"|"disable" { return DISABLE; }
"REINDEX"|"reindex" { return REINDEX; }
"INDEX"|"index" { return INDEX; }
"EXPLAIN"|"explain" { return EXPLAIN; }
"VERBOSE"|"verbose" { return VERBOSE; }
"COSTS OFF"|"costs off" { return COSTSOFF; }
"MERGE"|"merge" { return MERGE; }
"LOAD"|"load" { return LOAD; }
"IDS"|"ids" { return IDS; }
"LABELS"|"labels" { return LABELS; }
"LOAD EDGES"|"load edges" { return EDGES; }
"UNWIND"|"unwind" { return UNWIND; }
"WHERE"|"where" { return WHERE; }
"EXISTS"|"exists" { return EXISTS; }
"WITH"|"with" { return WITH; }
"WITHOUT"|"without" { return WITHOUT; }
"ORDER"|"order" { return ORDER; }
"BY"|"by" { return BY; }
"SKIP"|"skip" { return SKIP; }
"LIMIT"|"limit" { return LIMIT; }
"DELETE"|"delete" { return DELETE; }
"DETACH"|"detach" { return DETACH; }
"SET"|"set" { return SET; }
"REMOVE"|"remove" { return REMOVE; }
"RETURN"|"return" { return RETURN; }
"DISTINCT"|"distinct" { return DISTINCT; }
"STARTS"|"starts" { return STARTS; }
"ENDS"|"ends" { return ENDS; }
"CONTAINS"|"contains" { return CONTAINS; }
"ASC"|"asc" { return ASC; }
"DESC"|"desc" { return DESC; }
"AS"|"as" { return AS; }
"AND"|"and" { return AND; }
"OR"|"or" { return OR; }
"XOR"|"xor" { return XOR; }
"TRUE"|"true" { return TRUE; }
"FALSE"|"false" { return FALSE; }
"IS"|"is" { return IS; }
"IN"|"in" { return IN; }
"NOT"|"not" { return NOT; }
"NULL"|"null" { return NUL; }
"UNION"|"union" { return UNION; }
"UNION ALL"|"union all" { return UNIONALL; }
"SELECT"|"select" { return SELECT; }
"FROM"|"from" { return FROM; }
"GRAPH_PATH"|"graph_path" { return GRAPH_PATH; }
"PREPARE"|"prepare" { return PREPARE; }
"EXECUTE"|"execute" { return EXECUTE; }
"COMMENT"|"comment" { return COMMENT; }
"SHOW"|"show" { return SHOW; }
"CASE"|"case" { return CASE; }
"WHEN"|"when" { return WHEN; }
"THEN"|"then" { return THEN; }
"ELSE"|"else" { return ELSE; }
"END"|"end" { return END; }

[0-9]+[eE0-9]* { yylval.int_val = atoi(yytext); return INTEGER; }
[0-9]+"."[0-9]+([eE][0-9]+)? { yylval.float_val = atof(yytext); return FLOAT; }
0[xX][a-fA-F0-9]+ { yylval.int_val = (int)strtol(yytext, NULL, 16); return INTEGER; }
[a-zA-Z][a-zA-Z0-9_.*]* { yylval.str_val = strdup(yytext); return IDENTIFIER; }
("\"")[^"]*("\"")|("\'")[^']*("\'") { yylval.str_val = strdup(yytext); return STRING; }
. { return UNKNOWN; }
%%

