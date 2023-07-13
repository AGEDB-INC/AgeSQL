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
static char* get_list(MapPair* list, MapPair* list2);
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
bool drop_label = false;
bool drop_graph = false;
bool alter_graph = false;
bool rename_graph = false;
bool load_labels = false;
bool load_edges = false;
bool reindex = false;
bool comment = false;

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

%token ASC DESC DASH LT GT LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE
    ASTERISK DOT PLUS SLASH EQUALS DOLLAR EXCLAMATION EQUALSTILDE OPTIONAL MATCH ONLY ON CREATE GRAPH VLABEL
    ELABEL CONSTRAINT ASSERT UNIQUE INHERITS TABLESPACE DROP IF CASCADE ALTER STORAGE RENAME OWNER CLUSTER
    UNLOGGED LOGGED INHERIT NOINHERIT REINDEX INDEX DISABLE EXPLAIN VERBOSE COSTSOFF MERGE LOAD IDS LABELS
    EDGES UNWIND WHERE EXISTS WITH WITHOUT ORDER BY SKIP LIMIT DELETE DETACH SET REMOVE RETURN
    DISTINCT STARTS ENDS CONTAINS AS AND OR XOR TRUE FALSE UNION UNIONALL IS IN NOT NUL SELECT FROM
    GRAPH_PATH PREPARE EXECUTE COMMENT TO
%token <int_val> INTEGER
%token <float_val> FLOAT
%token <str_val> IDENTIFIER STRING
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
    | on_clause
    | create_clause { create = true; }
    | drop_clause { drop = true; }
    | alter_clause { alter = true; }
    | explain_clause { explain = true; }
    | merge_clause { merge = true; }
    | load_clause { load = true; }
    | unwind_clause { unwind = true; }
    | where_clause
    | exists_clause
    | with_clause
    | delete_clause
    | remove_clause
    | return_clause
    | prepare_clause { prepare = true; }
    | execute_clause { execute = true; }
    | set_graph_clause
    | reindex_clause
    | comment_clause
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

on_clause:
    ON CREATE
    | ON MATCH
    | ON IDENTIFIER { graph_name = $2; }
    ;

on_clause_opt:
    /* empty */
    | on_clause
    ;

create_clause:
    CREATE { create = true; }
    | CREATE { create = true; } pattern_list set_clause_opt
    | CREATE logged_opt GRAPH if_exists_opt IDENTIFIER tablespace_opt disable_index_opt { graph_name = $5; create_graph = true; }
    | CREATE logged_opt VLABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt tablespace_opt disable_index_opt { label_name = $5; create_vlabel = true; }
    | CREATE logged_opt ELABEL if_exists_opt IDENTIFIER inherits_opt on_clause_opt tablespace_opt disable_index_opt { edge_name = $5; create_elabel = true; }
    | CREATE CONSTRAINT constraint_patt
    ;

logged_opt:
    /* empty */
    | LOGGED
    | UNLOGGED
    ;

tablespace_opt:
    /* empty */
    | TABLESPACE IDENTIFIER
    ;

disable_index_opt:
    /* empty */
    | DISABLE INDEX
    ;

constraint_patt:
    identifier_opt ON IDENTIFIER assert_patt_opt
    ;

reindex_clause:
    REINDEX { reindex = true; } VLABEL IDENTIFIER
    ;

comment_clause:
    COMMENT ON { comment = true; } GRAPH IDENTIFIER IS STRING
    | COMMENT VLABEL IDENTIFIER IS STRING
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
    ALTER GRAPH IDENTIFIER alter_graph_options
    {
        graph_name = $3;
    }
    | ALTER VLABEL if_exists_opt IDENTIFIER alter_vlabel_options 
    ;

alter_graph_options:
    OWNER TO IDENTIFIER { alter_graph = true; }
    | RENAME TO IDENTIFIER { alter_graph_name = $3; rename_graph = true; }
    ;

alter_vlabel_options:
    SET STORAGE IDENTIFIER
    | RENAME TO IDENTIFIER
    | OWNER TO IDENTIFIER
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

set_clause:
    SET { set = true; } assign_list set_clause_opt
    ;

set_clause_opt:
    /* empty */
    | set_clause
    ;

match_clause:
    optional_opt MATCH { match = true; } pattern_list set_clause_opt
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
    | INTEGER dot_opt upper_bound_opt { $$->lower = $1; $$->dot = $2; $$->upper = $3; }
    | DOT DOT INTEGER { $$->upper = $3; }
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
    IDENTIFIER COLON math_expression { $$->idt = $1; $$->exp = $3; }
    ;

expression_list:
    expression expression_ext_opt { $$ = $1; }
    | expression_list COMMA expression expression_ext_opt { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s_%s", $1, $3); $$ = temp; }
    ;

expression:
    NUL { $$ = NULL; }
    | negative_opt INTEGER typecast_opt { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%d", $2); $$ = temp; }
    | FLOAT typecast_opt { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%f", $1); $$ = temp; }
    | str_val array_opt dot_operator_opt typecast_opt { $$ = $1; }
    | boolean { $$ = "bool"; }
    | LBRACKET list RBRACKET { $$ = "list"; }
    | LBRACE map_literal RBRACE { $$ = "property"; }
    | LPAREN sql_statement RPAREN { $$ = "sql"; }
    | function array_opt dot_operator_opt typecast_opt { $$ = $1; }
    | LPAREN function RPAREN array_opt dot_operator_opt { $$ = $2; }
    | LPAREN id_list RPAREN { $$ = $2->idt; }
    | DOLLAR INTEGER { $$ = NULL; }
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
    IDENTIFIER LPAREN expression_list RPAREN { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s_%s", $1, $3); $$ = temp; }
    | IDENTIFIER LPAREN path_pattern RPAREN { $$ = $1; }
    | IDENTIFIER LPAREN ASTERISK RPAREN { $$ = $1; }
    ;

math_expression:
    expression { $$ = $1; }
    | math_expression EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s = %s", $1, $3); $$ = temp; }
    | math_expression PLUS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s + %s", $1, $3); $$ = temp; }
    | math_expression PLUS EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s += %s", $1, $4); $$ = temp; }
    | math_expression DASH expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s - %s", $1, $3); $$ = temp; }
    | math_expression DASH EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s -= %s", $1, $4); $$ = temp; }
    | math_expression ASTERISK expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s * %s", $1, $3); $$ = temp; }
    | math_expression ASTERISK EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s *= %s", $1, $4); $$ = temp; }
    | math_expression SLASH expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s / %s", $1, $3); $$ = temp; }
    | math_expression SLASH EQUALS expression { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s /= %s", $1, $4); $$ = temp; }
    ;

merge_clause:
    MERGE path_pattern
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
    WHERE { where = true; } not_opt where_expression
    ;

where_expression:
    expression compare expression
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
    TRUE
    | FALSE
    ;

with_clause:
    WITH { with = true; } distinct_opt item_clause
    | WITH { with = true; } ASTERISK
    ;

delete_clause:
    detach_opt DELETE expression_list
    ;

detach_opt:
    /* empty */
    | DETACH
    ;

set_graph_clause:
    SET GRAPH_PATH EQUALS graph_path_list { set = true; set_path = true; graph_name = $4; }
    | SET GRAPH EQUALS graph_path_list { set = true; set_path = true; graph_name = $4; }
    ;

assign_list:
    math_expression
    | assign_list COMMA math_expression
    ;

graph_path_list:
    IDENTIFIER { $$ = $1; }
    | graph_path_list COMMA IDENTIFIER { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%s, %s", $1, $3); $$ = temp; }
    ;

remove_clause:
    REMOVE expression_list
    ;

return_clause:
    RETURN { rtn = true; } distinct_opt return_item_clause union_opt
    | RETURN { rtn = true; } ASTERISK union_opt
    | RETURN { rtn = true; } not_opt exists_clause union_opt
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
          $$->exp = $1;
          $$->idt = $4;
      }
    | math_expression is_expression_opt EQUALS math_expression is_expression_opt AS IDENTIFIER
      {
          $$ = (MapPair*) malloc(sizeof(MapPair));
          $$->exp = NULL;
          $$->idt = $7;
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
          $$->exp = NULL;
          $$->idt = "exists";
      }
    | exists_clause AS IDENTIFIER
      {
          $$ = (MapPair*) malloc(sizeof(MapPair));
          $$->exp = NULL;
          $$->idt = $3;
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
    if (match || optional || explain || create || drop || alter || load ||
        set || set_path || merge || rtn || unwind || prepare || execute)
        printf("ERROR:\t%s at or near \"%s\"\n", s, yylval.str_val);
    
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
get_list(MapPair* list, MapPair* list2)
{
    struct MapPair* current = list;
    struct MapPair* current_type = list2;
    char* str = malloc(100);
    char *temp = malloc(100);
    int counter = 1;
    int i = 0;
    
    strcpy(str, "");
    strcpy(temp, "");

    while (current != NULL)
    {
	if (current->idt == NULL)
        {
            /* Check if begins with number */
            if ((current->exp)[0] == '1' ||
                (current->exp)[0] == '2' ||
                (current->exp)[0] == '3' ||
                (current->exp)[0] == '4' ||
                (current->exp)[0] == '5' ||
                (current->exp)[0] == '6' ||
                (current->exp)[0] == '7' ||
                (current->exp)[0] == '8' ||
                (current->exp)[0] == '9' ||
                (current->exp)[0] == '0')
                sprintf((current->exp), "number_%d", counter);

            /* Check if is string */
            if ((current->exp)[0] == '\'' ||
                (current->exp)[0] == '\"')
		sprintf((current->exp), "string_%d", counter);

	    i = 0;

            while ((current->exp)[i] != '\0')
            {
                /* Check for any symbols and spaces and replace with "_" */
                if ((current->exp)[i] == '.' ||
                    (current->exp)[i] == '=' ||
                    (current->exp)[i] == ' ')
                    (current->exp)[i] = '_';

                i++;
            }

            counter++;
        }
        
        sprintf(temp, "%s %s%s", 
            (current->idt != NULL) ? current->idt : current->exp,
            (current_type->idt != NULL) ? current_type->idt : current_type->exp,
            (current->next != NULL) ? ", " : "");

        strcat(str, temp);

        current = current->next;
        current_type = current_type->next;
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
    id_val_list = (MapPair*) malloc(sizeof(MapPair));

    init_list(rtn_list);
    init_list(type_list);
    init_list(id_val_list);

    buf = yy_scan_string(data);
    yypush_buffer_state(buf);
    yyparse();

    if (match || optional || explain || create || drop || alter || load ||
        set || set_path || merge || rtn || unwind || prepare || execute)
        return true;
    
    return false;
}

char* convert_to_psql_command(char* data)
{
    char temp[1000] = "";
    qry = NULL;

    /* Remove semicolon from query */
    data[strlen(data) - 1] = '\0';

    if (create_graph)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM create_graph('%s');",
            graph_name ? graph_name : pset.graph_name);
    }

    else if (create_vlabel)
    {
        if (inheritance)
        {
            snprintf(temp, sizeof(temp),
                "SELECT * "
                "FROM create_vlabel('%s', '%s', ARRAY[%s]);",
                graph_name ? graph_name : pset.graph_name, label_name, get_id_list(id_val_list));
        }

        else
        {
            snprintf(temp, sizeof(temp),
                "SELECT * "
                "FROM create_vlabel('%s', '%s');",
                graph_name ? graph_name : pset.graph_name, label_name);
        }
    }

    else if (create_elabel)
    {
        if (inheritance)
        {
            snprintf(temp, sizeof(temp),
                "SELECT * "
                "FROM create_elabel('%s', '%s', ARRAY[%s]);",
                graph_name ? graph_name : pset.graph_name, label_name, get_id_list(id_val_list));
        }

        else
        {
            snprintf(temp, sizeof(temp),
                "SELECT * "
                "FROM create_elabel('%s', '%s');",
                graph_name ? graph_name : pset.graph_name, edge_name);
        }
    }

    else if (drop_label)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM drop_label('%s', '%s');",
            graph_name ? graph_name : pset.graph_name, label_name);
    }

    else if (drop_graph)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM drop_graph('%s', %s);",
            graph_name ? graph_name : pset.graph_name, cascade ? "true" : "false");
    }

    else if (rename_graph)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM alter_graph('%s', 'RENAME', '%s');",
            graph_name ? graph_name : pset.graph_name, alter_graph_name);
    }

    else if (load_labels)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM load_labels_from_file('%s', '%s', '%s', %s);",
            graph_name ? graph_name : pset.graph_name,
            label_name, file_path, with_ids ? "true" : "false");
    }

    else if (load_edges)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM load_edges_from_file('%s', '%s', '%s');",
            graph_name ? graph_name : pset.graph_name, label_name, file_path);
    }

    else if (set_path)
    {
        /* Set graph name */
        if (set_path)
        {
            pset.graph_name = yylval.str_val;
            graph_name = yylval.str_val;
        }
    }

    else if (pg_strncasecmp(data, "PREPARE", 7) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM age_prepare_cypher('%s', '%s');",
            graph_name ? graph_name : pset.graph_name, "Not supported");
    }

    else
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM cypher('%s', $$ "
            "%s "
            "$$) AS (%s);",
            graph_name ? graph_name : pset.graph_name,
            data, 
            rtn_list->idt || rtn_list->exp ? get_list(rtn_list, type_list) : "v agtype");
    }

    qry = strdup(temp);

    if (strcmp(qry, "") == 0)
    {
        reset_vals();
        
        return NULL;
    }

    /* Uncomment for debug information
    printf("\nINFO: %s\n", qry);
    */

    reset_vals();
    return qry;
}

void reset_vals(void)
{
    free_memory(rtn_list);
    free_memory(type_list);
    free_memory(id_val_list);

    match = false;
    where = false;
    with = false;
    rtn = false;
    cascade = false;
    with_ids = false;
    set = false;
    set_path = false;
    inheritance = false;
    create_graph = false;
    create_vlabel = false;
    create_elabel = false;
    drop_label = false;
    drop_graph = false;
    alter_graph = false;
    rename_graph = false;
    load_labels = false;
    load_edges = false;
    create = false;
    reindex = false;
    comment = false;
    drop = false;
    
    alter_graph_name = NULL;
    label_name = NULL;
    edge_name = NULL;
    file_path = NULL;
}
