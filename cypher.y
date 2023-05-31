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
#include "fe_utils/psqlscan_int.h"

typedef struct yy_buffer_state* YY_BUFFER_STATE;

typedef struct {
    char* str_val;
    int int_val;
} yyval;

void yypush_buffer_state(YY_BUFFER_STATE buffer);
void *yy_scan_string(char const* str);
void yyerror(char const* s);

void add_item(struct map_pair* head, char* exp, char* idt);
char *get_list(struct map_pair* head);
void print_list(struct map_pair* head);
void reset_vals(void);

int yylex(void);
int rel_direction = 0; // 1 for "->", -1 for "<-"
int order_clause_direction = 1; // 1 for ascending, -1 for descending

struct edge_pattern {
    int lower;
    bool dot;
    int upper;
};

struct map_pair {
    char* exp;
    char* idt;
    struct map_pair* next;
};

bool match = false;
bool where = false;
bool with = false;
bool rtn = false;

char qry[1000];
char* graph_name;

struct map_pair* rtn_list;
%}

%union {
    char* str_val;
    int int_val;
    bool bool_val;
    struct edge_pattern* pat;
    struct map_pair* pair;
}

%type <str_val> node_alias_opt node_labels_opt expression rel_alias_opt rel_labels_opt compare logic
%type <int_val> upper_bound_opt sort_direction_opt
%type <bool_val> dot_opt not_opt
%type <pat> variable_length_edges_opt edge_length_opt
%type <pair> node_properties_opt map_literal nonempty_map_literal map_entry item_list item

%token ASC DESC DASH LT GT LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE ASTERISK DOT MATCH ON WHERE WITH ORDER BY SKIP LIMIT RETURN AS AND OR XOR NOT exit_command
%token <int_val> INTEGER
%token <str_val> IDENTIFIER STRING COMPARATOR
%token UNKNOWN

%left PIPE
%left ARROW

%start statement

%%
statement:
    query
    | statement query
    | statement SEMICOLON { YYACCEPT; }
    ;

query:
    match_clause
    | where_clause
    | with_clause
    | return_clause
    ;

match_clause:
    MATCH { match = true; } path_pattern ON IDENTIFIER { graph_name = $5; }
    ;    

path_pattern:
    node_pattern
    | path_pattern edge_pattern node_pattern
    ;

node_pattern:
    LPAREN node_alias_opt node_labels_opt
    node_properties_opt RPAREN
    ;

node_alias_opt:
    /* empty */ { $$ = NULL; }
    | IDENTIFIER { $$ = $1; }
    ;

node_labels_opt:
    /* empty */ { $$ = NULL; }
    | COLON IDENTIFIER { $$ = $2; }
    ;

node_properties_opt:
    /* empty */ { $$ = NULL; }
    | LBRACE map_literal RBRACE { $$ = $2; }
    ;

edge_pattern:
    DASH rel_pattern DASH { rel_direction = 0; }
    | LT DASH rel_pattern DASH { rel_direction = -1; }
    | DASH rel_pattern DASH GT { rel_direction = 1; }
    ;

rel_pattern:
    LBRACKET rel_alias_opt rel_labels_opt variable_length_edges_opt RBRACKET
    ;

rel_alias_opt:
    /* empty */ { $$ = NULL; }
    | IDENTIFIER { $$ = $1; }
    ;

rel_labels_opt:
    /* empty */ { $$ = NULL; }
    | COLON IDENTIFIER { $$ = $2; }
    ;

variable_length_edges_opt:
    /* empty */ { $$ = NULL; }
    | ASTERISK edge_length_opt { $$ = $2; }
    ;

edge_length_opt:
    /* empty */ { $$ = NULL; }
    | INTEGER dot_opt upper_bound_opt { $$->lower = $1; $$->dot = $2; $$->upper = $3; }
    ;

dot_opt:
    /* empty */ { $$ = false; } 
    | DOT DOT { $$ = true; }
    ;

upper_bound_opt:
    /* empty */ { $$ = 0; }
    | INTEGER { $$ = $1; }
    ;

map_literal:
    /* empty */ { $$ = NULL; }
    | nonempty_map_literal { $$ = $1; }
    ;

nonempty_map_literal:
    map_entry { $$ = $1; }
    | nonempty_map_literal COMMA map_entry { $$ = $3; }
    ;

map_entry:
    IDENTIFIER COLON expression { $$->idt = $1; $$->exp = $3; }
    ;

expression:
    INTEGER { sprintf($$, "%d", $1); }
    | STRING { $$ = $1; }
    | IDENTIFIER { $$ = $1; }
    ;

where_clause:
    WHERE { where = true; } where_expression
    ;

where_expression:
    not_opt expression compare expression
    | where_expression logic not_opt expression compare expression
    ;

not_opt:
    /* empty */ { $$ = 0; }
    | NOT { $$ = 1; }
    ;

compare:
    COMPARATOR { $$ = $1; }
    | LT { $$ = "<"; }
    | GT { $$ = ">"; }
    ;

logic:
    AND { $$ = "AND"; }
    | OR { $$ = "OR"; }
    | XOR { $$ = "XOR"; }
    ;

with_clause:
    WITH { with = true; } item_clause
    ;

return_clause:
    RETURN { rtn = true; } item_clause
    ;

item_clause:
    item_list order_clause_opt skip_clause_opt limit_clause_opt
    ;

item_list:
    item { rtn_list->exp = $1->exp; rtn_list->idt = $1->idt; }
    | item_list COMMA item { add_item(rtn_list, $3->exp, $3->idt); }
    ;

item:
    expression
    {
        $$ = (struct map_pair*) malloc(sizeof(struct map_pair)); 
        $$->exp = $1;
        $$->idt = NULL;
    }
    | expression AS IDENTIFIER
    {
        $$ = (struct map_pair*) malloc(sizeof(struct map_pair));
        $$->exp = $1;
        $$->idt = $3;
    }
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
    /* empty */ { $$ = 1; }
    | ASC { $$ = 1; }
    | DESC { $$ = -1; }
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

void yyerror(char const* s)
{
    printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);
}

void add_item(struct map_pair* head, char* exp, char* idt)
{
    struct map_pair* current = head;
    while (current->next != NULL) {
        current = current->next;
    }

    /* now we can add a new variable */
    current->next = (struct map_pair*) malloc(sizeof(struct map_pair));
    current->next->exp = exp;
    current->next->idt = idt;
    current->next->next = NULL;
}

char* get_list(struct map_pair* head)
{
    struct map_pair* current = head;

    char list[1000] = "";
    char* ptr = list;

    while (current != NULL)
    {
        char temp[1000] = "";

        if (current->idt != NULL)
        {
	    sprintf(temp, "%s agtype", current->idt);
            strcat(list, temp);
        }
        else
        {
            char* temp2 = current->exp;
            int i = 0;

            while(temp2[i]!='\0')
            {
                if(temp2[i]=='.')
                    temp2[i]='_';
                i++;
            }

            sprintf(temp, "%s agtype%s", temp2, (current->next != NULL) ? ", " : "");
            strcat(list, temp);
        }

        current = current->next;
    }
    
    return ptr;
}

void psql_scan_cypher_command(char* data)
{
    YY_BUFFER_STATE buf = yy_scan_string(data);
    
    rtn_list = (struct map_pair*) malloc(sizeof(struct map_pair));
    
    yypush_buffer_state(buf);
    yyparse();
}

char* convert_to_psql_command(char* data)
{
    /* remove semicolon from query */
    data[strlen(data)-1] = '\0';

    sprintf(qry,
        "SELECT * "
        "FROM cypher('%s', $$ "
        "%s "
        "$$) AS (%s);",
        graph_name, data, (rtn == true) ? get_list(rtn_list) : "v agtype");

    printf("SENDING: %s\n", qry);

    reset_vals();

    return qry;
}

void reset_vals()
{
    free(rtn_list);

    match = false;
    where = false;
    with = false;
    rtn = false;
}
