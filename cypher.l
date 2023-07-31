%option noinput
%option nounput
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
[ \t\n] { /* ignore whitespaces */ }

"!" { return EXCLAMATION; }
"$" { return DOLLAR; }
"%" { return PERCENT; }
"(" { return LPAREN; }
")" { return RPAREN; }
"*" { return ASTERISK; }
"+" { return PLUS; }
"," { return COMMA; }
"-" { return DASH; }
"." { return DOT; }
"/" { return SLASH; }
":" { return COLON; }
";" { return SEMICOLON; }
"<" { return LT; }
"=" { return EQUALS; }
"=~" { return EQUALSTILDE; }
">" { return GT; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }
"^" { return CARET; }
"_" { return UNDER; }
"{" { return LBRACE; }
"|" { return PIPE; }
"}" { return RBRACE; }

"ALTER"|"alter" { return ALTER; }
"AND"|"and" { return AND; }
"AS"|"as" { return AS; }
"ASC"|"asc" { return ASC; }
"ASSERT"|"assert" { return ASSERT; }

"BEGIN"|"begin" { return BGN; }
"BY"|"by" { return BY; }

"CALLED"|"called" { return CALLED; }
"CASCADE"|"cascade" { return CASCADE; }
"CASE"|"case" { return CASE; }
"CLUSTER"|"cluster" { return CLUSTER; }
"COMMENT"|"comment" { return COMMENT; }
"CONSTRAINT"|"constraint" { return CONSTRAINT; }
"CONTAINS"|"contains" { return CONTAINS; }
"COSTS OFF"|"costs off" { return COSTSOFF; }
"CREATE"|"create" { return CREATE; }

"DECLARE"|"declare" { return DECLARE; }
"DELETE"|"delete" { return DELETE; }
"DESC"|"desc" { return DESC; }
"DETACH"|"detach" { return DETACH; }
"DISABLE"|"disable" { return DISABLE; }
"DISTINCT"|"distinct" { return DISTINCT; }
"DROP"|"drop" { return DROP; }

"LOAD EDGES"|"load edges" { return EDGES; }
"ELABEL"|"elabel" { return ELABEL; }
"ELSE"|"else" { return ELSE; }
"END"|"end" { return END; }
"ENDS"|"ends" { return ENDS; }
"EXECUTE"|"execute" { return EXECUTE; }
"EXISTS"|"exists" { return EXISTS; }
"EXPLAIN"|"explain" { return EXPLAIN; }

"FALSE"|"false" { return FAL; }
"FROM"|"from" { return FROM; }
"FUNCTION"|"function" { return FUNCTION; }

"GRAPH"|"graph" { return GRAPH; }
"GRAPH_PATH"|"graph_path" { return GRAPH_PATH; }

"IDS"|"ids" { return IDS; }
"IF"|"if" { return IF; }
"IMMUTABLE"|"immutable" { return IMMUTABLE; }
"IN"|"in" { return IN; }
"INDEX"|"index" { return INDEX; }
"INHERIT"|"inherit" { return INHERIT; }
"INHERITS"|"inherits" { return INHERITS; }
"INPUT"|"input" { return INPUT; }
"INTO"|"into" { return INTO; }
"IS"|"is" { return IS; }

"LABELS"|"labels" { return LABELS; }
"LANGUAGE"|"language" { return LANGUAGE; }
"LIMIT"|"limit" { return LIMIT; }
"LOAD"|"load" { return LOAD; }
"LOGGED"|"logged" { return LOGGED; }

"MATCH"|"match" { return MATCH; }
"MERGE"|"merge" { return MERGE; }

"NO INHERIT"|"no inherit" { return NOINHERIT; }
"NOT"|"not" { return NOT; }
"NULL"|"null" { return NUL; }

"ON"|"on" { return ON; }
"ONLY"|"only" { return ONLY; }
"OPTIONAL"|"optional" { return OPTIONAL; }
"OR"|"or" { return OR; }
"ORDER"|"order" { return ORDER; }
"OWNER TO"|"owner to" { return OWNER; }

"PARALLEL"|"parallel" { return PARALLEL; }
"PERFORM"|"perform" { return PERFORM; }
"PREPARE"|"prepare" { return PREPARE; }

"QUERY"|"query" { return QUERY; }

"REINDEX"|"reindex" { return REINDEX; }
"REMOVE"|"remove" { return REMOVE; }
"RENAME TO"|"rename to" { return RENAME; }
"REPLACE"|"replace" { return REPLACE; }
"RETURN"|"return" { return RETURN; }
"RETURNS"|"returns" { return RETURNS; }

"SAFE"|"safe" { return SAFE; }
"SELECT"|"select" { return SELECT; }
"SET"|"set" { return SET; }
"SETOF"|"setof" { return SETOF; }
"SHOW"|"show" { return SHOW; }
"SKIP"|"skip" { return SKIP; }
"STABLE"|"stable" { return STABLE; }
"STARTS"|"starts" { return STARTS; }
"STORAGE"|"storage" { return STORAGE; }
"STRICT"|"strict" { return STRICT; }

"TABLESPACE"|"tablespace" { return TABLESPACE; }
"THEN"|"then" { return THEN; }
"TRUE"|"true" { return TRU; }

"UNION"|"union" { return UNION; }
"UNION ALL"|"union all" { return UNIONALL; }
"UNIQUE"|"unique" { return UNIQUE; }
"UNLOGGED"|"unlogged" { return UNLOGGED; }
"UNWIND"|"unwind" { return UNWIND; }

"VERBOSE"|"verbose" { return VERBOSE; }
"VLABEL"|"vlabel" { return VLABEL; }
"VOLATILE"|"volatile" { return VOLATILE; }

"WHEN"|"when" { return WHEN; }
"WHERE"|"where" { return WHERE; }
"WITH"|"with" { return WITH; }
"WITHOUT"|"without" { return WITHOUT; }

"XOR"|"xor" { return XOR; }

[0-9]+"."[0-9]+([eE][0-9]+)? { yylval.float_val = atof(yytext); return FLOAT; }
[a-zA-Z][a-zA-Z0-9_.*]* { yylval.str_val = strdup(yytext); return IDENTIFIER; }
[0-9]+[eE0-9]* { yylval.int_val = atoi(yytext); return INTEGER; }
0[xX][a-fA-F0-9]+ { yylval.int_val = (int)strtol(yytext, NULL, 16); return INTEGER; }
("\"")[^"]*("\"")|("\'")[^']*("\'") { yylval.str_val = strdup(yytext); return STRING; }

. { return UNKNOWN; }
%%

