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

"OPTIONAL"|"optional" { return OPTIONAL; }
"MATCH"|"match" { return MATCH; }
"ONLY"|"only" { return ONLY; }
"ON"|"on" { return ON; }
"CREATE"|"create" { return CREATE; }
"GRAPH"|"graph" { return GRAPH; }
"VLABEL"|"vlabel" { return VLABEL; }
"ELABEL"|"elabel" { return ELABEL; }
"INHERITS"|"inherits" { return INHERITS; }
"DROP"|"drop" { return DROP; }
"IF"|"if" { return IF; }
"CASCADE"|"cascade" { return CASCADE; }
"ALTER"|"alter" { return ALTER; }
"RENAME"|"rename" { return RENAME; }
"EXPLAIN"|"explain" { return EXPLAIN; }
"MERGE"|"merge" { return MERGE; }
"LOAD"|"load" { return LOAD; }
"IDS"|"ids" { return IDS; }
"LABELS"|"labels" { return LABELS; }
"EDGES"|"edges" { return EDGES; }
"UNWIND"|"unwind" { return UNWIND; }
"WHERE"|"where" { return WHERE; }
"EXISTS"|"exists" { return EXISTS; }
"WITH"|"with" { return WITH; }
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
"ASC"|"asc" { return ASC; }
"DESC"|"desc" { return DESC; }
"AS"|"as" { return AS; }
"AND"|"and" { return AND; }
"OR"|"or" { return OR; }
"XOR"|"xor" { return XOR; }
"TRUE"|"true" { return TRUE; }
"FALSE"|"false" { return FALSE; }
"IS"|"is" { return IS; }
"NOT"|"not" { return NOT; }
"NULL"|"null" { return NUL; }
"UNION"|"union" { return UNION; }
"ALL"|"all" { return ALL; }
"SELECT"|"select" { return SELECT; }
"FROM"|"from" { return FROM; }

[0-9]+ { yylval.int_val = atoi(yytext); return INTEGER; }
[0-9]+"."[0-9]+ { yylval.float_val = atof(yytext); return FLOAT; }
[a-zA-Z][a-zA-Z0-9_.]* { yylval.str_val = strdup(yytext); return IDENTIFIER; }
("\"")[^"]*("\"")|("\'")[^']*("\'") { yylval.str_val = strdup(yytext); return STRING; }
("=")|("!=")|("<=")|(">=")|("<")|(">")|("<>") { yylval.str_val = strdup(yytext); return COMPARATOR; }
. { return UNKNOWN; }
%%

