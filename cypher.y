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

char* qry;
char* graph_name;
char* alter_graph_name;
char* label_name;
char* edge_name;
char* file_path;

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

%type <str_val> node_alias_opt node_labels_opt expression_list expression function rel_alias_opt
    rel_labels_opt compare logic typecast_opt str_val expression_opt
%type <int_val> upper_bound_opt sort_direction_opt
%type <bool_val> dot_opt
%type <pat> variable_length_edges_opt edge_length_opt
%type <pair> node_properties_opt map_literal nonempty_map_literal map_entry item_list item id_list

%token ASC DESC DASH LT GT LBRACKET RBRACKET LPAREN RPAREN COLON PIPE COMMA SEMICOLON LBRACE RBRACE
    ASTERISK DOT PLUS SLASH EQUALS DOLLAR OPTIONAL MATCH ONLY ON CREATE GRAPH VLABEL ELABEL INHERITS
    DROP IF CASCADE ALTER RENAME EXPLAIN MERGE LOAD IDS LABELS EDGES UNWIND WHERE EXISTS WITH ORDER
    BY SKIP LIMIT  DELETE DETACH SET REMOVE RETURN DISTINCT AS AND OR XOR TRUE FALSE UNION ALL IS
    NOT NUL SELECT FROM GRAPH_PATH
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
          if (!rtn)
          {
              list_append(&rtn_list, "v", NULL);
              list_append(&type_list, "agtype", NULL);
          }
          YYACCEPT;
      }
    ;

query:
    match_clause
    | on_clause
    | create_clause
    | drop_clause
    | alter_clause
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

on_clause_opt:
    /* empty */
    | on_clause
    ;

create_clause:
    CREATE pattern_list
    | CREATE GRAPH IDENTIFIER { graph_name = $3; }
    | CREATE GRAPH IF NOT EXISTS IDENTIFIER { graph_name = $6; }
    | CREATE VLABEL IDENTIFIER inherits_opt on_clause_opt { label_name = $3; }
    | CREATE ELABEL IDENTIFIER inherits_opt on_clause_opt { edge_name = $3; }
    ;

inherits_opt:
    /* empty */
    | INHERITS { inheritance = true; } expression
    ;

drop_clause:
    DROP GRAPH if_exists_opt IDENTIFIER cascade_opt { graph_name = $4; }
    ;

if_exists_opt:
    /* empty */
    | IF EXISTS
    ;

cascade_opt:
    /* empty */
    | CASCADE { cascade = true; }
    ;

alter_clause:
    ALTER GRAPH IDENTIFIER RENAME IDENTIFIER
    {
        graph_name = $3; alter_graph_name = $5;
    }
    ;

explain_clause:
    EXPLAIN LPAREN 'VERBOSE' COMMA 'COSTS OFF' RPAREN
    ;

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

expression_list:
    expression { $$ = $1; }
    | expression_list COMMA expression { $$ = $1; }
    ;

str_val:
    IDENTIFIER { $$ = $1; }
    | STRING { $$ = $1; }
    ;

expression:
    NUL { $$ = NULL; }
    | INTEGER { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%d", $1); $$ = temp; }
    | FLOAT { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%f", $1); $$ = temp; }
    | str_val array_opt dot_operator_opt { $$ = $1; }
    | LBRACKET list RBRACKET { $$ = "list"; }
    | LBRACE map_literal RBRACE { $$ = "property"; }
    | LPAREN sql_statement RPAREN { $$ = "sql"; }
    | function dot_operator_opt { $$ = $1; }
    | LPAREN function RPAREN array_opt dot_operator_opt { $$ = $2; }
    | LPAREN id_list RPAREN { $$ = $2->idt; }
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
    IDENTIFIER LPAREN expression_list RPAREN { $$ = $3; }
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
    | LOAD LABELS with_id_opt IDENTIFIER FROM STRING ON IDENTIFIER
      {
          label_name = $4; file_path = $6; graph_name = $8;
      }
    | LOAD EDGES IDENTIFIER FROM STRING ON IDENTIFIER
      {
          edge_name = $3; file_path = $5; graph_name = $7;
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
    SET { set = true; } assign_list
    | SET GRAPH_PATH EQUALS str_val { set = true; set_path = true; graph_name = $4; }
    | SET GRAPH_PATH EQUALS str_val { set = true; set_path = true; graph_name = $4; } assign_list
    | SET GRAPH EQUALS str_val { set = true; set_path = true; graph_name = $4; }
    | SET GRAPH EQUALS str_val { set = true; set_path = true; graph_name = $4; } assign_list
    ;

assign_list:
    math_expression
    | assign_list COMMA math_expression
    ;

remove_clause:
    REMOVE expression_list
    ;

return_clause:
    RETURN { rtn = true; } distinct_opt item_clause union_opt
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
    item typecast_opt { rtn_list->exp = $1->exp; rtn_list->idt = $1->idt; type_list->exp = $2; }
    | item_list COMMA item typecast_opt { list_append(&rtn_list, $3->exp, $3->idt); list_append(&type_list, $4, NULL); }
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

typecast_opt:
    /* empty */ { $$ = "agtype"; }
    | COLON COLON IDENTIFIER
      {
	  if (strcmp($3, "pg_bigint") == 0)
              $$ = "int";
          else if (strcmp($3, "pg_float8") == 0)
              $$ = "float";
          else
              $$ = $3;
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
    char temp[100] = "";

    while (current != NULL)
    {
        /* Check for any '.' and replace with '_' if no alias given */
        if (current->idt == NULL)
        {
	    int i = 0;

            while((current->exp)[i] != '\0')
            {
                if((current->exp)[i] == '.')
                    (current->exp)[i] = '_';
                i++;
            }
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
    rtn_list = (MapPair*) malloc(sizeof(MapPair));
    type_list = (MapPair*) malloc(sizeof(MapPair));
    id_val_list = (MapPair*) malloc(sizeof(MapPair));

    init_list(rtn_list);
    init_list(type_list);
    init_list(id_val_list);

    YY_BUFFER_STATE buf = yy_scan_string(data);
    yypush_buffer_state(buf);
    yyparse();

    return true;
}

char* convert_to_psql_command(char* data)
{
    char temp[1000] = "";
    char* qry = NULL;

    /* Remove semicolon from query */
    data[strlen(data) - 1] = '\0';

    if (pg_strncasecmp(data, "MATCH", 5) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM cypher('%s', $$ "
            "%s "
            "$$) AS (%s);",
            graph_name ? graph_name : pset.graph_name, data, get_list(rtn_list, type_list));
    }
    else if (pg_strncasecmp(data, "CREATE GRAPH", 12) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM create_graph('%s');",
            graph_name ? graph_name : pset.graph_name);
    }
    else if (pg_strncasecmp(data, "CREATE VLABEL", 13) == 0)
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
    else if (pg_strncasecmp(data, "CREATE ELABEL", 13) == 0)
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
    else if (pg_strncasecmp(data, "DROP GRAPH", 10) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM drop_graph('%s', %s);",
            graph_name ? graph_name : pset.graph_name, cascade ? "true" : "false");
    }
    else if (pg_strncasecmp(data, "ALTER GRAPH", 11) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM alter_graph('%s', 'RENAME', '%s');",
            graph_name ? graph_name : pset.graph_name, alter_graph_name);
    }
    else if (pg_strncasecmp(data, "LOAD LABELS", 11) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM load_labels_from_file('%s', '%s', '%s', %s);",
            graph_name ? graph_name : pset.graph_name,
            label_name, file_path, with_ids ? "true" : "false");
    }
    else if (pg_strncasecmp(data, "LOAD EDGES", 10) == 0)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM load_edges_from_file('%s', '%s', '%s');",
            graph_name ? graph_name : pset.graph_name, label_name, file_path);
    }
    else if (set)
    {
        /* Set graph name */
        if (set_path)
        {
            pset.graph_name = yylval.str_val;
            graph_name = yylval.str_val;
        }
    }

    qry = strdup(temp);

    /* Print debug information */
    printf("\nINFO: %s\n", qry);

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

    qry = NULL;
    graph_name = NULL;
    alter_graph_name = NULL;
    label_name = NULL;
    edge_name = NULL;
    file_path = NULL;
}
