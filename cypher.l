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
[ \t\n]         /* Ignore whitespaces */

"!"             { return EXCLAMATION; }
"\$"            { return DOLLAR; }
"%"             { return PERCENT; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"\*"            { return ASTERISK; }
"\+"            { return PLUS; }
","             { return COMMA; }
"-"             { return DASH; }
"\."            { return DOT; }
"/"             { return SLASH; }
":"             { return COLON; }
";"             { return SEMICOLON; }
"<"             { return LT; }
"="             { return EQUALS; }
"=~"            { return EQUALSTILDE; }
">"             { return GT; }
"\["            { return LBRACKET; }
"\]"            { return RBRACKET; }
"\^"            { return CARET; }
"_"             { return UNDER; }
"{"             { return LBRACE; }
"|"             { return PIPE; }
"}"             { return RBRACE; }

/* Keywords */
"ALTER"         { return ALTER; }
"AND"           { return AND; }
"AS"            { return AS; }
"ASC"           { return ASC; }
"ASSERT"        { return ASSERT; }
"BEGIN"         { return BGN; }
"BY"            { return BY; }
/* Add more keywords here */

/* Literals */
[0-9]+"."[0-9]+([eE][0-9]+)? {
                    yylval.float_val = atof(yytext);
                    return FLOAT;
                }
[a-zA-Z][a-zA-Z0-9_.*]* {
                    yylval.str_val = strdup(yytext);
                    return IDENTIFIER;
                }
[0-9]+[eE0-9]* {
                    yylval.int_val = atoi(yytext);
                    return INTEGER;
                }
0[xX][a-fA-F0-9]+ {
                    yylval.int_val = (int)strtol(yytext, NULL, 16);
                    return INTEGER;
                }
("\"")[^"]*("\"")|("\'")[^']*("\'") {
                    yylval.str_val = strdup(yytext);
                    return STRING;
                }

.               { return UNKNOWN; }
