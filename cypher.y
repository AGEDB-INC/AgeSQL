%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "postgres_fe.h"                                                        
                                                                                
#include "psqlscanslash.h"                                                      
#include "common/logging.h"
#include "fe_utils/conditional.h"

#include "fe_utils/psqlscan_int.h"
#include "fe_utils/psqlscan.h"
                                                                                
#include "libpq-fe.h"                                                           
#include "cypherscan.h"                                                         
#include "cypher.tab.h" 

#define parser_yyerror(msg) scanner_yyerror(msg, yyscanner)
#define parser_errposition(pos) scanner_errposition(pos, yyscanner)

void yyerror(void* scanner, char const *s);

typedef struct yy_buffer_state *YY_BUFFER_STATE;

typedef struct
{
    char* str_val;
    int int_val;
} yyval;

int order_clause_direction = 1; // 1 for ascending, -1 for descending

int match = 0;
%}

%union
{
    char* str_val;
    int int_val;
}

%token ASC ARROW AS DESC LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE MATCH WHERE WITH ORDER BY SKIP LIMIT RETURN
%token <int_val> INTEGER
%token <str_val> IDENTIFIER STRING
%token UNKNOWN

%type <str_val> str_val

%param {void* scanner}

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
        {
            match = 1;
        }
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
    | IDENTIFIER
    | COLON IDENTIFIER 
    | node_labels_opt COLON IDENTIFIER
    ;

node_properties_opt:
    /* empty */
    | LBRACE map_literal RBRACE
    ;

str_val:
    IDENTIFIER 
    | STRING 
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

void yyerror(void* scanner, char const *s)
{
	printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);
}

char*
psql_scan_cypher_command(PsqlScanState state)
{ 
    PQExpBufferData mybuf;

    /* Must be scanning already */
    Assert(state->scanbufhandle != NULL);

    /* Build a local buffer that we'll return the data of */
    initPQExpBuffer(&mybuf);

    /* Set current output target */
    state->output_buf = &mybuf;

    /* Set input source */
    if (state->buffer_stack != NULL)
            yy_switch_to_buffer(state->buffer_stack->buf, state->scanner);
    else
            yy_switch_to_buffer(state->scanbufhandle, state->scanner);

    /* And lex. */
    yyparse(state->scanner);

    if (match == 1) { 
        state->start_state = 1;
    }

    mybuf.data = state->scanbuf;

    /* There are no possible errors in this lex state... */

    /*
     * In case the caller returns to using the regular SQL lexer, reselect the
     * appropriate initial state.
     */
    psql_scan_reselect_sql_lexer(state);

    return mybuf.data;
}
