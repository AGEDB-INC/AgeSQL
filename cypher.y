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

char* qry;
char* graph_name;

static struct MapPair* rtn_list = NULL;
%}

%union {
    char* str_val;
    int int_val;
    bool bool_val;
    struct EdgePattern* pat;
    struct MapPair* pair;
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
    | statement SEMICOLON
      {      
          if (rtn == false)
              list_append(rtn_list, 'v', NULL);
          
          YYACCEPT;
      }
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
    INTEGER { char* temp = (char*) malloc(sizeof(char)); sprintf(temp, "%d", $1); $$ = temp; }
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
        list_append(rtn_list, $1, $3);
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
    yyparse();

    return true;
}

char* convert_to_psql_command(char* data, bool is_command)
{
    char temp[1000] = "";
    char* qry = NULL;

    /* Remove semicolon from query */
    data[strlen(data) - 1] = '\0';

    if (is_command)
    {
        snprintf(temp, sizeof(temp),
            "SELECT * "
            "FROM cypher('%s', $$ "
            "%s "
            "$$) AS (%s);",
            graph_name ? graph_name : pset.graph_name, data, get_list(rtn_list));
    }
    else if (pg_strncasecmp(data, "CREATE GRAPH", 12) == 0)
    {
        sscanf(data, "CREATE GRAPH %ms;", &graph_name);

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
}
