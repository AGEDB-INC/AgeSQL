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
#include "settings.h"

#include "fe_utils/psqlscan_int.h"
extern PsqlSettings pset;

typedef struct yy_buffer_state* YY_BUFFER_STATE;

typedef struct {
    char* str_val;
    int int_val;
    float float_val;
} yyval;

typedef struct EdgePattern {
    int lower;
    bool dot;
    int upper;
} EdgePattern;

typedef struct MapPair {
    char* exp;
    char* idt;
    struct MapPair* next;
} MapPair;

void yypush_buffer_state(YY_BUFFER_STATE buffer);
void *yy_scan_string(char const* str);
bool yyerror(char const* s);

static void list_append(MapPair* list, char* exp, char* idt);
static char* get_list(MapPair* list);
void reset_vals(void);

int yylex(void);
int rel_direction = 0; // 1 for "->", -1 for "<-"
int order_clause_direction = 1; // 1 for ascending, -1 for descending

bool match = false;
bool where = false;
bool with = false;
bool rtn = false;
bool create = false;
bool create_graph = false;

char* qry;
char* graph_name;

static struct MapPair* rtn_list = NULL;
%}

%union {
    char* str_val;
    int int_val;
    float float_val;
    bool bool_val;
    struct EdgePattern* pat;
    struct MapPair* pair;
}

%type <str_val> node_alias_opt node_labels_opt expression function rel_alias_opt rel_labels_opt compare logic
%type <int_val> upper_bound_opt sort_direction_opt
%type <bool_val> dot_opt
%type <pat> variable_length_edges_opt edge_length_opt
%type <pair> node_properties_opt map_literal nonempty_map_literal map_entry item_list item

%token ASC DESC DASH LT GT LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE
    ASTERISK DOT PLUS SLASH EQUALS DOLLAR OPTIONAL MATCH ONLY ON CREATE GRAPH EXPLAIN MERGE LOAD
    UNWIND WHERE EXISTS WITH ORDER BY SKIP LIMIT DELETE DETACH SET REMOVE RETURN DISTINCT AS AND OR
    XOR TRUE FALSE UNION ALL IS NOT NUL SELECT FROM
%token <int_val> INTEGER
%token <float_val> FLOAT
%token <str_val> IDENTIFIER STRING COMPARATOR
%token UNKNOWN

%left PIPE
%left ARROW

%start statement

%%
statement:
    query
    | statement query
    | statement SEMICOLON
      {      
          if (rtn == false)
              list_append(rtn_list, "v", NULL);
          
          YYACCEPT;
      }
    ;

query:
    match_clause
    | on_clause
    | create_clause
    | explain_clause
    | merge_clause
    | load_clause
    | unwind_clause
    | where_clause
    | exists_clause
    | with_clause
    | delete_clause
    | set_clause
    | remove_clause
    | return_clause
    ;

on_clause:
    ON CREATE
    | ON MATCH
    | ON IDENTIFIER { graph_name = $2; }
    ;

create_clause:
    CREATE { create = true; }
    | CREATE { create = true; } pattern_list
    | CREATE GRAPH IDENTIFIER { graph_name = $3; create_graph = true; }
    ;

explain_clause:
    EXPLAIN LPAREN "VERBOSE" COMMA "COSTS OFF" RPAREN

match_clause:
    optional_opt MATCH { match = true; } pattern_list
    ;

optional_opt:
    /* empty */
    | OPTIONAL
    ;

pattern_list:
    assign_to_variable_opt path_pattern
    | pattern_list COMMA assign_to_variable_opt path_pattern
    ;

assign_to_variable_opt:
    /* empty */
    | IDENTIFIER EQUALS
    ;

path_pattern:
    node_pattern
    | path_pattern edge_pattern node_pattern
    ;

node_pattern:
    LPAREN node_alias_opt node_labels_opt node_properties_opt only_opt dollar_opt RPAREN
    | LPAREN IDENTIFIER compare expression only_opt RPAREN
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

only_opt:
    /* empty */
    | ONLY
    ;

dollar_opt:
    /* empty */
    | DOLLAR IDENTIFIER
    ;

edge_pattern:
    DASH rel_pattern DASH { rel_direction = 0; }
    | LT DASH rel_pattern DASH { rel_direction = -1; }
    | DASH rel_pattern DASH GT { rel_direction = 1; }
    ;

rel_pattern:
    LBRACKET rel_alias_opt rel_labels_opt only_opt variable_length_edges_opt node_properties_opt RBRACKET
    | LBRACKET IDENTIFIER compare expression only_opt RBRACKET
    ;

rel_alias_opt:
    /* empty */ { $$ = NULL; }
    | IDENTIFIER { $$ = $1; }
    ;

rel_labels_opt:
    /* empty */ { $$ = NULL; }
    | COLON IDENTIFIER pipe_opt { $$ = $2; } 
    ;

pipe_opt:
    /* empty */
    | PIPE IDENTIFIER
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
    | IDENTIFIER COLON math_expression { $$->idt = $1; }
    ;

expression_list:
    expression
    | expression_list COMMA expression
    ;

expression:
    NUL { $$ = NULL; }
    | INTEGER { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%d", $1); $$ = temp; }
    | FLOAT { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%f", $1); $$ = temp; }
    | STRING array_opt dot_operator_opt { $$ = $1; }
    | IDENTIFIER array_opt dot_operator_opt { $$ = $1; }
    | LBRACKET list RBRACKET { $$ = "list"; }
    | LBRACE map_literal RBRACE { $$ = "property"; }
    | LPAREN sql_statement RPAREN { $$ = "sql"; }
    | function dot_operator_opt { $$ = $1; }
    | LPAREN function RPAREN array_opt dot_operator_opt { $$ = $2; }
    ;

dot_operator_opt:
    /* empty */
    | DOT IDENTIFIER
    ;

array_opt:
    /* empty */
    | LBRACKET expression RBRACKET
    ;

list:
    /* empty */
    | expression
    | list COMMA expression
    ;

function:
    IDENTIFIER LPAREN expression_list RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN path_pattern RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN ASTERISK RPAREN { $$ = $1; }
    ;

math_expression:
    expression
    | math_expression EQUALS expression
    | math_expression PLUS equals_opt expression
    | math_expression DASH equals_opt expression
    | math_expression ASTERISK equals_opt expression
    | math_expression SLASH equals_opt expression
    ;

equals_opt:
    /* empty */
    | EQUALS
    ;

merge_clause:
    MERGE path_pattern
    ;

load_clause:
    LOAD FROM IDENTIFIER
    | LOAD FROM IDENTIFIER AS IDENTIFIER
    ;

unwind_clause:
    UNWIND expression AS IDENTIFIER
    ;

where_clause:
    WHERE { where = true; } not_opt where_expression
    ;

where_expression:
    expression compare expression
    | expression IS not_opt expression
    | exists_clause
    | function
    | boolean
    | where_expression logic not_opt expression compare expression
    | where_expression logic not_opt expression IS not_opt expression
    | where_expression logic not_opt exists_clause
    | where_expression logic not_opt function
    | where_expression logic not_opt boolean
    ;

exists_clause:
    EXISTS LPAREN expression RPAREN
    | EXISTS LPAREN path_pattern RPAREN
    | exists_clause COMMA expression
    | exists_clause COMMA path_pattern
    ;

not_opt:
    /* empty */
    | NOT
    ;

compare:
    EQUALS { $$ = "="; }
    | COMPARATOR { $$ = $1; }
    | LT { $$ = "<"; }
    | GT { $$ = ">"; }
    ;

logic:
    AND { $$ = "AND"; }
    | OR { $$ = "OR"; }
    | XOR { $$ = "XOR"; }
    ;

boolean:
    TRUE
    | FALSE
    ;

with_clause:
    WITH { with = true; } item_clause
    | WITH { with = true; } ASTERISK
    ;

delete_clause:
    detach_opt DELETE expression_list
    ;

detach_opt:
    /* empty */
    | DETACH
    ;

set_clause:
    SET assign_list
    ;

assign_list:
    math_expression
    | assign_list COMMA math_expression
    ;

remove_clause:
    REMOVE expression_list
    ;

return_clause:
    RETURN distinct_opt { rtn = true; } item_clause union_opt
    | RETURN { rtn = true; } ASTERISK union_opt
    | RETURN { rtn = true; } not_opt exists_clause union_opt
    ;

distinct_opt:
    /* empty */
    | DISTINCT
    ;

item_clause:
    item_list order_clause_opt skip_clause_opt limit_clause_opt
    ;

item_list:
    item { list_append(rtn_list, $1->exp, $1->idt); }
    | item_list COMMA item { list_append(rtn_list, $3->exp, $3->idt); }
    ;

item:
    expression
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = $1;
        $$->idt = NULL;
    }
    | expression AS IDENTIFIER
      {
          $$ = (MapPair*) malloc(sizeof(MapPair));
          $$->exp = $1;
          $$->idt = $3;
      }
    | expression EQUALS expression AS IDENTIFIER
      {
          $$ = (MapPair*) malloc(sizeof(MapPair));
          $$->exp = NULL;
          $$->idt = $5;
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

union_opt:
    /* empty */
    | UNION
    | UNION ALL
    ;

sql_statement:
    sql_query
    | sql_statement sql_query
    ;

sql_query:
    select_clause
    | from_clause
    | where_clause
    ;

select_clause:
    SELECT expression
    ;

from_clause:
    FROM IDENTIFIER
    ;
%%

bool yyerror(char const* s)
{
    printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);

    return false;
}

void
list_append(MapPair* list, char* exp, char* idt)
{
    MapPair *current = (MapPair*) malloc(sizeof(MapPair));
    if (list == NULL)
    {
      list = current;
      current->exp = exp;
      current->idt = idt;
      current->next = NULL;
      return;
    }
    list->next = current;
    list->next->exp = exp;
    list->next->idt = idt;
    list->next->next = NULL;
}

char*
get_list(MapPair* list)
{
  struct MapPair* current = list;
  char *str = malloc(100);
  
  if (list == NULL)
  {
    sprintf(str, "a agtype");
    return str;
  }

  while (current != NULL)
  {
    if (current->idt != NULL)
      sprintf(str, "%s agtype%s", current->idt, (current->next != NULL) ? ", " : "");
    
    current = current->next;
  }
  return str;
}

bool
psql_scan_cypher_command(char* data)
{
    YY_BUFFER_STATE buf = yy_scan_string(data);
    yypush_buffer_state(buf);

    if (yyparse())
        return false;

    return true;
}

char* convert_to_psql_command(char* data)
{
    char temp[1000] = "";
    char* qry = NULL;

    /* Remove semicolon from query */
    data[strlen(data) - 1] = '\0';

    pset.graph_name = getenv("pset.graph_name");

    if (match || create)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM cypher('%s', $$ "
            "%s "
            "$$) AS (%s);",
            graph_name ? graph_name : pset.graph_name, data, get_list(rtn_list));
    }
    else if (create_graph)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM create_graph('%s');",
            graph_name ? graph_name : pset.graph_name);
    }

    qry = strdup(temp);

    /* Print debug information */
    printf("\nINFO: %s\n", qry);

    reset_vals();

    return qry;
}

void reset_vals(void)
{
    if (rtn_list)
      free(rtn_list);

    match = false;
    where = false;
    with = false;
    rtn = false;
    create = false;
    create_graph = false;
}
