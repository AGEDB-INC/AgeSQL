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

/* Private structs */
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

typedef struct yy_buffer_state* YY_BUFFER_STATE;

/* Function definitions */
bool yyerror(char const* s);

int yylex(void);

static char* get_declare_list(MapPair* list);
static char* get_id_list(MapPair* list);
static char* get_rtn_list(MapPair* list, MapPair* list2);
static void list_append(MapPair** list, char* exp, char* idt);

void *yy_scan_string(char const* str);
void free_memory (MapPair* list);
void init_list (MapPair* list);
void reset_vals(void);
void yypush_buffer_state(YY_BUFFER_STATE buffer);

/* Variable initializations */
bool alter = false;
bool alter_graph = false;
bool cascade = false;
bool comment = false;
bool create = false;
bool create_elabel = false;
bool create_function = false;
bool create_graph = false;
bool create_vlabel = false;
bool drop = false;
bool drop_graph = false;
bool drop_label = false;
bool execute = false;
bool explain = false;
bool inheritance = false;
bool load = false;
bool load_edges = false;
bool load_labels = false;
bool match = false;
bool merge = false;
bool optional = false;
bool prepare = false;
bool reindex = false;
bool rename_graph = false;
bool return_query = false;
bool rtn = false;
bool set = false;
bool set_path = false;
bool show = false;
bool sql_select = false;
bool unwind = false;
bool where = false;
bool with = false;
bool with_ids = false;

char* alter_graph_name;
char* edge_name;
char* file_path;
char* graph_name;
char* label_name;
char* prepare_stmt;
char* qry;

int order_clause_direction = 1; // 1 for ascending, -1 for descending
int rel_direction = 0; // 1 for "->", -1 for "<-"

static struct MapPair* declare_list = NULL;
static struct MapPair* id_val_list = NULL;
static struct MapPair* rtn_list = NULL;
static struct MapPair* type_list = NULL;
%}

%union
{
    char* str_val;
    int int_val;
    float float_val;

    bool bool_val;
    struct EdgePattern* pat;
    struct MapPair* pair;
}

%type <bool_val>    dot_opt

%type <pair>        node_properties_opt map_literal nonempty_map_literal
                    map_entry return_item_list item id_list

%type <pat>         variable_length_edges_opt edge_length_opt

%type <int_val>     upper_bound_opt sort_direction_opt

%type <str_val>     node_alias_opt node_labels_opt expression_list expression
                    math_expression function rel_alias_opt rel_labels_opt
                    compare logic typecast_opt str_val expression_opt
                    graph_path_list

%token
    ALTER AND AS ASC ASSERT ASTERISK

    BGN BY
    
    CALLED CARET CASCADE CASE CLUSTER COLON COMMA COMMENT CONSTRAINT CONTAINS
    COSTSOFF CREATE
    
    DASH DELETE DECLARE DESC DETACH DISABLE DISTINCT DOLLAR DOT DROP
    
    EDGES ELABEL ELSE END ENDS EQUALS EQUALSTILDE EXCLAMATION EXECUTE EXISTS
    EXPLAIN
    
    FAL FROM FUNCTION
    
    GRAPH GRAPH_PATH GT
    
    IDS IF IMMUTABLE IN INDEX INHERIT INHERITS INPUT INTO IS
    
    LABELS LANGUAGE LBRACE LBRACKET LIMIT LOAD LOGGED LPAREN LT
    
    MATCH MERGE
    
    NOINHERIT NOT NUL
    
    OPTIONAL ON ONLY OR ORDER OWNER
    
    PARALLEL PERCENT PERFORM PIPE PLUS PREPARE
    
    QUERY
    
    RBRACE RBRACKET REINDEX REMOVE RENAME REPLACE RETURN RETURNS RPAREN
    
    SAFE SELECT SEMICOLON SET SETOF SHOW SKIP SLASH STABLE STARTS STORAGE
    STRICT
    
    TABLESPACE THEN TRU
    
    UNDER UNION UNIONALL UNIQUE UNLOGGED UNWIND
    
    VERBOSE VLABEL VOLATILE
    
    WHEN WHERE WITH WITHOUT
    
    XOR

%token <int_val>    INTEGER

%token <float_val>  FLOAT

%token <str_val>    IDENTIFIER STRING

%token              UNKNOWN

%left               ARROW PIPE

%start              statement

%%
statement:
    queries SEMICOLON { YYACCEPT; }
    ;

queries:
    query
    | set_graph_clause { set_path = true; }
    | queries query
    ;

query:
    alter_clause { alter = true; }
    | comment_clause { comment = true; }
    | create_clause
    | delete_clause
    | drop_clause { drop = true; }
    | execute_clause { execute = true; }
    | exists_clause
    | explain_clause { explain = true; }
    | load_clause { load = true; }
    | match_clause { match = true; }
    | merge_clause { merge = true; }
    | prepare_clause { prepare = true; }
    | reindex_clause { reindex = true; }
    | remove_clause
    | return_clause { rtn = true; }
    | show_clause { show = true; }
    | sql_statement
    | unwind_clause { unwind = true; }
    | where_clause { where = true; }
    | with_clause { with = true; }
    ;

/*****************************************************************************
 *
 * ALTER clause
 *
 *****************************************************************************/

alter_clause:
    ALTER GRAPH IDENTIFIER alter_graph_options { graph_name = $3; }
    | ALTER VLABEL if_exists_opt IDENTIFIER alter_vlabel_options 
    ;

alter_graph_options:
    OWNER IDENTIFIER { alter_graph = true; }
    | RENAME IDENTIFIER { alter_graph_name = $2; rename_graph = true; }
    ;

alter_vlabel_options:
    CLUSTER ON IDENTIFIER
    | DISABLE INDEX
    | INHERIT IDENTIFIER
    | NOINHERIT IDENTIFIER
    | OWNER IDENTIFIER
    | RENAME IDENTIFIER
    | SET LOGGED
    | SET STORAGE IDENTIFIER
    | SET UNLOGGED
    | SET WITHOUT CLUSTER
    ;

/*****************************************************************************
 *
 * CASE clause
 *
 *****************************************************************************/

case_clause:
    CASE identifier_opt WHEN math_expression THEN math_expression ELSE
    math_expression END
    ;

/*****************************************************************************
 *
 * COMMENT clause
 *
 *****************************************************************************/

comment_clause:
    COMMENT ON comment_item IDENTIFIER IS STRING
    ;

comment_item:
    GRAPH
    | VLABEL
    ;

/*****************************************************************************
 *
 * CREATE clause
 *
 *****************************************************************************/
 
 create_clause:
    CREATE create_pattern
    ;

create_pattern:
    CONSTRAINT constraint_patt { create = true; }
    | logged_opt ELABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt
      tablespace_opt disable_index_opt { edge_name = $4; create_elabel = true; }
    | logged_opt GRAPH if_exists_opt IDENTIFIER tablespace_opt disable_index_opt
      { graph_name = $4; create_graph = true; }
    | logged_opt VLABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt
      tablespace_opt disable_index_opt { label_name = $4; create_vlabel = true; }
    | or_replace_opt FUNCTION function RETURNS setof_opt expression
      create_function_ext_opt { create_function = true; }
    | pattern_list set_clause_opt { create = true; }
    ;

logged_opt:
    /* empty */
    | LOGGED
    | UNLOGGED
    ;

inherits_opt:
    /* empty */
    | INHERITS expression { inheritance = true; }
    | INHERITS LPAREN id_list RPAREN { inheritance = true; }
    ;

on_clause_opt:
    /* empty */
    | on_clause
    ;

tablespace_opt:
    /* emtpy */
    | TABLESPACE IDENTIFIER
    ;

disable_index_opt:
    /* empty */
    | DISABLE INDEX
    ;

constraint_patt:
    identifier_opt ON IDENTIFIER assert_patt_opt
    ;

assert_patt_opt:
    /* empty */
    | ASSERT compare_list
    | ASSERT LPAREN compare_list RPAREN
    ;

compare_list:
    math_expression constraint_addon_opt
    | math_expression constraint_addon_opt logic compare_list
    ;

constraint_addon_opt:
    /* empty */
    | IS not_opt UNIQUE constraint_addon_opt
    | IS not_opt NUL constraint_addon_opt
    | not_opt IN expression constraint_addon_opt
    ; 

or_replace_opt:
    /* empty */
    | OR REPLACE
    ;

setof_opt:
    /* empty */
    | SETOF
    ;

create_function_ext_opt:
    /* empty */
    | create_function_exts
    ;

create_function_exts:
    create_function_ext
    | create_function_exts create_function_ext
    ;

create_function_ext:
    LANGUAGE str_val
    | VOLATILE
    | IMMUTABLE
    | STABLE
    | PARALLEL SAFE
    | STRICT
    | CALLED ON NUL INPUT
    | RETURNS NUL ON NUL INPUT
    | AS str_val
    | AS DOLLAR identifier_opt DOLLAR
      declare_opt
      BGN
          create_function_contents
      END
      DOLLAR identifier_opt DOLLAR
    ;

declare_opt:
    /* empty */
    | DECLARE declare_list
    ;

declare_list:
    IDENTIFIER IDENTIFIER SEMICOLON { declare_list->idt = $1; }
    | declare_list IDENTIFIER IDENTIFIER SEMICOLON
      { list_append(&declare_list, NULL, $2); }
    ;

create_function_contents:
    create_function_content
    | create_function_contents create_function_content
    ;

create_function_content:
    math_expression SEMICOLON
    | queries into_opt SEMICOLON
    | RETURN QUERY queries into_opt SEMICOLON { return_query = true; }
    ;

into_opt:
    /* empty */
    | INTO identifier_list
    ;

/*****************************************************************************
 *
 * DELETE clause
 *
 *****************************************************************************/

delete_clause:
    detach_opt DELETE expression_list set_clause_opt
    ;

detach_opt:
    /* empty */
    | DETACH
    ;

/*****************************************************************************
 *
 * DROP clause
 *
 *****************************************************************************/

drop_clause:
    DROP drop_pattern
    ;

drop_pattern:
    CONSTRAINT identifier_opt ON IDENTIFIER assert_patt_opt
    | ELABEL IDENTIFIER cascade_opt { label_name = $2; drop_label = true; }
    | GRAPH if_exists_opt IDENTIFIER cascade_opt
      { graph_name = $3; drop_graph = true; }
    | VLABEL IDENTIFIER cascade_opt { label_name = $2; drop_label = true; }
    ;

cascade_opt:
    /* empty */
    | CASCADE { cascade = true; }
    ;

/*****************************************************************************
 *
 * EXECUTE clause
 *
 *****************************************************************************/

execute_clause:
    EXECUTE IDENTIFIER stmt_info_opt
    ;

stmt_info_opt:
    /* empty */
    | LPAREN item_list RPAREN
    ;

/*****************************************************************************
 *
 * EXISTS clause
 *
 *****************************************************************************/

exists_clause:
    EXISTS LPAREN exists_pattern RPAREN
    ;

exists_pattern:
    expression
    | path_pattern
    ;

/*****************************************************************************
 *
 * EXPLAIN clause
 *
 *****************************************************************************/

explain_clause:
    EXPLAIN explain_list
    | EXPLAIN LPAREN explain_list RPAREN
    ;

explain_list:
    explain_item
    | explain_list COMMA explain_item
    ;

explain_item:
    VERBOSE boolean_opt
    | COSTSOFF boolean_opt
    | IDENTIFIER boolean_opt
    ;

/*****************************************************************************
 *
 * LOAD clause
 *
 *****************************************************************************/

load_clause:
    LOAD load_pattern
    ;

load_pattern:
    FROM IDENTIFIER as_opt
    | LABELS with_id_opt IDENTIFIER FROM STRING ON IDENTIFIER
      {
        label_name = $3; file_path = $5; graph_name = $7; load_labels = true;
      }
    | EDGES IDENTIFIER FROM STRING ON IDENTIFIER
      {
        edge_name = $2; file_path = $4; graph_name = $6; load_edges = true;
      }
    ;

with_id_opt:
    /* empty */
    | WITH IDS { with_ids = true; }
    ;

/*****************************************************************************
 *
 * MATCH clause
 *
 *****************************************************************************/

match_clause:
    optional_opt MATCH pattern_list set_clause_opt
    ;

optional_opt:
    /* empty */
    | OPTIONAL { optional = true; }
    ;

pattern_list:
    assign_to_variable_opt path_pattern_list
    | assign_to_variable_opt LPAREN path_pattern_list RPAREN
    ;

assign_to_variable_opt:
    /* empty */
    | IDENTIFIER EQUALS
    ;

path_pattern_list:
    path_pattern
    | path_pattern_list COMMA assign_to_variable_opt path_pattern
    ;

path_pattern:
    node_pattern
    | path_pattern edge_pattern node_pattern
    ;

node_pattern:
    LPAREN node_alias_opt node_labels_opt node_properties_opt only_opt
    dollar_opt RPAREN
    | LPAREN IDENTIFIER compare expression only_opt RPAREN
    | LPAREN EQUALS expression RPAREN
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

map_literal:
    /* empty */ { $$ = NULL; }
    | nonempty_map_literal { $$ = $1; }
    ;

nonempty_map_literal:
    map_entry { $$ = $1; }
    | nonempty_map_literal COMMA map_entry { $$ = $3; }
    ;

map_entry:
    IDENTIFIER COLON math_expression 
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->idt = $1;
        $$->exp = $3;
    }
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
    LBRACKET rel_alias_opt rel_labels_opt only_opt variable_length_edges_opt
    node_properties_opt RBRACKET
    | LBRACKET IDENTIFIER compare expression only_opt RBRACKET
    ;

rel_alias_opt:
    /* empty */ { $$ = NULL; }
    | IDENTIFIER { $$ = $1; }
    ;

rel_labels_opt:
    /* empty */ { $$ = NULL; }
    | COLON IDENTIFIER pipe_opt expression_opt { $$ = $2; } 
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
    | INTEGER dot_opt upper_bound_opt 
      { 
        $$ = (EdgePattern*) malloc(sizeof(EdgePattern));
        $$->lower = $1; 
        $$->dot = $2;
        $$->upper = $3;
      }
    | DOT DOT INTEGER 
      { 
        $$ = (EdgePattern*) malloc(sizeof(EdgePattern));
        $$->upper = $3; 
      }
    ;

dot_opt:
    /* empty */ { $$ = false; } 
    | DOT DOT { $$ = true; }
    ;

upper_bound_opt:
    /* empty */ { $$ = 0; }
    | INTEGER { $$ = $1; }
    ;

/*****************************************************************************
 *
 * MERGE clause
 *
 *****************************************************************************/

merge_clause:
    MERGE path_pattern set_clause_opt
    ;

/*****************************************************************************
 *
 * ON clause
 *
 *****************************************************************************/

on_clause:
    ON on_pattern
    ;

on_pattern:
    CREATE
    | MATCH
    ;

/*****************************************************************************
 *
 * ORDER clause
 *
 *****************************************************************************/

order_clause:
    ORDER BY sort_item_list
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

/*****************************************************************************
 *
 * PREPARE clause
 *
 *****************************************************************************/

prepare_clause:
    PREPARE IDENTIFIER stmt_info_opt AS 
    ;

/*****************************************************************************
 *
 * REINDEX clause
 *
 *****************************************************************************/

reindex_clause:
    REINDEX VLABEL IDENTIFIER
    ;

/*****************************************************************************
 *
 * REMOVE clause
 *
 *****************************************************************************/

remove_clause:
    REMOVE expression_list
    ;

/*****************************************************************************
 *
 * RETURN clause
 *
 *****************************************************************************/

return_clause:
    RETURN distinct_not_opt return_item_clause union_opt
    ;

distinct_not_opt:
    /* empty */
    | DISTINCT
    | NOT
    ;

return_item_clause:
    return_item_list str_match_clause_opt order_clause_opt skip_clause_opt
    limit_clause_opt
    | LBRACKET return_item_list str_match_clause_opt RBRACKET order_clause_opt
      skip_clause_opt limit_clause_opt
    ;

return_item_list:
    item typecast_opt
    { rtn_list->exp = $1->exp; rtn_list->idt = $1->idt; type_list->exp = $2; }
    | return_item_list COMMA item typecast_opt
      {
        list_append(&rtn_list, $3->exp, $3->idt);
        list_append(&type_list, $4, NULL);
      }
    ;

str_match_clause_opt:
    /* empty */
    | STARTS WITH expression
    | ENDS WITH expression
    | CONTAINS expression
    | EQUALSTILDE expression
    ;

union_opt:
    /* empty */
    | UNION
    | UNIONALL
    ;

/*****************************************************************************
 *
 * SET clause
 *
 *****************************************************************************/

set_clause:
    SET assign_list { set = true; }
    | set_clause SET assign_list
    ;

assign_list:
    math_expression
    | assign_list COMMA math_expression
    ;

/*****************************************************************************
 *
 * SET GRAPH clause
 *
 *****************************************************************************/

set_graph_clause:
    SET graph_option EQUALS graph_path_list { graph_name = $4; }
    ;

graph_option:
    GRAPH
    | GRAPH_PATH
    ;

graph_path_list:
    IDENTIFIER { $$ = $1; }
    | graph_path_list COMMA IDENTIFIER
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s, %s", $1, $3); $$ = temp;
        free(temp);
      }
    ;

/*****************************************************************************
 *
 * SHOW clause
 *
 *****************************************************************************/

show_clause:
    SHOW graph_option
    ;

/*****************************************************************************
 *
 * SQL statement
 *
 *****************************************************************************/
 
sql_statement:
    sql_query
    ;

sql_query:
    select_clause { sql_select = true; }
    ;

/*****************************************************************************
 *
 * SQL SELECT clause
 *
 *****************************************************************************/

select_clause:
    SELECT expression_list from_clause
    ;

from_clause:
    FROM LPAREN queries RPAREN as_clause
    ;

as_clause:
    AS IDENTIFIER
    | AS UNDER LPAREN identifier_list RPAREN
    ;

/*****************************************************************************
 *
 * UNWIND clause
 *
 *****************************************************************************/

unwind_clause:
    UNWIND expression AS IDENTIFIER
    ;

/*****************************************************************************
 *
 * WHERE clause
 *
 *****************************************************************************/

where_clause:
    WHERE where_expressions
    ;

where_expressions:
    where_expression
    | where_expressions logic where_expression

where_expression:
    exists_clause
    | not_opt expression where_compare_opt
    ;

where_compare_opt:
    /* empty */
    | compare not_opt expression
    | IS not_opt expression
    | not_opt IN not_opt expression
    ;

/*****************************************************************************
 *
 * WITH clause
 *
 *****************************************************************************/

with_clause:
    WITH distinct_opt item_clause
    ;

item_clause:
    item_list order_clause_opt skip_clause_opt limit_clause_opt
    | LPAREN item_list RPAREN order_clause_opt skip_clause_opt limit_clause_opt
    ;

/*****************************************************************************
 *
 * Shared statements
 *
 *****************************************************************************/
 
%{
#include <stdio.h>
#include <stdlib.h>
%}

%union {
    char* str;
}

%token <str> INTEGER FLOAT IDENTIFIER
%token EQUALS EXCLAMATION LT GT
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET COMMA DOLLAR ASTERISK
%type <str> boolean expression expression_list expression_ext_opt negative_opt array_opt dot_operator_opt
%type <str> function function_params_opt function_params_list id_list

%%

boolean: TRU | FAL;

compare:
    EQUALS                 { $$ = "="; }
  | EQUALS EQUALS          { $$ = "=="; }
  | EXCLAMATION EQUALS     { $$ = "!="; }
  | LT                     { $$ = "<"; }
  | GT                     { $$ = ">"; }
  | LT EQUALS              { $$ = "<="; }
  | GT EQUALS              { $$ = ">="; }
  | LT GT                  { $$ = "<>"; }
  ;

expression_list:
    expression expression_ext_opt { $$ = $1; }
  | expression_list COMMA expression expression_ext_opt { $$ = $1; }
  ;

expression:
    NUL                      { $$ = "!_null"; }
  | negative_opt INTEGER     { $$ = $2; }
  | negative_opt FLOAT       { $$ = $2; }
  | str_val array_opt dot_operator_opt { $$ = $1; }
  | boolean                 { $$ = "?_bool"; }
  | LBRACE map_literal RBRACE { $$ = "{}_property"; }
  | LPAREN sql_statement RPAREN { $$ = "|_sql"; }
  | function array_opt dot_operator_opt { $$ = $1; }
  | DOLLAR INTEGER          { $$ = "dollar_int"; }
  | DOLLAR IDENTIFIER       { $$ = "dollar_identifier"; }
  | ASTERISK                { $$ = "*"; }
  ;

negative_opt: /* empty */ | DASH;

array_opt: /* empty */ | LBRACKET expression RBRACKET;

dot_operator_opt: /* empty */ | DOT IDENTIFIER;

expression_ext_opt: /* empty */ | IN expression;

function: IDENTIFIER LPAREN function_params_opt RPAREN { $$ = $1; };

function_params_opt: /* empty */ | function_params_list;

function_params_list: expression_list | path_pattern;

id_list: IDENTIFIER {
    $$ = (char*)malloc(strlen($1) + 1);
    strcpy($$, $1);
    list_append(&id_val_list, $$);
  }
  | IDENTIFIER COMMA id_list {
    $$ = (char*)malloc(strlen($1) + 1);
    strcpy($$, $1);
    list_append(&id_val_list, $$);
  };

%%

int main() {
    // Implement your parsing and code execution logic here
    yyparse();
    return 0;
}

    | IDENTIFIER IN expression
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $1;
    }
    ;

identifier_list:
    IDENTIFIER
    | identifier_list COMMA IDENTIFIER
    ;

item_list:
    item 
    | item_list COMMA item 
    ;

item:
    math_expression is_expression_opt
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = $1;
        $$->idt = NULL;
    }
    | math_expression is_expression_opt AS IDENTIFIER
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $4;
      }
    | math_expression IN math_expression
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = "bool";
        $$->idt = NULL;
      }
    | math_expression IN math_expression PIPE expression
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = $5;
        $$->idt = NULL;
      }
    | exists_clause
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = "bool";
        $$->idt = NULL;
      }
    | exists_clause AS IDENTIFIER
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $3;
      }
    | case_clause
      {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = "case";
        $$->idt = NULL;
      }
    ;

is_expression_opt:
    /* empty */
    | IS not_opt expression
    ;

logic:
    AND { $$ = "AND"; }
    | OR { $$ = "OR"; }
    | XOR { $$ = "XOR"; }
    ;

math_expression:
    expression { $$ = $1; }
    | math_expression compare expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s = %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression PLUS expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s + %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression PLUS EQUALS expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s += %s", $1, $4);
        $$ = temp;
        free(temp);
      }
    | math_expression DASH expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s - %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression DASH EQUALS expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s -= %s", $1, $4);
        $$ = temp;
        free(temp);
      }
    | math_expression ASTERISK expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s * %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression ASTERISK EQUALS expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s *= %s", $1, $4);
        $$ = temp;
        free(temp);
      }
    | math_expression SLASH expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s / %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression SLASH EQUALS expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s /= %s", $1, $4);
        $$ = temp;
        free(temp);
      }
    | math_expression PERCENT expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s %% %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    | math_expression CARET expression
      {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s ^ %s", $1, $3);
        $$ = temp;
        free(temp);
      }
    ;

str_val:
    IDENTIFIER { $$ = $1; }
    | STRING { $$ = $1; }
    ;

/*****************************************************************************
 *
 * Optional statements
 *
 *****************************************************************************/

as_opt:
    /* empty */
    | AS IDENTIFIER
    ;

boolean_opt:
    /* empty */
    | boolean
    ;

distinct_opt:
    /* empty */
    | DISTINCT
    ;

expression_opt:
    /* empty */ { $$ = NULL; }
    | EQUALS expression { $$ = $2; }
    ;

identifier_opt:
    /* empty */
    | IDENTIFIER
    ;

if_exists_opt:
    /* empty */
    | IF not_opt EXISTS
    ;

limit_clause_opt:
    /* empty */
    | LIMIT INTEGER
    ;

not_opt:
    /* empty */
    | NOT
    ;

order_clause_opt:
    /* empty */
    | order_clause
    ;

set_clause_opt:
    /* empty */
    | set_clause
    ;

skip_clause_opt:
    /* empty */
    | SKIP INTEGER
    ;

typecast_opt:
    /* empty */ { $$ = "agtype"; }
    | COLON COLON str_val
      {
	    if (strcmp($3, "pg_bigint") == 0 || strcmp($3, "numeric") == 0)
            $$ = "int";
        else if (strcmp($3, "pg_float8") == 0)
            $$ = "float";
        else
            $$ = $3;
      }
    ;
%%

bool
psql_scan_cypher_command(char* data)
{
    YY_BUFFER_STATE buf;
    rtn_list = (MapPair*) malloc(sizeof(MapPair));
    type_list = (MapPair*) malloc(sizeof(MapPair));
    declare_list = (MapPair*) malloc(sizeof(MapPair));
    id_val_list = (MapPair*) malloc(sizeof(MapPair));    

    init_list(rtn_list);
    init_list(type_list);
    init_list(declare_list);
    init_list(id_val_list);

    buf = yy_scan_string(data);
    yypush_buffer_state(buf);
    yyparse();

    if
    (
        alter || comment || create || create_elabel || create_graph || create_vlabel ||
        drop || execute || load || match || merge || optional || prepare || reindex ||
        rtn || set_path || show || unwind
    )
        return true;
    
    return false;
}

bool yyerror(char const* s)
{
    if
    (
        alter || comment || create || create_elabel || create_graph || create_vlabel ||
        drop || execute || load || match || merge || optional || prepare || reindex ||
        rtn || set_path || show || unwind
    )
        printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);

    reset_vals();
    
    return false;
}

/* Function to convert a data query to a PostgreSQL command */
char* convert_to_psql_command(char* data)
{
    char* after_cypher = NULL;
    char* before_cypher = NULL;
    char* temp = NULL;

    /* Remove semicolon from query */
    data[strlen(data) - 1] = '\0';

    if (create_function || explain || sql_select)
    {
        int index = 0;              // Keep track of the index of the found keyword
        int keyword_index = 0;      // Keep track of the temp index of the found keyword
        char* found = NULL;         // Temp pointer to the start of the found keyword
        char* found_end = NULL;     // Pointer to the start of the found end keyword
        char* found_start = NULL;   // Pointer to the start of the found start keyword
        char* start_keywords[] =    // Kewords to look out for
            {
                "ALTER ", "alter ",
                "CREATE ", "create ",
                "DROP ", "drop ",
                "EXECUTE ", "execute ",
                "FROM (", "from (",
                "LOAD ", "load ",
                "MATCH ", "match ",
                "MERGE ", "merge ",
                "PREPARE ", "prepare ",
                "RETURN ", "return "
            };

        /* Loop through the keywords and find the first occurrence in the query */
        for (int i = 0; i < sizeof(start_keywords) / sizeof(start_keywords[0]); i++)
        {
            found = strstr(data, start_keywords[i]);

            if (found)
            {
                if (!strcmp(start_keywords[i], "FROM (") || !strcmp(start_keywords[i], "from ("))
                    found += 6;
                else if (!strcmp(start_keywords[i], "RETURN ") || !strcmp(start_keywords[i], "return "))
                    found += 13;
                
                keyword_index = found - data;

                if (index == 0 || keyword_index < index)
                {
                    found_start = strdup(found);
                    index = keyword_index;
                }
            }
        }

        /* 
         * If any keyword is found, remove the rest of the query and update
         * temp with the found keyword
         */
        if (found_start)
        {
            data[index] = '\0';
            asprintf(&before_cypher, " %s", data);
            data = found_start;

            if (create_function)
            {
                char* semicolon_found = strstr(data, ";");

                if (semicolon_found)
                {
                    int semicolon_index = semicolon_found - data;
                    found_end = strdup(semicolon_found);
                    index = semicolon_index;
                }
            }

            else
            {
                char* end_keywords[] =
                    {
                        ") AS ", ") as ",
                        ") AS _(", ") as _("
                    };

                /* Loop through the keywords and find the first occurrence in the query */
                for (int i = 0; i < sizeof(end_keywords) / sizeof(end_keywords[0]); i++)
                {   
                    found = strstr(data, end_keywords[i]);

                    if (found)
                    {
                        keyword_index = found - data;
                        found_end = strdup(found);
                        index = keyword_index;
                    }
                }
            }
            
            if (found_end)
            {
                data[index] = '\0';
                after_cypher = strdup(found_end);
                free(found_end);
            }

        free(found_start);
        }
    }

    if (create_elabel)
    {
        if (inheritance)
        {
            asprintf(&temp,
                "%s"
                "SELECT * "
                "FROM create_elabel('%s', '%s', ARRAY[%s])"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                label_name,
                get_id_list(id_val_list),
                after_cypher ? after_cypher : "");
        }

        else
        {
            asprintf(&temp,
                "%s"
                "SELECT * "
                "FROM create_elabel('%s', '%s')"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                edge_name,
                after_cypher ? after_cypher : "");
        }
    }

    else if (create_function)
    {
        if (return_query)
        {
            asprintf(&temp,
                "%s "
                "SELECT * "
                "FROM cypher('%s', $CYPHER$ "
                "%s "
                "$CYPHER$%s) AS (%s)"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                data,
                declare_list->idt ? get_declare_list(declare_list) : "",
                rtn_list->idt || rtn_list->exp ? get_rtn_list(rtn_list, type_list) : "v agtype",
                after_cypher ? after_cypher : "");
        }

        else
        {
            asprintf(&temp,
                "%s "
                "PERFORM * "
                "FROM cypher('%s', $CYPHER$ "
                "%s "
                "$CYPHER$%s) AS (%s)"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                data,
                declare_list->idt ? get_declare_list(declare_list) : "",
                rtn_list->idt || rtn_list->exp ? get_rtn_list(rtn_list, type_list) : "v agtype",
                after_cypher ? after_cypher : "");
        }
    }

    else if (create_graph)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM create_graph('%s')"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            after_cypher ? after_cypher : "");
    }

    else if (create_vlabel)
    {
        if (inheritance)
        {
            asprintf(&temp,
                "%s"
                "SELECT * "
                "FROM create_vlabel('%s', '%s', ARRAY[%s])"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                label_name,
                get_id_list(id_val_list),
                after_cypher ? after_cypher : "");
        }

        else
        {
            asprintf(&temp,
                "%s"
                "SELECT * "
                "FROM create_vlabel('%s', '%s')"
                "%s;",
                before_cypher ? before_cypher : "",
                graph_name ? graph_name : pset.graph_name,
                label_name,
                after_cypher ? after_cypher : "");
        }
    }

    else if (drop_graph)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM drop_graph('%s', %s)"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            cascade ? "true" : "false",
            after_cypher ? after_cypher : "");
    }

    else if (drop_label)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM drop_label('%s', '%s')"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            label_name,
            after_cypher ? after_cypher : "");
    }

    else if (load_edges)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM load_edges_from_file('%s', '%s', '%s')"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            label_name,
            file_path,
            after_cypher ? after_cypher : "");
    }

    else if (load_labels)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM load_labels_from_file('%s', '%s', '%s', %s)"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            label_name,
            file_path,
            with_ids ? "true" : "false",
            after_cypher ? after_cypher : "");
    }

    else if (prepare)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM age_prepare_cypher('%s', '%s')"
            "%s;",
            before_cypher ? after_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            "Not supported",
            after_cypher ? after_cypher : "");
    }

    else if (rename_graph)
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM alter_graph('%s', 'RENAME', '%s')"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            alter_graph_name,
            after_cypher ? after_cypher : "");
    }

    else if (set_path)
    {
        /* Set graph name */
        if (set_path)
        {
            pset.graph_name = yylval.str_val;
            graph_name = yylval.str_val;
            printf("SET\n");
        }
    }

    else if (show)
    {
        printf("\nGRAPH_PATH = %s\n", graph_name);
    }

    else
    {
        asprintf(&temp,
            "%s"
            "SELECT * "
            "FROM cypher('%s', $$ "
            "%s "
            "$$) AS (%s)"
            "%s;",
            before_cypher ? before_cypher : "",
            graph_name ? graph_name : pset.graph_name,
            data, 
            rtn_list->idt || rtn_list->exp ? get_rtn_list(rtn_list, type_list) : "v agtype",
            after_cypher ? after_cypher : "");
    }

    qry = temp ? strdup(temp) : NULL;

    /* Uncomment for debug information */
    // printf("\nINFO: %s\n\n", qry);

    if (after_cypher) free(after_cypher);
    if (before_cypher) free(before_cypher);
    if (temp) free(temp);
    reset_vals();

    return qry;
}

char*
get_declare_list(MapPair* list)
{
    struct MapPair* current = list;
    char* str = malloc(1000);
    char temp[1000] = "";
    strcpy(str, "");

    while (current != NULL)
    {
        sprintf(temp, ", %s", current->idt);
        strcat(str, temp);
        current = current->next;
    }

    return str;
}

char*
get_id_list(MapPair* list)
{
    struct MapPair* current = list->next;
    char *str = malloc(100);
    char *temp = malloc(100);
    strcpy(str, "");
    strcpy(temp, "");

    while (current != NULL)
    {
        if (current->idt != NULL)
        {
            sprintf(temp, "\'%s\'%s", 
                  current->idt,              
                  (current->next != NULL) ? ", " : "");
        }

        strcat(str, temp);
        current = current->next;
    }
    return str;
}

char* get_rtn_list(MapPair* list, MapPair* list2)
{
    char* str = malloc(1000);
    char temp[1000] = "";
    int rtn_count = 1;

    strcpy(str, "");

    while (list != NULL && list2 != NULL)
    {
        char count_str[100];
        sprintf(count_str, "rtn_%d", rtn_count++);

        const char* idt = (list->idt != NULL) ? list->idt : count_str;
        const char* idt_type = (list2->idt != NULL) ? list2->idt : list2->exp;

        snprintf(temp, sizeof(temp), "%s %s%s",
                 idt, idt_type, (list->next != NULL) ? ", " : "");

        strcat(str, temp);

        list = list->next;
        list2 = list2->next;
    }

    return str;
}

void
list_append(MapPair** list, char* exp, char* idt)
{
    struct MapPair* current = *list;

    while (current->next != NULL) {
        current = current->next;
    }

    current->next = (MapPair*) malloc(sizeof(MapPair));
    current->next->exp = exp;
    current->next->idt = idt;
    current->next->next = NULL;
}

void free_memory (MapPair* list)
{
    MapPair* next;

    while (list != NULL)
    {
        next = list->next;
        free(list);
        list = next;
    }
    
    list = NULL;
}

void init_list (MapPair* list)
{    
    list->exp = NULL;
    list->idt = NULL;
    list->next = NULL;
}

void reset_vals(void)
{
    if (rtn_list) free_memory(rtn_list);
    if (type_list) free_memory(type_list);
    if (declare_list) free_memory(declare_list);
    if (id_val_list) free_memory(id_val_list);

    cascade = false;
    with_ids = false;
    match = false;
    where = false;
    with = false;
    rtn = false;
    set = false;
    set_path = false;
    inheritance = false;
    optional = false;
    explain = false;
    create = false;
    drop = false;
    alter = false;
    load = false;
    merge = false;
    unwind = false;
    prepare = false;
    execute = false;
    create_graph = false;
    create_vlabel = false;
    create_elabel = false;
    create_function = false;
    drop_label = false;
    drop_graph = false;
    alter_graph = false;
    rename_graph = false;
    load_labels = false;
    load_edges = false;
    reindex = false;
    comment = false;
    show = false;
    sql_select = false;
    return_query = false;

    alter_graph_name = NULL;
    label_name = NULL;
    edge_name = NULL;
    file_path = NULL;
}
