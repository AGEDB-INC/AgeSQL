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

static void list_append(MapPair** list, char* exp, char* idt);
static char* get_rtn_list(MapPair* list, MapPair* list2);
static char* get_declare_list(MapPair* list);
static char* get_id_list(MapPair* list);
void reset_vals(void);
void free_memory (MapPair* list);
void init_list (MapPair* list);

int yylex(void);
int rel_direction = 0; // 1 for "->", -1 for "<-"
int order_clause_direction = 1; // 1 for ascending, -1 for descending

bool cascade = false;
bool with_ids = false;
bool match = false;
bool where = false;
bool with = false;
bool rtn = false;
bool set = false;
bool set_path = false;
bool inheritance = false;
bool optional = false;
bool explain = false;
bool create = false;
bool drop = false;
bool alter = false;
bool load = false;
bool merge = false;
bool unwind = false;
bool prepare = false;
bool execute = false;
bool create_graph = false;
bool create_vlabel = false;
bool create_elabel = false;
bool create_function = false;
bool drop_label = false;
bool drop_graph = false;
bool alter_graph = false;
bool rename_graph = false;
bool load_labels = false;
bool load_edges = false;
bool reindex = false;
bool comment = false;
bool show = false;
bool sql_select = false;
bool return_query = false;

char* qry;
char* graph_name;
char* alter_graph_name;
char* label_name;
char* edge_name;
char* file_path;
char* prepare_stmt;

static struct MapPair* rtn_list = NULL;
static struct MapPair* type_list = NULL;
static struct MapPair* id_val_list = NULL;
static struct MapPair* declare_list = NULL;
%}

%union {
    char* str_val;
    int int_val;
    float float_val;
    bool bool_val;
    struct EdgePattern* pat;
    struct MapPair* pair;
}

%type <str_val> node_alias_opt node_labels_opt expression_list expression math_expression function rel_alias_opt
    rel_labels_opt compare logic typecast_opt str_val expression_opt graph_path_list
%type <int_val> upper_bound_opt sort_direction_opt
%type <bool_val> dot_opt
%type <pat> variable_length_edges_opt edge_length_opt
%type <pair> node_properties_opt map_literal nonempty_map_literal map_entry return_item_list item id_list

%token
    ASC DESC DASH UNDER LT GT LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE
    ASTERISK DOT PLUS SLASH EQUALS DOLLAR EXCLAMATION EQUALSTILDE PERCENT CARET
    
    OPTIONAL MATCH ONLY ON CREATE GRAPH VLABEL
    ELABEL CONSTRAINT ASSERT UNIQUE INHERITS TABLESPACE DROP IF CASCADE ALTER STORAGE RENAME OWNER CLUSTER
    UNLOGGED LOGGED INHERIT NOINHERIT REINDEX INDEX DISABLE EXPLAIN VERBOSE COSTSOFF MERGE LOAD IDS LABELS
    EDGES UNWIND WHERE EXISTS WITH WITHOUT ORDER BY SKIP LIMIT DELETE DETACH SET REMOVE RETURN
    DISTINCT STARTS ENDS CONTAINS AS AND OR XOR TRU FAL UNION UNIONALL IS IN NOT NUL SELECT FROM
    GRAPH_PATH PREPARE EXECUTE COMMENT SHOW CASE WHEN THEN ELSE END FUNCTION REPLACE RETURNS SETOF
    LANGUAGE VOLATILE IMMUTABLE STABLE PARALLEL SAFE CALLED INPUT STRICT DECLARE PERFORM BGN QUERY INTO

%token <int_val> INTEGER
%token <float_val> FLOAT
%token <str_val> IDENTIFIER STRING
%token UNKNOWN

%left PIPE
%left ARROW

%start statement

%%
statement:
    queries SEMICOLON { YYACCEPT; }
    ;

queries:
    query
    | queries query
    ;

query:
    match_clause { match = true; }
    | on_clause
    | create_clause { create = true; }
    | drop_clause { drop = true; }
    | alter_clause { alter = true; }
    | explain_clause { explain = true; }
    | merge_clause { merge = true; }
    | load_clause { load = true; }
    | unwind_clause { unwind = true; }
    | where_clause { where = true; }
    | exists_clause
    | with_clause { with = true; }
    | delete_clause
    | remove_clause
    | return_clause { rtn = true; }
    | prepare_clause { prepare = true; }
    | execute_clause { execute = true; }
    | set_graph_clause { set_path = true; }
    | reindex_clause { reindex = true; }
    | comment_clause { comment = true; }
    | show_clause { show = true; }
    | sql_statement
    ;

prepare_clause:
    PREPARE IDENTIFIER stmt_info_opt AS 
    ;

stmt_info_opt:
    /* empty */
    | LPAREN item_list RPAREN
    ; 

execute_clause:
    EXECUTE IDENTIFIER stmt_info_opt
    ;

on_clause_opt:
    /* empty */
    | on_clause
    ;

on_clause:
    ON CREATE
    | ON MATCH
    ;

create_clause:
    CREATE pattern_list set_clause_opt { create = true; }
    | CREATE logged_opt GRAPH if_exists_opt IDENTIFIER tablespace_opt disable_index_opt { graph_name = $5; create_graph = true; }
    | CREATE logged_opt VLABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt tablespace_opt disable_index_opt { label_name = $5; create_vlabel = true; }
    | CREATE logged_opt ELABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt tablespace_opt disable_index_opt { edge_name = $5; create_elabel = true; }
    | CREATE CONSTRAINT constraint_patt
    | CREATE or_replace_opt FUNCTION function RETURNS setof_opt expression create_function_ext_opt { create_function = true; }
    ;

logged_opt:
    /* empty */
    | LOGGED
    | UNLOGGED
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
    | declare_list IDENTIFIER IDENTIFIER SEMICOLON { list_append(&declare_list, NULL, $2); }
    ;

create_function_contents:
    create_function_content
    | create_function_contents create_function_content
    ;

create_function_content:
    math_expression SEMICOLON
    | return_query_opt queries into_clause_opt SEMICOLON
    ;

return_query_opt:
    /* empty */
    | RETURN QUERY { return_query = true; }
    ;

into_clause_opt:
    /* empty */
    | into_clause
    ;

into_clause:
    INTO identifier_list
    ;

reindex_clause:
    REINDEX VLABEL IDENTIFIER
    ;

comment_clause:
    COMMENT ON GRAPH IDENTIFIER IS STRING
    | COMMENT ON VLABEL IDENTIFIER IS STRING
    ;

identifier_opt:
    /* empty */
    | IDENTIFIER
    ;

assert_patt_opt:
    /* empty */
    | ASSERT compare_list constraint_addon_opt
    | ASSERT LPAREN compare_list constraint_addon_opt RPAREN
    ;

compare_list:
    compare_expression
    | compare_list logic compare_expression
    ;

compare_expression:
    math_expression
    | compare_expression compare math_expression
    ;

constraint_addon_opt:
    /* empty */
    | IS not_opt UNIQUE
    | IS not_opt NUL
    | not_opt IN expression
    | constraint_addon_opt logic compare_expression IS not_opt UNIQUE
    | constraint_addon_opt logic compare_expression IS not_opt NUL
    ; 

inherits_opt:
    /* empty */
    | INHERITS { inheritance = true; } expression
    ;

drop_clause:
    DROP GRAPH if_exists_opt IDENTIFIER cascade_opt { graph_name = $4; drop_graph = true; }
    | DROP VLABEL IDENTIFIER cascade_opt { label_name = $3; drop_label = true; }
    | DROP ELABEL IDENTIFIER cascade_opt { label_name = $3; drop_label = true; }
    | DROP CONSTRAINT identifier_opt ON IDENTIFIER assert_patt_opt
    ;

if_exists_opt:
    /* empty */
    | IF not_opt EXISTS
    ;

cascade_opt:
    /* empty */
    | CASCADE { cascade = true; }
    ;

alter_clause:
    ALTER GRAPH IDENTIFIER alter_graph_options { graph_name = $3; }
    | ALTER VLABEL if_exists_opt IDENTIFIER alter_vlabel_options 
    ;

alter_graph_options:
    OWNER IDENTIFIER { alter_graph = true; }
    | RENAME IDENTIFIER { alter_graph_name = $2; rename_graph = true; }
    ;

alter_vlabel_options:
    SET STORAGE IDENTIFIER
    | RENAME IDENTIFIER
    | OWNER IDENTIFIER
    | CLUSTER ON IDENTIFIER
    | SET WITHOUT CLUSTER
    | SET UNLOGGED
    | SET LOGGED
    | NOINHERIT IDENTIFIER
    | INHERIT IDENTIFIER
    | DISABLE INDEX
    ;

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

boolean_opt:
    /* empty */
    | boolean
    ;

set_clause_opt:
    /* empty */
    | set_clause
    ;

set_clause:
    SET assign_list { set = true; }
    | set_clause SET assign_list
    ;

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

path_pattern_list:
    path_pattern
    | path_pattern_list COMMA assign_to_variable_opt path_pattern

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
    | LPAREN expression_opt RPAREN
    ;

expression_opt:
    /* empty */ { $$ = NULL; }
    | EQUALS expression { $$ = $2; }
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

expression_list:
    expression expression_ext_opt { $$ = $1; }
    | expression_list COMMA expression expression_ext_opt { $$ = $1; }
    ;

expression:
    NUL { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "!_null"); $$ = temp; free(temp); }
    | negative_opt INTEGER typecast_opt { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%d", $2); $$ = temp; free(temp); }
    | negative_opt FLOAT typecast_opt { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%f", $2); $$ = temp; free(temp); }
    | str_val array_opt dot_operator_opt typecast_opt as_clause_opt { $$ = $1; }
    | boolean { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "?_bool"); $$ = temp; free(temp); }
    | LBRACKET list RBRACKET { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "[]_list"); $$ = temp; free(temp); }
    | LBRACE map_literal RBRACE { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "{}_property"); $$ = temp; free(temp); }
    | LPAREN sql_statement RPAREN { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "|_sql"); $$ = temp; free(temp); }
    | function array_opt dot_operator_opt typecast_opt { $$ = $1; }
    | LPAREN function RPAREN array_opt dot_operator_opt { $$ = $2; }
    | LPAREN id_list RPAREN { $$ = $2->idt; }
    | DOLLAR INTEGER { $$ = "dollar_int"; }
    | DOLLAR IDENTIFIER { $$ = "dollar_identifier"; }
    | ASTERISK { $$ = "*"; }
    | LPAREN math_expression RPAREN { $$ = $2; }
    ;

negative_opt:
    /* empty */
    | DASH
    ;

str_val:
    IDENTIFIER { $$ = $1; }
    | STRING { $$ = $1; }
    ;

expression_ext_opt:
    /* empty */
    | IN expression where_clause_opt
    ;

where_clause_opt:
    /* empty */
    | where_clause
    ;

id_list:
    IDENTIFIER 
    { 
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $1;
        list_append(&id_val_list, $$->exp, $$->idt);
    }
    | IDENTIFIER COMMA id_list 
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $1;
        list_append(&id_val_list, $$->exp, $$->idt);
    }
    | IDENTIFIER IN expression
    {
        $$ = (MapPair*) malloc(sizeof(MapPair));
        $$->exp = NULL;
        $$->idt = $1;
    }
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
    IDENTIFIER LPAREN function_params_opt RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN expression_list RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN path_pattern RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN ASTERISK RPAREN { $$ = $1; }
    ;

function_params_opt:
    /* empty */
    | function_params
    ;

function_params:
    IDENTIFIER math_expression
    | function_params COMMA IDENTIFIER math_expression
    ;

math_expression:
    expression { $$ = $1; }
    | math_expression EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s = %s", $1, $3); $$ = temp; free(temp); }
    | math_expression PLUS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s + %s", $1, $3); $$ = temp; free(temp); }
    | math_expression PLUS EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s += %s", $1, $4); $$ = temp; free(temp); }
    | math_expression DASH expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s - %s", $1, $3); $$ = temp; free(temp); }
    | math_expression DASH EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s -= %s", $1, $4); $$ = temp; free(temp); }
    | math_expression ASTERISK expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s * %s", $1, $3); $$ = temp; free(temp); }
    | math_expression ASTERISK EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s *= %s", $1, $4); $$ = temp; free(temp);}
    | math_expression SLASH expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s / %s", $1, $3); $$ = temp; free(temp); }
    | math_expression SLASH EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s /= %s", $1, $4); $$ = temp; free(temp); }
    | math_expression PERCENT expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s %% %s", $1, $3); $$ = temp; free(temp); }
    | math_expression CARET expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s ^ %s", $1, $3); $$ = temp; free(temp); }
    ;

merge_clause:
    MERGE path_pattern set_clause_opt
    ;

load_clause:
    LOAD FROM IDENTIFIER
    | LOAD FROM IDENTIFIER AS IDENTIFIER
    | LOAD LABELS with_id_opt IDENTIFIER FROM STRING ON IDENTIFIER
      {
          label_name = $4; file_path = $6; graph_name = $8; load_labels = true;
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

unwind_clause:
    UNWIND expression AS IDENTIFIER
    ;

where_clause:
    WHERE not_opt where_expression
    ;

where_expression:
    expression compare expression
    | where_expression AND where_expression
    | expression IS not_opt expression
    | expression IN expression
    | exists_clause
    | function
    | boolean
    | where_expression logic not_opt expression compare expression
    | where_expression logic not_opt expression IS not_opt expression
    | where_expression logic not_opt exists_clause
    | where_expression logic not_opt function
    | where_expression logic not_opt boolean
    | IDENTIFIER
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
    | EQUALS EQUALS { $$ = "=="; }
    | EXCLAMATION EQUALS { $$ = "!="; }
    | LT { $$ = "<"; }
    | GT { $$ = ">"; }
    | LT EQUALS { $$ = "<="; }
    | GT EQUALS { $$ = ">="; }
    | LT GT { $$ = "<>"; }
    ;

logic:
    AND { $$ = "AND"; }
    | OR { $$ = "OR"; }
    | XOR { $$ = "XOR"; }
    ;

boolean:
    TRU
    | FAL
    ;

with_clause:
    WITH distinct_opt item_clause
    ;

delete_clause:
    detach_opt DELETE expression_list set_clause_opt
    ;

detach_opt:
    /* empty */
    | DETACH
    ;

set_graph_clause:
    SET GRAPH_PATH EQUALS graph_path_list { graph_name = $4; }
    | SET GRAPH EQUALS graph_path_list { graph_name = $4; }
    ;

show_clause:
    SHOW GRAPH_PATH
    | SHOW GRAPH
    ;

assign_list:
    math_expression
    | assign_list COMMA math_expression
    ;
    
graph_path_list:
    IDENTIFIER { $$ = $1; }
    | graph_path_list COMMA IDENTIFIER { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s, %s", $1, $3); $$ = temp; free(temp); }
    ;

remove_clause:
    REMOVE expression_list
    ;

return_clause:
    RETURN distinct_opt return_item_clause union_opt
    | RETURN not_opt exists_clause union_opt
    ;

case_clause:
    CASE IDENTIFIER WHEN math_expression THEN math_expression ELSE math_expression END
    | CASE WHEN math_expression THEN math_expression ELSE math_expression END
    ;

distinct_opt:
    /* empty */
    | DISTINCT
    ;

return_item_clause:
    return_item_list str_match_clause_opt order_clause_opt skip_clause_opt limit_clause_opt
    | LBRACKET return_item_list str_match_clause_opt RBRACKET order_clause_opt skip_clause_opt limit_clause_opt
    ;

return_item_list:
    item typecast_opt { rtn_list->exp = $1->exp; rtn_list->idt = $1->idt; type_list->exp = $2; }
    | return_item_list COMMA item typecast_opt { list_append(&rtn_list, $3->exp, $3->idt); list_append(&type_list, $4, NULL); }
    ;

item_clause:
    item_list order_clause_opt skip_clause_opt limit_clause_opt
    | LPAREN item_list RPAREN order_clause_opt skip_clause_opt limit_clause_opt
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
    | math_expression is_expression_opt EQUALS math_expression is_expression_opt AS IDENTIFIER
      {
          $$ = (MapPair*) malloc(sizeof(MapPair));
          $$->exp = NULL;
          $$->idt = $7;
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

str_match_clause_opt:
    /* empty */
    | STARTS WITH expression
    | ENDS WITH expression
    | CONTAINS expression
    | EQUALSTILDE expression
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
    | UNIONALL
    ;

sql_statement:
    sql_query
    | sql_statement sql_query
    ;

sql_query:
    select_clause { sql_select = true; }
    | where_clause
    ;

select_clause:
    SELECT expression_list from_clause
    ;

from_clause:
    FROM LPAREN queries RPAREN as_clause
    ;

as_clause_opt:
    /* empty */
    | as_clause
    ;

as_clause:
    AS IDENTIFIER
    | AS UNDER LPAREN identifier_list RPAREN
    ;

identifier_list:
    IDENTIFIER
    | identifier_list COMMA IDENTIFIER
    ;
%%

bool yyerror(char const* s)
{
    if
    (
        match || optional || explain || create || create_graph || drop || alter ||
        load || set_path || merge || rtn || unwind || prepare || execute ||
        show || reindex || comment || sql_select
    )
        printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);

    reset_vals();
    
    return false;
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

char*
get_rtn_list(MapPair* list, MapPair* list2)
{
    struct MapPair* current = list;
    struct MapPair* current_type = list2;
    char* str = malloc(1000);
    char temp[1000] = "";
    char count_str[100] = "";
    int rtn_count = 1;
    strcpy(str, "");

    while (current != NULL)
    {
        sprintf(count_str, "rtn_%d", rtn_count++);
        
        sprintf(temp, "%s %s%s", 
            (current->idt != NULL) ? current->idt : count_str,
            (current_type->idt != NULL) ? current_type->idt : current_type->exp,
            (current->next != NULL) ? ", " : "");

        strcat(str, temp);

        current = current->next;
        current_type = current_type->next;
    }

    return str;
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

void init_list (MapPair* list)
{    
    list->exp = NULL;
    list->idt = NULL;
    list->next = NULL;
}

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
        match || optional || explain || create || create_graph || drop || alter ||
        load || set_path || merge || rtn || unwind || prepare || execute ||
        show || reindex || comment || sql_select
    )
        return true;
    
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
            if (strncmp(start_keywords[i], "FROM (", 6) == 0 || strncmp(start_keywords[i], "from (", 6) == 0)
                found = strstr(data, start_keywords[i]) + 6;

            else if (strncmp(start_keywords[i], "RETURN ", 7) == 0 || strcmp(start_keywords[i], "return ", 7) == 0)
                found = return_query ? strstr(data, start_keywords[i]) + 13 : strstr(data, start_keywords[i]);
                
            else
                found = strstr(data, start_keywords[i]);
            
            printf("%s\n", found ? found : "NULL");

            if (found)
            {
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

    if (create_graph)
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

    else if (create_elabel)
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
