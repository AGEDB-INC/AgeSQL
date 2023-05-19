%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "postgres_fe.h"                                                        
                                                                                
#include "psqlscanslash.h"                                                      
#include "common/logging.h"                                                     
#include "fe_utils/conditional.h"                                               
                                                                                
#include "libpq-fe.h"                                                           
#include "cypherscan.h"                                                         
#include "cypher.tab.h" 

#define parser_yyerror(msg) scanner_yyerror(msg, yyscanner)
#define parser_errposition(pos) scanner_errposition(pos, yyscanner)

void yyerror(char const *s);

typedef struct yy_buffer_state *YY_BUFFER_STATE;

typedef struct {
    char* str_val;
    int int_val;
} yyval;

int yylex(void);

int order_clause_direction = 1; // 1 for ascending, -1 for descending
%}

%union {
    char* str_val;
    int int_val;
}

%token ASC ARROW AS DESC LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE MATCH WHERE WITH ORDER BY SKIP LIMIT RETURN
%token <int_val> INTEGER
%token <str_val> IDENTIFIER STRING
%token UNKNOWN

%left PIPE
%left ARROW

%start statement

%%

statement:
    query
    ;

query:
    match_clause
    | where_clause
    | with_clause
    | return_clause
    ;

match_clause:
    MATCH path_pattern
	;    

path_pattern:
    node_pattern
    | path_pattern ARROW rel_pattern node_pattern
    ;

node_pattern:
    LPAREN node_labels_opt node_properties_opt RPAREN
    ;

node_labels_opt:
    /* empty */
    | COLON IDENTIFIER
    ;

node_properties_opt:
    /* empty */
    | LBRACE map_literal RBRACE
    ;

rel_pattern:
    rel_type
    | rel_pattern rel_direction rel_type
    ;

rel_type:
    COLON IDENTIFIER
     | LBRACKET IDENTIFIER RBRACKET
    ;

rel_direction:
    ARROW
    | ARROW IDENTIFIER ARROW
    ;

map_literal:
    /* empty */
    | nonempty_map_literal
    ;

nonempty_map_literal:
    map_entry
    | nonempty_map_literal COMMA map_entry
    ;

map_entry:
    IDENTIFIER COLON expression
    ;

expression:
    INTEGER
    | STRING
    | IDENTIFIER
    ;

where_clause:
    | WHERE expression
    ;

with_clause:
    WITH expression_list
    ;

expression_list:
	expression
	| expression_list COMMA expression
	;

return_clause:
	RETURN return_item_list order_clause_opt skip_clause_opt limit_clause_opt
;

return_item_list:
	return_item
	| return_item_list COMMA return_item
	;

return_item:
	expression
	| expression AS IDENTIFIER
	;

order_clause_opt:
	/* empty */
	| ORDER BY sort_item_list
	;

sort_item_list:
	sort_item
	| sort_item_list COMMA sort_item
	;

sort_item:
	expression sort_direction_opt
	;

sort_direction_opt:
	/* empty */
	| ASC
	| DESC
	;

skip_clause_opt:
	/* empty */
	| SKIP INTEGER
	;

limit_clause_opt:
	/* empty */
	| LIMIT INTEGER
	;

%%

void yyerror(char const *s)
{
	printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);
}

void
psql_scan_cypher_command(PsqlScanState state)
{
	yyparse();
}
