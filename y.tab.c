/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ALTER = 258,
     AND = 259,
     AS = 260,
     ASC = 261,
     ASSERT = 262,
     ASTERISK = 263,
     BGN = 264,
     BY = 265,
     CALLED = 266,
     CARET = 267,
     CASCADE = 268,
     CASE = 269,
     CLUSTER = 270,
     COLON = 271,
     COMMA = 272,
     COMMENT = 273,
     CONSTRAINT = 274,
     CONTAINS = 275,
     COSTSOFF = 276,
     CREATE = 277,
     DASH = 278,
     DELETE = 279,
     DECLARE = 280,
     DESC = 281,
     DETACH = 282,
     DISABLE = 283,
     DISTINCT = 284,
     DOLLAR = 285,
     DOT = 286,
     DROP = 287,
     EDGES = 288,
     ELABEL = 289,
     ELSE = 290,
     END = 291,
     ENDS = 292,
     EQUALS = 293,
     EQUALSTILDE = 294,
     EXCLAMATION = 295,
     EXECUTE = 296,
     EXISTS = 297,
     EXPLAIN = 298,
     FAL = 299,
     FROM = 300,
     FUNCTION = 301,
     GRAPH = 302,
     GRAPH_PATH = 303,
     GT = 304,
     IDS = 305,
     IF = 306,
     IMMUTABLE = 307,
     IN = 308,
     INDEX = 309,
     INHERIT = 310,
     INHERITS = 311,
     INPUT = 312,
     INTO = 313,
     IS = 314,
     LABELS = 315,
     LANGUAGE = 316,
     LBRACE = 317,
     LBRACKET = 318,
     LIMIT = 319,
     LOAD = 320,
     LOGGED = 321,
     LPAREN = 322,
     LT = 323,
     MATCH = 324,
     MERGE = 325,
     NOINHERIT = 326,
     NOT = 327,
     NUL = 328,
     OPTIONAL = 329,
     ON = 330,
     ONLY = 331,
     OR = 332,
     ORDER = 333,
     OWNER = 334,
     PARALLEL = 335,
     PERCENT = 336,
     PERFORM = 337,
     PIPE = 338,
     PLUS = 339,
     PREPARE = 340,
     QUERY = 341,
     RBRACE = 342,
     RBRACKET = 343,
     REINDEX = 344,
     REMOVE = 345,
     RENAME = 346,
     REPLACE = 347,
     RETURN = 348,
     RETURNS = 349,
     RPAREN = 350,
     SAFE = 351,
     SELECT = 352,
     SEMICOLON = 353,
     SET = 354,
     SETOF = 355,
     SHOW = 356,
     SKIP = 357,
     SLASH = 358,
     STABLE = 359,
     STARTS = 360,
     STORAGE = 361,
     STRICT = 362,
     TABLESPACE = 363,
     THEN = 364,
     TRU = 365,
     UNDER = 366,
     UNION = 367,
     UNIONALL = 368,
     UNIQUE = 369,
     UNLOGGED = 370,
     UNWIND = 371,
     VERBOSE = 372,
     VLABEL = 373,
     VOLATILE = 374,
     WHEN = 375,
     WHERE = 376,
     WITH = 377,
     WITHOUT = 378,
     XOR = 379,
     INTEGER = 380,
     FLOAT = 381,
     IDENTIFIER = 382,
     STRING = 383,
     UNKNOWN = 384,
     ARROW = 385
   };
#endif
/* Tokens.  */
#define ALTER 258
#define AND 259
#define AS 260
#define ASC 261
#define ASSERT 262
#define ASTERISK 263
#define BGN 264
#define BY 265
#define CALLED 266
#define CARET 267
#define CASCADE 268
#define CASE 269
#define CLUSTER 270
#define COLON 271
#define COMMA 272
#define COMMENT 273
#define CONSTRAINT 274
#define CONTAINS 275
#define COSTSOFF 276
#define CREATE 277
#define DASH 278
#define DELETE 279
#define DECLARE 280
#define DESC 281
#define DETACH 282
#define DISABLE 283
#define DISTINCT 284
#define DOLLAR 285
#define DOT 286
#define DROP 287
#define EDGES 288
#define ELABEL 289
#define ELSE 290
#define END 291
#define ENDS 292
#define EQUALS 293
#define EQUALSTILDE 294
#define EXCLAMATION 295
#define EXECUTE 296
#define EXISTS 297
#define EXPLAIN 298
#define FAL 299
#define FROM 300
#define FUNCTION 301
#define GRAPH 302
#define GRAPH_PATH 303
#define GT 304
#define IDS 305
#define IF 306
#define IMMUTABLE 307
#define IN 308
#define INDEX 309
#define INHERIT 310
#define INHERITS 311
#define INPUT 312
#define INTO 313
#define IS 314
#define LABELS 315
#define LANGUAGE 316
#define LBRACE 317
#define LBRACKET 318
#define LIMIT 319
#define LOAD 320
#define LOGGED 321
#define LPAREN 322
#define LT 323
#define MATCH 324
#define MERGE 325
#define NOINHERIT 326
#define NOT 327
#define NUL 328
#define OPTIONAL 329
#define ON 330
#define ONLY 331
#define OR 332
#define ORDER 333
#define OWNER 334
#define PARALLEL 335
#define PERCENT 336
#define PERFORM 337
#define PIPE 338
#define PLUS 339
#define PREPARE 340
#define QUERY 341
#define RBRACE 342
#define RBRACKET 343
#define REINDEX 344
#define REMOVE 345
#define RENAME 346
#define REPLACE 347
#define RETURN 348
#define RETURNS 349
#define RPAREN 350
#define SAFE 351
#define SELECT 352
#define SEMICOLON 353
#define SET 354
#define SETOF 355
#define SHOW 356
#define SKIP 357
#define SLASH 358
#define STABLE 359
#define STARTS 360
#define STORAGE 361
#define STRICT 362
#define TABLESPACE 363
#define THEN 364
#define TRU 365
#define UNDER 366
#define UNION 367
#define UNIONALL 368
#define UNIQUE 369
#define UNLOGGED 370
#define UNWIND 371
#define VERBOSE 372
#define VLABEL 373
#define VOLATILE 374
#define WHEN 375
#define WHERE 376
#define WITH 377
#define WITHOUT 378
#define XOR 379
#define INTEGER 380
#define FLOAT 381
#define IDENTIFIER 382
#define STRING 383
#define UNKNOWN 384
#define ARROW 385




/* Copy the first part of user declarations.  */
#line 1 "cypher.y"

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


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 107 "cypher.y"
{
    char* str_val;
    int int_val;
    float float_val;

    bool bool_val;
    struct EdgePattern* pat;
    struct MapPair* pair;
}
/* Line 193 of yacc.c.  */
#line 471 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 484 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  117
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1317

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  131
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  137
/* YYNRULES -- Number of rules.  */
#define YYNRULES  343
/* YYNRULES -- Number of states.  */
#define YYNSTATES  654

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   385

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,   119,   120,   121,   122,   123,   124,
     125,   126,   127,   128,   129,   130
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     6,     8,    11,    13,    15,    17,    19,
      21,    23,    25,    27,    29,    31,    33,    35,    37,    39,
      41,    43,    45,    47,    49,    51,    53,    58,    64,    67,
      70,    74,    77,    80,    83,    86,    89,    92,    96,    99,
     103,   113,   120,   122,   124,   127,   130,   139,   146,   155,
     163,   166,   167,   169,   171,   172,   175,   176,   178,   179,
     182,   183,   186,   191,   192,   195,   200,   203,   208,   209,
     214,   219,   224,   225,   228,   229,   231,   232,   234,   236,
     239,   242,   244,   246,   248,   251,   253,   258,   264,   267,
     279,   280,   283,   287,   292,   294,   297,   300,   304,   310,
     311,   314,   319,   320,   322,   325,   331,   335,   340,   344,
     345,   347,   351,   352,   356,   361,   365,   367,   369,   372,
     377,   379,   383,   386,   389,   392,   395,   399,   407,   414,
     415,   418,   423,   424,   426,   429,   434,   435,   438,   440,
     445,   447,   451,   459,   466,   471,   472,   474,   475,   478,
     479,   483,   484,   486,   488,   492,   496,   497,   499,   500,
     503,   507,   512,   517,   525,   532,   533,   535,   536,   541,
     542,   545,   546,   549,   550,   554,   558,   559,   562,   563,
     565,   569,   572,   574,   576,   580,   582,   586,   589,   590,
     592,   594,   599,   603,   606,   611,   612,   614,   616,   622,
     630,   633,   638,   639,   643,   647,   650,   653,   654,   656,
     658,   661,   665,   667,   671,   676,   678,   680,   682,   686,
     689,   691,   693,   697,   703,   706,   712,   717,   720,   722,
     726,   730,   731,   735,   739,   744,   748,   753,   760,   762,
     764,   766,   769,   772,   774,   776,   779,   782,   785,   788,
     793,   795,   799,   803,   808,   810,   814,   818,   822,   827,
     833,   837,   840,   843,   845,   846,   848,   849,   853,   854,
     857,   858,   860,   862,   866,   867,   871,   872,   874,   879,
     884,   889,   894,   895,   897,   900,   905,   907,   911,   915,
     917,   921,   923,   927,   930,   935,   943,   947,   953,   955,
     959,   961,   962,   966,   968,   970,   972,   974,   978,   982,
     987,   991,   996,  1000,  1005,  1009,  1014,  1018,  1022,  1024,
    1026,  1027,  1030,  1031,  1033,  1034,  1036,  1037,  1040,  1041,
    1043,  1044,  1048,  1049,  1052,  1053,  1055,  1056,  1058,  1059,
    1061,  1062,  1065,  1066
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int16 yyrhs[] =
{
     132,     0,    -1,   133,    98,    -1,   134,    -1,   133,   134,
      -1,   135,    -1,   139,    -1,   141,    -1,   162,    -1,   164,
      -1,   167,    -1,   169,    -1,   171,    -1,   174,    -1,   177,
      -1,   201,    -1,   208,    -1,   209,    -1,   210,    -1,   211,
      -1,   219,    -1,   222,    -1,   223,    -1,   228,    -1,   229,
      -1,   232,    -1,     3,    47,   127,   136,    -1,     3,   118,
     261,   127,   137,    -1,    79,   127,    -1,    91,   127,    -1,
      15,    75,   127,    -1,    28,    54,    -1,    55,   127,    -1,
      71,   127,    -1,    79,   127,    -1,    91,   127,    -1,    99,
      66,    -1,    99,   106,   127,    -1,    99,   115,    -1,    99,
     123,    15,    -1,    14,   260,   120,   254,   109,   254,    35,
     254,    36,    -1,    18,    75,   140,   127,    59,   128,    -1,
      47,    -1,   118,    -1,    22,   142,    -1,    19,   148,    -1,
     143,    34,   261,   127,   144,   145,   146,   147,    -1,   143,
      47,   261,   127,   146,   147,    -1,   143,   118,   261,   127,
     144,   145,   146,   147,    -1,   152,    46,   245,    94,   153,
     237,   154,    -1,   179,   265,    -1,    -1,    66,    -1,   115,
      -1,    -1,    56,   237,    -1,    -1,   202,    -1,    -1,   108,
     127,    -1,    -1,    28,    54,    -1,   260,    75,   127,   149,
      -1,    -1,     7,   150,    -1,     7,    67,   150,    95,    -1,
     254,   151,    -1,   254,   151,   253,   150,    -1,    -1,    59,
     263,   114,   151,    -1,    59,   263,    73,   151,    -1,   263,
      53,   237,   151,    -1,    -1,    77,    92,    -1,    -1,   100,
      -1,    -1,   155,    -1,   156,    -1,   155,   156,    -1,    61,
     255,    -1,   119,    -1,    52,    -1,   104,    -1,    80,    96,
      -1,   107,    -1,    11,    75,    73,    57,    -1,    94,    73,
      75,    73,    57,    -1,     5,   255,    -1,     5,    30,   260,
      30,   157,     9,   159,    36,    30,   260,    30,    -1,    -1,
      25,   158,    -1,   127,   127,    98,    -1,   158,   127,   127,
      98,    -1,   160,    -1,   159,   160,    -1,   254,    98,    -1,
     133,   161,    98,    -1,    93,    86,   133,   161,    98,    -1,
      -1,    58,   249,    -1,   163,    24,   236,   265,    -1,    -1,
      27,    -1,    32,   165,    -1,    19,   260,    75,   127,   149,
      -1,    34,   127,   166,    -1,    47,   261,   127,   166,    -1,
     118,   127,   166,    -1,    -1,    13,    -1,    41,   127,   168,
      -1,    -1,    67,   250,    95,    -1,    42,    67,   170,    95,
      -1,   169,    17,   170,    -1,   237,    -1,   182,    -1,    43,
     172,    -1,    43,    67,   172,    95,    -1,   173,    -1,   172,
      17,   173,    -1,   117,   257,    -1,    21,   257,    -1,   127,
     257,    -1,    65,   175,    -1,    45,   127,   256,    -1,    60,
     176,   127,    45,   128,    75,   127,    -1,    33,   127,    45,
     128,    75,   127,    -1,    -1,   122,    50,    -1,   178,    69,
     179,   265,    -1,    -1,    74,    -1,   180,   181,    -1,   180,
      67,   181,    95,    -1,    -1,   127,    38,    -1,   182,    -1,
     181,    17,   180,   182,    -1,   183,    -1,   182,   192,   183,
      -1,    67,   184,   185,   186,   190,   191,    95,    -1,    67,
     127,   235,   237,   190,    95,    -1,    67,    38,   237,    95,
      -1,    -1,   127,    -1,    -1,    16,   127,    -1,    -1,    62,
     187,    87,    -1,    -1,   188,    -1,   189,    -1,   188,    17,
     189,    -1,   127,    16,   254,    -1,    -1,    76,    -1,    -1,
      30,   127,    -1,    23,   193,    23,    -1,    68,    23,   193,
      23,    -1,    23,   193,    23,    49,    -1,    63,   194,   195,
     190,   197,   186,    88,    -1,    63,   127,   235,   237,   190,
      88,    -1,    -1,   127,    -1,    -1,    16,   127,   196,   259,
      -1,    -1,    83,   127,    -1,    -1,     8,   198,    -1,    -1,
     125,   199,   200,    -1,    31,    31,   125,    -1,    -1,    31,
      31,    -1,    -1,   125,    -1,    70,   182,   265,    -1,    75,
     203,    -1,    22,    -1,    69,    -1,    78,    10,   205,    -1,
     206,    -1,   205,    17,   206,    -1,   237,   207,    -1,    -1,
       6,    -1,    26,    -1,    85,   127,   168,     5,    -1,    89,
     118,   127,    -1,    90,   236,    -1,    93,   212,   213,   216,
      -1,    -1,    29,    -1,    72,    -1,   214,   215,   264,   266,
     262,    -1,    63,   214,   215,    88,   264,   266,   262,    -1,
     251,   267,    -1,   214,    17,   251,   267,    -1,    -1,   105,
     122,   237,    -1,    37,   122,   237,    -1,    20,   237,    -1,
      39,   237,    -1,    -1,   112,    -1,   113,    -1,    99,   218,
      -1,   217,    99,   218,    -1,   254,    -1,   218,    17,   254,
      -1,    99,   220,    38,   221,    -1,    47,    -1,    48,    -1,
     127,    -1,   221,    17,   127,    -1,   101,   220,    -1,   224,
      -1,   225,    -1,    97,   236,   226,    -1,    45,    67,   133,
      95,   227,    -1,     5,   127,    -1,     5,   111,    67,   249,
      95,    -1,   116,   237,     5,   127,    -1,   121,   230,    -1,
     169,    -1,   263,   237,   231,    -1,   230,   253,   230,    -1,
      -1,   235,   263,   237,    -1,    59,   263,   237,    -1,   263,
      53,   263,   237,    -1,   122,   258,   233,    -1,   250,   264,
     266,   262,    -1,    67,   250,    95,   264,   266,   262,    -1,
     110,    -1,    44,    -1,    38,    -1,    38,    38,    -1,    40,
      38,    -1,    68,    -1,    49,    -1,    68,    38,    -1,    49,
      38,    -1,    68,    49,    -1,   237,   243,    -1,   236,    17,
     237,   243,    -1,    73,    -1,   238,   125,   267,    -1,   238,
     126,   267,    -1,   255,   239,   240,   267,    -1,   234,    -1,
      63,   241,    88,    -1,    62,   187,    87,    -1,    67,   223,
      95,    -1,   245,   239,   240,   267,    -1,    67,   245,    95,
     239,   240,    -1,    67,   248,    95,    -1,    30,   125,    -1,
      30,   127,    -1,     8,    -1,    -1,    23,    -1,    -1,    63,
     237,    88,    -1,    -1,    31,   127,    -1,    -1,   242,    -1,
     237,    -1,   242,    17,   237,    -1,    -1,    53,   237,   244,
      -1,    -1,   229,    -1,   127,    67,   246,    95,    -1,   127,
      67,   236,    95,    -1,   127,    67,   182,    95,    -1,   127,
      67,     8,    95,    -1,    -1,   247,    -1,   127,   254,    -1,
     247,    17,   127,   254,    -1,   127,    -1,   127,    17,   248,
      -1,   127,    53,   237,    -1,   127,    -1,   249,    17,   127,
      -1,   251,    -1,   250,    17,   251,    -1,   254,   252,    -1,
     254,   252,     5,   127,    -1,   254,   252,    38,   254,   252,
       5,   127,    -1,   254,    53,   254,    -1,   254,    53,   254,
      83,   237,    -1,   169,    -1,   169,     5,   127,    -1,   138,
      -1,    -1,    59,   263,   237,    -1,     4,    -1,    77,    -1,
     124,    -1,   237,    -1,   254,   235,   237,    -1,   254,    84,
     237,    -1,   254,    84,    38,   237,    -1,   254,    23,   237,
      -1,   254,    23,    38,   237,    -1,   254,     8,   237,    -1,
     254,     8,    38,   237,    -1,   254,   103,   237,    -1,   254,
     103,    38,   237,    -1,   254,    81,   237,    -1,   254,    12,
     237,    -1,   127,    -1,   128,    -1,    -1,     5,   127,    -1,
      -1,   234,    -1,    -1,    29,    -1,    -1,    38,   237,    -1,
      -1,   127,    -1,    -1,    51,   263,    42,    -1,    -1,    64,
     125,    -1,    -1,    72,    -1,    -1,   204,    -1,    -1,   217,
      -1,    -1,   102,   125,    -1,    -1,    16,    16,   255,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   191,   191,   195,   196,   200,   201,   202,   203,   204,
     205,   206,   207,   208,   209,   210,   211,   212,   213,   214,
     215,   216,   217,   218,   219,   220,   230,   231,   235,   236,
     240,   241,   242,   243,   244,   245,   246,   247,   248,   249,
     259,   270,   274,   275,   285,   289,   290,   292,   294,   296,
     298,   301,   303,   304,   307,   309,   312,   314,   317,   319,
     322,   324,   328,   331,   333,   334,   338,   339,   342,   344,
     345,   346,   349,   351,   354,   356,   359,   361,   365,   366,
     370,   371,   372,   373,   374,   375,   376,   377,   378,   379,
     387,   389,   393,   394,   399,   400,   404,   405,   406,   409,
     411,   421,   424,   426,   436,   440,   441,   442,   444,   447,
     449,   459,   462,   464,   474,   475,   479,   480,   490,   491,
     495,   496,   500,   501,   502,   512,   516,   517,   521,   527,
     529,   539,   542,   544,   548,   549,   552,   554,   558,   559,
     563,   564,   568,   570,   571,   575,   576,   580,   581,   585,
     586,   590,   591,   595,   596,   600,   608,   610,   613,   615,
     619,   620,   621,   625,   627,   631,   632,   636,   637,   640,
     642,   646,   647,   651,   652,   659,   667,   668,   672,   673,
     683,   693,   697,   698,   708,   712,   713,   717,   721,   722,
     723,   733,   743,   753,   763,   766,   768,   769,   773,   775,
     780,   782,   789,   791,   792,   793,   794,   797,   799,   800,
     810,   811,   815,   816,   826,   830,   831,   835,   836,   851,
     861,   865,   875,   879,   883,   884,   894,   904,   908,   909,
     910,   913,   915,   916,   917,   927,   931,   932,   942,   943,
     947,   948,   949,   950,   951,   952,   953,   954,   958,   959,
     963,   970,   977,   984,   986,   993,  1000,  1007,  1014,  1015,
    1016,  1017,  1018,  1019,  1022,  1024,  1027,  1029,  1032,  1034,
    1037,  1039,  1043,  1044,  1047,  1049,  1052,  1054,  1058,  1059,
    1060,  1061,  1064,  1066,  1070,  1071,  1075,  1082,  1089,  1098,
    1099,  1103,  1104,  1108,  1114,  1120,  1127,  1133,  1139,  1145,
    1151,  1159,  1161,  1165,  1166,  1167,  1171,  1172,  1179,  1186,
    1193,  1200,  1207,  1214,  1221,  1228,  1235,  1242,  1252,  1253,
    1262,  1264,  1267,  1269,  1272,  1274,  1278,  1279,  1282,  1284,
    1287,  1289,  1292,  1294,  1297,  1299,  1302,  1304,  1307,  1309,
    1312,  1314,  1318,  1319
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ALTER", "AND", "AS", "ASC", "ASSERT",
  "ASTERISK", "BGN", "BY", "CALLED", "CARET", "CASCADE", "CASE", "CLUSTER",
  "COLON", "COMMA", "COMMENT", "CONSTRAINT", "CONTAINS", "COSTSOFF",
  "CREATE", "DASH", "DELETE", "DECLARE", "DESC", "DETACH", "DISABLE",
  "DISTINCT", "DOLLAR", "DOT", "DROP", "EDGES", "ELABEL", "ELSE", "END",
  "ENDS", "EQUALS", "EQUALSTILDE", "EXCLAMATION", "EXECUTE", "EXISTS",
  "EXPLAIN", "FAL", "FROM", "FUNCTION", "GRAPH", "GRAPH_PATH", "GT", "IDS",
  "IF", "IMMUTABLE", "IN", "INDEX", "INHERIT", "INHERITS", "INPUT", "INTO",
  "IS", "LABELS", "LANGUAGE", "LBRACE", "LBRACKET", "LIMIT", "LOAD",
  "LOGGED", "LPAREN", "LT", "MATCH", "MERGE", "NOINHERIT", "NOT", "NUL",
  "OPTIONAL", "ON", "ONLY", "OR", "ORDER", "OWNER", "PARALLEL", "PERCENT",
  "PERFORM", "PIPE", "PLUS", "PREPARE", "QUERY", "RBRACE", "RBRACKET",
  "REINDEX", "REMOVE", "RENAME", "REPLACE", "RETURN", "RETURNS", "RPAREN",
  "SAFE", "SELECT", "SEMICOLON", "SET", "SETOF", "SHOW", "SKIP", "SLASH",
  "STABLE", "STARTS", "STORAGE", "STRICT", "TABLESPACE", "THEN", "TRU",
  "UNDER", "UNION", "UNIONALL", "UNIQUE", "UNLOGGED", "UNWIND", "VERBOSE",
  "VLABEL", "VOLATILE", "WHEN", "WHERE", "WITH", "WITHOUT", "XOR",
  "INTEGER", "FLOAT", "IDENTIFIER", "STRING", "UNKNOWN", "ARROW",
  "$accept", "statement", "queries", "query", "alter_clause",
  "alter_graph_options", "alter_vlabel_options", "case_clause",
  "comment_clause", "comment_item", "create_clause", "create_pattern",
  "logged_opt", "inherits_opt", "on_clause_opt", "tablespace_opt",
  "disable_index_opt", "constraint_patt", "assert_patt_opt",
  "compare_list", "constraint_addon_opt", "or_replace_opt", "setof_opt",
  "create_function_ext_opt", "create_function_exts", "create_function_ext",
  "declare_opt", "declare_list", "create_function_contents",
  "create_function_content", "into_opt", "delete_clause", "detach_opt",
  "drop_clause", "drop_pattern", "cascade_opt", "execute_clause",
  "stmt_info_opt", "exists_clause", "exists_pattern", "explain_clause",
  "explain_list", "explain_item", "load_clause", "load_pattern",
  "with_id_opt", "match_clause", "optional_opt", "pattern_list",
  "assign_to_variable_opt", "path_pattern_list", "path_pattern",
  "node_pattern", "node_alias_opt", "node_labels_opt",
  "node_properties_opt", "map_literal", "nonempty_map_literal",
  "map_entry", "only_opt", "dollar_opt", "edge_pattern", "rel_pattern",
  "rel_alias_opt", "rel_labels_opt", "pipe_opt",
  "variable_length_edges_opt", "edge_length_opt", "dot_opt",
  "upper_bound_opt", "merge_clause", "on_clause", "on_pattern",
  "order_clause", "sort_item_list", "sort_item", "sort_direction_opt",
  "prepare_clause", "reindex_clause", "remove_clause", "return_clause",
  "distinct_not_opt", "return_item_clause", "return_item_list",
  "str_match_clause_opt", "union_opt", "set_clause", "assign_list",
  "set_graph_clause", "graph_option", "graph_path_list", "show_clause",
  "sql_statement", "sql_query", "select_clause", "from_clause",
  "as_clause", "unwind_clause", "where_clause", "where_expression",
  "where_compare_opt", "with_clause", "item_clause", "boolean", "compare",
  "expression_list", "expression", "negative_opt", "array_opt",
  "dot_operator_opt", "list_opt", "list", "expression_ext_opt",
  "where_clause_opt", "function", "function_params_opt", "function_params",
  "id_list", "identifier_list", "item_list", "item", "is_expression_opt",
  "logic", "math_expression", "str_val", "as_opt", "boolean_opt",
  "distinct_opt", "expression_opt", "identifier_opt", "if_exists_opt",
  "limit_clause_opt", "not_opt", "order_clause_opt", "set_clause_opt",
  "skip_clause_opt", "typecast_opt", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354,
     355,   356,   357,   358,   359,   360,   361,   362,   363,   364,
     365,   366,   367,   368,   369,   370,   371,   372,   373,   374,
     375,   376,   377,   378,   379,   380,   381,   382,   383,   384,
     385
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint16 yyr1[] =
{
       0,   131,   132,   133,   133,   134,   134,   134,   134,   134,
     134,   134,   134,   134,   134,   134,   134,   134,   134,   134,
     134,   134,   134,   134,   134,   134,   135,   135,   136,   136,
     137,   137,   137,   137,   137,   137,   137,   137,   137,   137,
     138,   139,   140,   140,   141,   142,   142,   142,   142,   142,
     142,   143,   143,   143,   144,   144,   145,   145,   146,   146,
     147,   147,   148,   149,   149,   149,   150,   150,   151,   151,
     151,   151,   152,   152,   153,   153,   154,   154,   155,   155,
     156,   156,   156,   156,   156,   156,   156,   156,   156,   156,
     157,   157,   158,   158,   159,   159,   160,   160,   160,   161,
     161,   162,   163,   163,   164,   165,   165,   165,   165,   166,
     166,   167,   168,   168,   169,   169,   170,   170,   171,   171,
     172,   172,   173,   173,   173,   174,   175,   175,   175,   176,
     176,   177,   178,   178,   179,   179,   180,   180,   181,   181,
     182,   182,   183,   183,   183,   184,   184,   185,   185,   186,
     186,   187,   187,   188,   188,   189,   190,   190,   191,   191,
     192,   192,   192,   193,   193,   194,   194,   195,   195,   196,
     196,   197,   197,   198,   198,   198,   199,   199,   200,   200,
     201,   202,   203,   203,   204,   205,   205,   206,   207,   207,
     207,   208,   209,   210,   211,   212,   212,   212,   213,   213,
     214,   214,   215,   215,   215,   215,   215,   216,   216,   216,
     217,   217,   218,   218,   219,   220,   220,   221,   221,   222,
     223,   224,   225,   226,   227,   227,   228,   229,   230,   230,
     230,   231,   231,   231,   231,   232,   233,   233,   234,   234,
     235,   235,   235,   235,   235,   235,   235,   235,   236,   236,
     237,   237,   237,   237,   237,   237,   237,   237,   237,   237,
     237,   237,   237,   237,   238,   238,   239,   239,   240,   240,
     241,   241,   242,   242,   243,   243,   244,   244,   245,   245,
     245,   245,   246,   246,   247,   247,   248,   248,   248,   249,
     249,   250,   250,   251,   251,   251,   251,   251,   251,   251,
     251,   252,   252,   253,   253,   253,   254,   254,   254,   254,
     254,   254,   254,   254,   254,   254,   254,   254,   255,   255,
     256,   256,   257,   257,   258,   258,   259,   259,   260,   260,
     261,   261,   262,   262,   263,   263,   264,   264,   265,   265,
     266,   266,   267,   267
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     1,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     4,     5,     2,     2,
       3,     2,     2,     2,     2,     2,     2,     3,     2,     3,
       9,     6,     1,     1,     2,     2,     8,     6,     8,     7,
       2,     0,     1,     1,     0,     2,     0,     1,     0,     2,
       0,     2,     4,     0,     2,     4,     2,     4,     0,     4,
       4,     4,     0,     2,     0,     1,     0,     1,     1,     2,
       2,     1,     1,     1,     2,     1,     4,     5,     2,    11,
       0,     2,     3,     4,     1,     2,     2,     3,     5,     0,
       2,     4,     0,     1,     2,     5,     3,     4,     3,     0,
       1,     3,     0,     3,     4,     3,     1,     1,     2,     4,
       1,     3,     2,     2,     2,     2,     3,     7,     6,     0,
       2,     4,     0,     1,     2,     4,     0,     2,     1,     4,
       1,     3,     7,     6,     4,     0,     1,     0,     2,     0,
       3,     0,     1,     1,     3,     3,     0,     1,     0,     2,
       3,     4,     4,     7,     6,     0,     1,     0,     4,     0,
       2,     0,     2,     0,     3,     3,     0,     2,     0,     1,
       3,     2,     1,     1,     3,     1,     3,     2,     0,     1,
       1,     4,     3,     2,     4,     0,     1,     1,     5,     7,
       2,     4,     0,     3,     3,     2,     2,     0,     1,     1,
       2,     3,     1,     3,     4,     1,     1,     1,     3,     2,
       1,     1,     3,     5,     2,     5,     4,     2,     1,     3,
       3,     0,     3,     3,     4,     3,     4,     6,     1,     1,
       1,     2,     2,     1,     1,     2,     2,     2,     2,     4,
       1,     3,     3,     4,     1,     3,     3,     3,     4,     5,
       3,     2,     2,     1,     0,     1,     0,     3,     0,     2,
       0,     1,     1,     3,     0,     3,     0,     1,     4,     4,
       4,     4,     0,     1,     2,     4,     1,     3,     3,     1,
       3,     1,     3,     2,     4,     7,     3,     5,     1,     3,
       1,     0,     3,     1,     1,     1,     1,     3,     3,     4,
       3,     4,     3,     4,     3,     4,     3,     3,     1,     1,
       0,     2,     0,     1,     0,     1,     0,     2,     0,     1,
       0,     3,     0,     2,     0,     1,     0,     1,     0,     1,
       0,     2,     0,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint16 yydefact[] =
{
     102,     0,     0,    51,   103,     0,     0,     0,     0,     0,
       0,   133,     0,     0,   264,   195,   264,     0,     0,   264,
     334,   324,     0,   102,     3,     5,     6,     7,     8,     0,
       9,    10,    11,    12,    13,    14,     0,    15,    16,    17,
      18,    19,    20,    21,    22,   220,   221,    23,    24,    25,
       0,   330,     0,   328,    52,     0,    53,     0,    44,     0,
       0,   338,     0,   328,     0,   330,     0,   104,   112,   264,
     322,     0,   322,   322,   118,   120,     0,     0,   129,   125,
     145,   338,   140,   112,     0,   263,   265,     0,   239,   151,
     264,     0,   250,   238,   318,   319,   254,   193,   274,     0,
     266,   266,   196,   197,   264,     0,   215,   216,     0,   219,
       0,   335,   228,   227,   264,   325,   264,     1,     2,     4,
     264,   264,   136,     0,   334,     0,    42,    43,     0,   329,
      45,     0,    73,   137,   330,   330,   330,     0,   264,   339,
      50,   145,   134,   138,     0,   109,     0,   109,   264,   111,
     145,     0,   117,   116,   323,   123,     0,   122,   124,     0,
       0,   320,     0,     0,   264,   146,   147,     0,     0,     0,
     180,     0,   192,   261,   262,     0,     0,   152,   153,   272,
       0,   271,   286,     0,     0,     0,   264,   264,   264,   248,
     342,   342,   264,   268,   268,   328,   264,   300,   298,   207,
     202,   306,   342,   301,     0,   222,     0,     0,   303,   304,
     305,   334,   231,   264,   235,   336,   291,   338,   115,   338,
       0,     0,    26,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   210,   212,   264,     0,   136,     0,   110,   106,
     109,   108,     0,   146,   114,   119,   121,     0,     0,   126,
     130,     0,     0,   240,     0,   244,   243,   264,     0,   149,
     165,     0,     0,   141,   191,   264,   256,     0,   255,   264,
       0,   264,   257,   266,   260,   263,   318,     0,     0,     0,
     283,   274,   276,     0,   251,   252,     0,     0,   342,   342,
       0,   202,   306,     0,   208,   209,   194,   264,   264,     0,
     264,     0,   336,   200,   264,   264,   264,   264,   334,   264,
     264,   264,   264,   293,   102,   217,   214,   226,   230,   334,
     229,   334,     0,   318,   266,     0,   264,     0,   337,   340,
     101,   131,    28,    29,   331,     0,     0,     0,     0,     0,
       0,     0,    27,     0,    63,    54,    58,    54,    74,   264,
     211,   135,     0,    63,   107,   113,     0,   321,     0,   144,
     241,   242,   246,   245,   247,   156,   148,   151,   156,   166,
     167,   160,     0,   155,   154,   273,   286,   287,   288,   268,
     281,   264,   284,   280,   279,   278,     0,   249,   277,   275,
       0,   267,   269,   258,   253,   264,     0,   299,   342,   205,
     264,   206,   264,   340,   264,   312,   317,   264,   310,   296,
     264,   316,   264,   308,   264,   314,   307,     0,   264,   102,
       0,   264,   264,   334,   336,   292,   264,     0,   332,     0,
      31,    32,    33,    34,    35,    36,     0,    38,     0,    41,
     264,    62,   264,    56,     0,    60,    56,    75,   264,   213,
     139,   105,     0,     0,   157,     0,     0,   158,   264,     0,
     156,   162,   161,   259,   264,   264,   318,   343,     0,   336,
     201,   204,   203,   332,   313,   311,   264,   302,   309,   315,
     294,   301,     0,   218,   233,   232,   264,   340,   184,   185,
     188,   341,     0,   236,    30,    37,    39,   264,    64,    68,
      55,     0,    58,    57,    59,     0,    47,    58,    76,   128,
       0,   143,   150,     0,     0,   156,   169,   171,   285,   264,
     340,   198,   297,     0,     0,   223,   234,   332,   264,   189,
     190,   187,   333,     0,   334,    66,     0,   182,   183,   181,
      60,    61,    60,     0,     0,    82,     0,     0,     0,    83,
      85,    81,    49,    77,    78,   127,   159,   142,     0,     0,
     326,   173,   149,     0,   332,     0,     0,   224,   237,   186,
      65,     0,   264,   264,    46,    48,   328,    88,     0,    80,
      84,     0,    79,   164,   170,   264,   168,     0,   176,   172,
       0,   264,   199,   295,     0,    68,    68,    67,    68,     0,
       0,     0,   327,     0,     0,   178,   163,     0,   289,     0,
      70,    69,    71,    90,    86,     0,   175,   177,   179,   174,
      40,     0,   225,     0,     0,    87,   290,     0,    91,   264,
       0,     0,   195,    99,   264,    94,     0,    92,     0,   102,
       0,     0,     0,    95,    96,    93,    99,   100,    97,   328,
       0,     0,    98,    89
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    22,   633,    24,    25,   222,   342,   197,    26,   128,
      27,    58,    59,   443,   502,   445,   506,   130,   441,   498,
     535,    60,   448,   552,   553,   554,   624,   628,   634,   635,
     641,    28,    29,    30,    67,   239,    31,   149,    32,   151,
      33,    74,    75,    34,    79,   163,    35,    36,    61,    62,
     142,   143,    82,   166,   259,   368,   176,   177,   178,   455,
     514,   169,   261,   370,   460,   560,   562,   589,   605,   619,
      37,   503,   539,   328,   488,   489,   531,    38,    39,    40,
      41,   104,   199,   200,   302,   296,   139,   232,    42,   108,
     316,    43,    44,    45,    46,   205,   525,    47,    48,   113,
     320,    49,   214,    96,   312,   278,   201,    99,   193,   288,
     180,   181,   189,   389,   100,   279,   280,   185,   609,   215,
     216,   313,   211,   203,   101,   249,   155,   116,   586,   131,
     125,   493,   536,   329,   140,   428,   284
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -476
static const yytype_int16 yypact[] =
{
    1048,     8,   -37,    22,  -476,    43,   -80,   -14,     3,   226,
     -10,  -476,   -56,    72,   790,   183,   790,   315,   315,   790,
      -8,   179,   244,   943,  -476,  -476,  -476,  -476,  -476,   225,
    -476,  -476,   240,  -476,  -476,  -476,   211,  -476,  -476,  -476,
    -476,  -476,  -476,  -476,  -476,  -476,  -476,  -476,  -476,  -476,
     145,   269,   104,   163,  -476,   232,  -476,   291,  -476,    44,
     286,   256,   297,   163,   242,   269,   250,  -476,   321,   814,
     125,     4,   125,   125,   375,  -476,   279,   287,   300,  -476,
       5,   142,  -476,   321,   294,  -476,  -476,   198,  -476,   296,
     632,   157,  -476,  -476,   357,  -476,  -476,   410,   376,   248,
     367,   367,  -476,  -476,   206,   155,  -476,  -476,   394,  -476,
     428,  -476,   240,    24,   790,  -476,   420,  -476,  -476,  -476,
     790,   814,   308,   -31,   364,   311,  -476,  -476,   313,  -476,
    -476,   366,  -476,  -476,   269,   269,   269,   318,   790,   343,
    -476,    13,   429,   184,   373,   439,   322,   439,   537,  -476,
      36,   358,   184,  -476,  -476,  -476,    50,  -476,  -476,     4,
     411,   450,   407,   334,   790,   307,   451,   406,   448,   -10,
    -476,   468,  -476,  -476,  -476,   458,   389,   464,  -476,  -476,
     396,   469,   210,   390,   393,   395,   662,   790,   790,  -476,
     473,   473,   790,   460,   460,   163,   203,  -476,   310,   292,
     162,  -476,   473,   299,   425,  -476,   368,   369,  -476,  -476,
    -476,    -8,   341,   298,  -476,     6,  -476,    20,  -476,   256,
     370,   377,  -476,   452,   247,   441,   380,   384,   385,   387,
     357,   408,   499,  1214,   790,    79,   308,   392,  -476,  -476,
     439,  -476,    83,   319,  -476,  -476,  -476,   399,   397,  -476,
    -476,   475,   427,   485,   490,   493,   160,   790,   405,   472,
     409,   515,   406,  -476,  -476,   790,  -476,   296,  -476,   790,
     412,   790,  -476,   367,  -476,   445,    31,   147,    89,   446,
     525,   376,   422,   528,  -476,  -476,   461,   423,   473,   473,
     433,   162,   149,   432,  -476,  -476,  -476,   537,   790,   443,
     790,   444,   476,  -476,   674,   790,   700,   790,   364,   790,
     720,   762,   790,    21,  1048,  -476,   538,  -476,    24,   364,
    -476,   364,   516,    16,   161,   110,   537,   558,  -476,   470,
    -476,  -476,  -476,  -476,  -476,   495,   519,   455,   457,   459,
     462,   128,  -476,   463,   571,   531,   482,   531,   492,   790,
     499,  -476,   -10,   571,  -476,  -476,   518,  -476,   474,  -476,
    -476,  -476,  -476,  -476,  -476,   522,  -476,   296,   522,   307,
     585,   554,   582,  1214,  -476,  -476,    23,  -476,  -476,   460,
    -476,   605,  1214,  -476,  -476,  -476,   479,  -476,  -476,  -476,
     289,  -476,  -476,  -476,  -476,   790,   520,  -476,   473,  -476,
     790,  -476,   790,   470,   790,  -476,  -476,   790,  -476,  1116,
     790,  -476,   790,  -476,   790,  -476,  -476,   480,   790,   984,
     487,   790,   790,   364,   476,  -476,   790,   484,   548,   494,
    -476,  -476,  -476,  -476,  -476,  -476,   498,  -476,   602,  -476,
     863,  -476,   790,   544,   502,   603,   544,  -476,   790,  1214,
     184,  -476,   503,   557,  -476,   539,   546,   606,   790,   510,
     522,  -476,  -476,  -476,    19,   790,  -476,  -476,   954,   476,
    -476,  -476,  -476,   548,  -476,  -476,   790,  -476,  -476,  -476,
    -476,  1128,   636,  -476,  -476,  -476,   790,   470,   627,  -476,
     255,  -476,   523,  -476,  -476,  -476,  -476,   788,  -476,  1076,
    -476,   171,   482,  -476,  -476,   591,  -476,   482,   112,  -476,
     524,  -476,  -476,   526,   561,   522,   574,   650,  1214,   790,
     470,  -476,  -476,   654,   239,  -476,  -476,   548,   790,  -476,
    -476,  -476,  -476,   565,   364,    24,   608,  -476,  -476,  -476,
     603,  -476,   603,    15,   596,  -476,   289,   570,   600,  -476,
    -476,  -476,  -476,   112,  -476,  -476,  -476,  -476,   589,   552,
     645,    -1,   472,  1155,   548,   559,   617,  -476,  -476,  -476,
    -476,   116,   790,   790,  -476,  -476,   163,  -476,   614,  -476,
    -476,   613,  -476,  -476,  -476,   790,  -476,   658,   659,  -476,
     610,   790,  -476,  -476,   564,   282,   282,  -476,   282,   663,
     639,   628,  -476,   578,   676,   584,  -476,  1180,  -476,   143,
    -476,  -476,  -476,   685,  -476,   656,  -476,  -476,  -476,  -476,
    -476,   587,  -476,   590,   702,  -476,  -476,   592,   594,   553,
     618,   595,   192,   879,   436,  -476,  1194,  -476,   629,  1048,
     564,   633,   696,  -476,  -476,  -476,   879,   717,  -476,   163,
     641,   710,  -476,  -476
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -476,  -476,     0,   -22,  -476,  -476,  -476,  -476,  -476,  -476,
    -476,  -476,  -476,   398,   302,  -284,  -189,  -476,   400,  -475,
    -313,  -476,  -476,  -476,  -476,   193,  -476,  -476,  -476,   115,
     105,  -476,  -476,  -476,  -476,  -115,  -476,   669,    -9,   634,
    -476,   683,   597,  -476,  -476,  -476,  -476,  -476,   643,   530,
     620,    -3,   599,  -476,  -476,   207,   404,  -476,   507,  -348,
    -476,  -476,   513,  -476,  -476,  -476,  -476,  -476,  -476,  -476,
    -476,  -476,  -476,  -476,  -476,   249,  -476,  -476,  -476,  -476,
    -476,  -476,  -476,   580,   488,  -476,  -476,   547,  -476,   760,
    -476,  -476,   -77,  -476,  -476,  -476,  -476,  -476,   504,   569,
    -476,  -476,  -476,   312,  -156,    30,   -11,  -476,   -82,  -182,
    -476,  -476,   514,  -476,   -85,  -476,  -476,   521,   148,    40,
     -94,   316,   259,  -121,  -375,  -476,   346,  -476,  -476,   -61,
     174,  -442,   -16,  -289,   -65,  -382,  -173
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -335
static const yytype_int16 yytable[] =
{
      23,   119,   144,    98,   114,    98,   184,    81,   110,   257,
     202,   112,   289,   403,   183,   467,   170,   233,   285,   194,
     457,   473,   533,   326,    70,    70,   417,    85,   208,   303,
     587,   521,   241,   270,     7,  -318,   270,   187,    52,    85,
     270,    53,    86,   164,    97,   576,   105,    68,   220,    87,
    -318,   164,   231,    69,    86,    50,   321,    80,   153,   418,
     221,    87,    63,    88,   111,   184,   152,   159,   -72,   271,
      71,    83,   271,   183,   164,    88,   271,    64,   134,   179,
      80,    89,    90,   186,   327,   568,   381,   257,    54,  -136,
      65,   135,    92,    89,    90,   198,   236,   597,   381,    55,
     326,   209,   202,   212,    92,   527,   187,   198,   223,    98,
     153,  -286,   517,   233,  -286,   393,   394,   543,   152,   138,
      72,    72,   592,   544,   588,   354,    51,   326,   324,    93,
      73,    73,   165,    16,   290,   487,   183,    56,   564,   198,
     165,    93,   466,    95,   373,   245,    94,    95,   210,    57,
     217,   126,   330,   252,   331,   382,  -264,  -264,    94,    95,
     621,    66,   136,   243,   545,   167,  -272,   558,   577,    88,
     167,   579,   187,   546,   351,    98,   281,   282,   355,   297,
     520,   286,   298,   277,   384,   292,   409,   198,   242,   595,
      84,   379,   547,   537,   435,   114,   322,   463,   363,   299,
     204,   300,   112,   398,   198,   424,   548,   167,   115,   364,
     168,    85,   102,   458,    85,   168,   549,   195,   540,   550,
     195,   102,   127,   542,   192,   470,    86,   270,   449,    86,
     596,   551,   425,    87,   436,    93,    87,  -272,   622,   146,
     538,   138,   383,   437,   117,     7,   365,    88,     7,   120,
      88,   438,   168,   325,    16,   103,   273,   121,   375,    76,
     378,   529,   335,   271,   103,    89,    90,   301,    89,   196,
      91,    77,   123,    91,   468,   336,    92,   186,   639,    92,
     122,   530,   610,   611,   182,   612,    78,   399,   198,   401,
     129,  -270,   410,   405,   406,   408,   324,   481,   411,   413,
     415,   416,   337,   421,   183,   422,    85,   304,   227,   228,
     229,   305,   195,    93,   419,   293,    93,   198,   338,   499,
     124,    86,   306,   173,   132,   174,   339,   121,    87,   133,
      94,    95,   137,    94,    95,  -334,   270,   253,   340,   254,
       7,   534,    88,   382,   518,   253,   341,   254,   255,   450,
     566,   574,   307,   575,   111,   138,   255,   253,   308,   254,
      89,    90,   106,   107,   141,    91,   567,   256,   255,   145,
      98,    92,   271,   190,   191,   256,   499,   147,   277,   253,
     309,   254,   154,   310,   154,   154,   186,   256,   148,   471,
     255,   472,   159,   474,  -334,    16,   475,   119,   563,   477,
     319,   478,   311,   479,   294,   295,   160,   486,    93,   256,
     484,   485,   324,   111,   161,   490,   466,    95,   157,   158,
     183,   172,   162,   175,   186,   323,    95,   187,    85,   188,
     192,   500,   206,   207,   195,    57,   111,   508,   224,     1,
     225,   226,   234,    86,    85,   230,   236,   515,   237,   240,
      87,   499,   238,   244,     2,   248,   247,   250,     3,    86,
    -102,   251,     7,     4,    88,   522,    87,   258,     5,   260,
     607,   262,   642,   264,   265,   526,   266,     6,     7,     8,
      88,   267,    89,    90,   268,   272,   269,   213,   273,   283,
     274,   287,   314,    92,   334,   315,   317,   332,    89,    90,
     343,     9,   348,    91,   333,  -132,    10,   344,   636,    92,
      11,   345,   346,   636,   347,   599,   349,   490,   571,   353,
     358,    12,   359,   360,   357,    13,    14,   356,   361,   632,
      93,   362,   366,    16,   367,    17,   369,    18,   371,   376,
     380,   385,   386,    20,   390,    85,    93,    94,    95,   391,
     392,   195,    19,   395,   327,   420,     1,    20,    21,   397,
      86,    85,   598,    94,    95,   400,   402,    87,   426,   423,
     429,     2,   427,   430,   602,     3,    86,  -102,   440,     7,
       4,    88,   431,    87,   432,     5,   433,   442,   651,   434,
     444,   439,   447,   452,     6,     7,     8,    88,   454,    89,
      90,   459,   453,   461,    91,   462,   465,   480,   469,   491,
      92,   119,   492,   275,   483,    89,    90,   496,     9,   501,
      91,   494,  -132,    10,   119,   495,    92,    11,    86,   504,
     509,   505,   510,   512,   511,    87,   513,   516,    12,   646,
      85,   524,    13,    14,   528,   541,   632,    93,   532,    88,
      16,   555,    17,   556,    18,    86,   557,   559,   561,   565,
     570,   573,    87,    93,    94,    95,   580,    89,    90,    19,
     275,   578,   150,   581,    20,    21,    88,   583,    92,   584,
      94,    95,    85,   585,   594,    86,   593,   600,   601,   603,
     604,   608,    87,   613,    89,    90,   614,    86,   606,    91,
    -282,   615,    16,   616,    87,    92,    88,   617,    85,   618,
     623,   629,   404,   625,   626,    93,   637,   627,    88,   630,
    -270,   631,   638,    86,    89,    90,   649,   645,    85,   150,
      87,   648,   464,    95,   621,    92,    89,    90,   407,   652,
     653,    91,    93,    86,    88,   446,   582,    92,   507,   643,
      87,   650,   171,   451,   156,   218,   246,  -282,   412,    94,
      95,   235,    89,    90,    88,   219,   352,    91,   263,   590,
      85,   456,    93,    92,   374,   372,   291,   569,   109,   396,
     318,   350,    89,    90,    93,    86,   388,    91,   647,   276,
      95,   377,    87,    92,   572,   387,    85,   523,    85,     0,
     414,    94,    95,     0,     0,     0,    88,     0,     0,     0,
      93,    86,     0,    86,     0,     0,     0,     0,    87,     0,
      87,     0,    85,     0,    89,    90,     0,    94,    95,    91,
      93,     0,    88,     0,    88,    92,     0,    86,     0,     0,
       0,     0,     0,     0,    87,     0,     0,    94,    95,     0,
      89,    90,    89,    90,     0,    91,     0,    91,    88,     0,
       0,    92,     0,    92,     0,     0,     0,     0,     0,     0,
       0,    85,    93,     0,     0,     0,    89,    90,     0,     0,
       0,   150,     1,     0,     0,    16,    86,    92,     0,    94,
      95,     0,     0,    87,     0,     0,     0,     2,    93,     0,
      93,     3,     0,  -102,     0,     0,     4,    88,     0,     0,
       0,     5,     0,     0,     0,   323,    95,    94,    95,     0,
       6,     7,     8,     0,    93,    89,    90,     0,     0,     0,
     497,     0,     0,     0,     0,     0,    92,   640,     0,     0,
       0,    94,    95,     0,     9,     0,     1,     0,  -132,    10,
       0,     0,     0,    11,     0,     0,     0,     0,     0,     0,
       0,     2,   304,     0,    12,     3,   305,     0,    13,    14,
       4,     0,    15,    93,     0,     5,    16,   306,    17,     0,
      18,     0,     0,     0,     6,     7,     8,     1,     0,     0,
      94,    95,   253,     0,   254,    19,     0,     0,     0,     0,
      20,    21,     2,   255,     0,     0,     3,     0,     9,     0,
       0,     4,  -132,    10,     0,     0,     5,    11,     0,     0,
       0,     0,   256,     0,     0,     6,     7,     8,    12,     0,
       0,     0,    13,    14,     0,   309,    15,     0,   310,     0,
      16,   118,    17,     0,    18,     0,     0,     0,     0,     9,
       0,     1,     0,  -132,    10,     0,     0,   311,    11,    19,
       0,     0,     0,   519,    20,    21,     2,     0,     0,    12,
       3,     0,     0,    13,    14,     4,     0,    15,     0,   482,
       5,    16,     0,    17,   304,    18,     0,     0,   305,     6,
       7,     8,     0,     0,     0,     0,     0,     0,     0,   306,
      19,     0,     0,     0,     0,    20,    21,     0,     0,     0,
       0,     0,     0,     9,   253,     0,   254,  -132,    10,     0,
       0,     0,    11,     0,   304,   255,     0,     0,   305,  -334,
       0,     0,     0,    12,     0,   534,   304,    13,    14,   306,
     305,    15,     0,     0,   256,    16,     0,    17,   111,    18,
       0,   306,     0,     0,   253,     0,   254,   309,     0,     0,
     310,     0,     0,   304,    19,   255,   253,   305,   254,    20,
      21,     0,     0,     0,     0,     0,     0,   255,   306,   311,
       0,     0,     0,     0,   256,     0,     0,   308,   304,     0,
     591,     0,   305,   253,     0,   254,   256,   309,     0,   476,
     310,     0,   304,   306,   255,     0,   305,     0,     0,   309,
       0,     0,   310,     0,     0,     0,   620,   306,   253,   311,
     254,     0,   304,   256,     0,     0,   305,     0,     0,   255,
       0,   311,   253,     0,   254,     0,   309,   306,     0,   310,
       0,     0,     0,   255,     0,     0,     0,     0,   256,     0,
       0,     0,   253,     0,   254,     0,     0,     0,   311,     0,
       0,   309,   256,   255,   310,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   309,     0,     0,   310,     0,
       0,     0,   256,   311,     0,     0,     0,     0,     0,     0,
       0,     0,   644,     0,     0,   309,     0,   311,   310,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   311
};

static const yytype_int16 yycheck[] =
{
       0,    23,    63,    14,    20,    16,    91,    10,    19,   165,
     104,    20,   194,   302,    91,   390,    81,   138,   191,   101,
     368,   403,   497,    17,    21,    21,     5,     8,     4,   202,
      31,   473,   147,    17,    42,    16,    17,    17,    75,     8,
      17,    19,    23,    38,    14,    30,    16,   127,    79,    30,
      31,    38,   137,    67,    23,    47,   212,    67,    69,    38,
      91,    30,    19,    44,    72,   150,    69,    17,    46,    53,
      67,   127,    53,   150,    38,    44,    53,    34,    34,    90,
      67,    62,    63,    67,    78,   527,    67,   243,    66,    67,
      47,    47,    73,    62,    63,   104,    17,   572,    67,    77,
      17,    77,   196,   114,    73,   487,    17,   116,   124,   120,
     121,    95,   460,   234,    95,   288,   289,     5,   121,    99,
     117,   117,   564,    11,   125,   240,   118,    17,   213,   110,
     127,   127,   127,    97,   195,   424,   213,   115,   520,   148,
     127,   110,   127,   128,   265,    95,   127,   128,   124,   127,
     120,    47,   217,   164,   219,   276,   125,   126,   127,   128,
      17,   118,   118,   127,    52,    23,    17,   515,   543,    44,
      23,   546,    17,    61,    95,   186,   187,   188,    95,    17,
     469,   192,    20,   186,    95,   196,   307,   196,   148,    73,
     118,   273,    80,    22,    66,   211,   212,   379,    38,    37,
      45,    39,   211,   297,   213,    95,    94,    23,    29,    49,
      68,     8,    29,   369,     8,    68,   104,    14,   502,   107,
      14,    29,   118,   507,    63,   398,    23,    17,   349,    23,
     114,   119,   326,    30,   106,   110,    30,    88,    95,    65,
      69,    99,    95,   115,     0,    42,   257,    44,    42,    24,
      44,   123,    68,   213,    97,    72,    95,    17,   269,    33,
     271,     6,    15,    53,    72,    62,    63,   105,    62,    63,
      67,    45,   127,    67,   395,    28,    73,    67,    86,    73,
      69,    26,   595,   596,   127,   598,    60,   298,   297,   300,
     127,    88,   308,   304,   305,   306,   381,   418,   309,   310,
     311,   312,    55,   319,   381,   321,     8,     8,   134,   135,
     136,    12,    14,   110,   314,     5,   110,   326,    71,   440,
      51,    23,    23,   125,    92,   127,    79,    17,    30,    38,
     127,   128,    46,   127,   128,    53,    17,    38,    91,    40,
      42,    59,    44,   464,   465,    38,    99,    40,    49,   352,
     111,   540,    53,   542,    72,    99,    49,    38,    59,    40,
      62,    63,    47,    48,    67,    67,   127,    68,    49,   127,
     381,    73,    53,   125,   126,    68,   497,   127,   381,    38,
      81,    40,    70,    84,    72,    73,    67,    68,    67,   400,
      49,   402,    17,   404,    53,    97,   407,   419,   519,   410,
      59,   412,   103,   414,   112,   113,   127,   423,   110,    68,
     421,   422,   497,    72,   127,   426,   127,   128,    72,    73,
     497,   127,   122,   127,    67,   127,   128,    17,     8,    53,
      63,   442,    38,     5,    14,   127,    72,   448,   127,     3,
     127,    75,    99,    23,     8,   127,    17,   458,    75,   127,
      30,   572,    13,    95,    18,     5,    45,    50,    22,    23,
      24,   127,    42,    27,    44,   476,    30,    16,    32,    63,
     591,    23,    36,     5,    16,   486,    87,    41,    42,    43,
      44,    17,    62,    63,    88,    95,    17,    67,    95,    16,
      95,    31,    67,    73,    42,   127,   127,   127,    62,    63,
      59,    65,    94,    67,   127,    69,    70,   127,   629,    73,
      74,   127,   127,   634,   127,   576,    17,   528,   534,   127,
      45,    85,    95,    38,   127,    89,    90,   128,    38,    93,
     110,    38,   127,    97,    62,    99,   127,   101,    23,   127,
      95,    95,    17,   121,    16,     8,   110,   127,   128,    88,
     127,    14,   116,   120,    78,    17,     3,   121,   122,   127,
      23,     8,   573,   127,   128,   122,   122,    30,    10,    53,
      75,    18,   102,    54,   585,    22,    23,    24,     7,    42,
      27,    44,   127,    30,   127,    32,   127,    56,   649,   127,
     108,   128,   100,    75,    41,    42,    43,    44,    76,    62,
      63,    16,   128,    49,    67,    23,   127,   127,    88,   125,
      73,   633,    64,     8,   127,    62,    63,    15,    65,    75,
      67,   127,    69,    70,   646,   127,    73,    74,    23,   127,
     127,    28,    75,    87,    95,    30,    30,   127,    85,   639,
       8,     5,    89,    90,    17,    54,    93,   110,   125,    44,
      97,   127,    99,   127,   101,    23,    95,    83,     8,     5,
      95,    53,    30,   110,   127,   128,    96,    62,    63,   116,
       8,    75,    67,    73,   121,   122,    44,    88,    73,   127,
     127,   128,     8,    38,    67,    23,   127,    73,    75,    31,
      31,   127,    30,    30,    62,    63,    57,    23,    88,    67,
      95,    73,    97,   125,    30,    73,    44,    31,     8,   125,
      25,     9,    38,    57,   127,   110,    98,   127,    44,   127,
      88,   127,   127,    23,    62,    63,    30,    98,     8,    67,
      30,    98,   127,   128,    17,    73,    62,    63,    38,    98,
      30,    67,   110,    23,    44,   347,   553,    73,   446,   634,
      30,   646,    83,   353,    71,   121,   159,    95,    38,   127,
     128,   141,    62,    63,    44,   122,   236,    67,   169,   562,
       8,   367,   110,    73,   267,   262,   196,   528,    18,   291,
     211,   234,    62,    63,   110,    23,   282,    67,   640,   127,
     128,   270,    30,    73,   535,   281,     8,   481,     8,    -1,
      38,   127,   128,    -1,    -1,    -1,    44,    -1,    -1,    -1,
     110,    23,    -1,    23,    -1,    -1,    -1,    -1,    30,    -1,
      30,    -1,     8,    -1,    62,    63,    -1,   127,   128,    67,
     110,    -1,    44,    -1,    44,    73,    -1,    23,    -1,    -1,
      -1,    -1,    -1,    -1,    30,    -1,    -1,   127,   128,    -1,
      62,    63,    62,    63,    -1,    67,    -1,    67,    44,    -1,
      -1,    73,    -1,    73,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,     8,   110,    -1,    -1,    -1,    62,    63,    -1,    -1,
      -1,    67,     3,    -1,    -1,    97,    23,    73,    -1,   127,
     128,    -1,    -1,    30,    -1,    -1,    -1,    18,   110,    -1,
     110,    22,    -1,    24,    -1,    -1,    27,    44,    -1,    -1,
      -1,    32,    -1,    -1,    -1,   127,   128,   127,   128,    -1,
      41,    42,    43,    -1,   110,    62,    63,    -1,    -1,    -1,
      67,    -1,    -1,    -1,    -1,    -1,    73,    58,    -1,    -1,
      -1,   127,   128,    -1,    65,    -1,     3,    -1,    69,    70,
      -1,    -1,    -1,    74,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    18,     8,    -1,    85,    22,    12,    -1,    89,    90,
      27,    -1,    93,   110,    -1,    32,    97,    23,    99,    -1,
     101,    -1,    -1,    -1,    41,    42,    43,     3,    -1,    -1,
     127,   128,    38,    -1,    40,   116,    -1,    -1,    -1,    -1,
     121,   122,    18,    49,    -1,    -1,    22,    -1,    65,    -1,
      -1,    27,    69,    70,    -1,    -1,    32,    74,    -1,    -1,
      -1,    -1,    68,    -1,    -1,    41,    42,    43,    85,    -1,
      -1,    -1,    89,    90,    -1,    81,    93,    -1,    84,    -1,
      97,    98,    99,    -1,   101,    -1,    -1,    -1,    -1,    65,
      -1,     3,    -1,    69,    70,    -1,    -1,   103,    74,   116,
      -1,    -1,    -1,   109,   121,   122,    18,    -1,    -1,    85,
      22,    -1,    -1,    89,    90,    27,    -1,    93,    -1,    95,
      32,    97,    -1,    99,     8,   101,    -1,    -1,    12,    41,
      42,    43,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    23,
     116,    -1,    -1,    -1,    -1,   121,   122,    -1,    -1,    -1,
      -1,    -1,    -1,    65,    38,    -1,    40,    69,    70,    -1,
      -1,    -1,    74,    -1,     8,    49,    -1,    -1,    12,    53,
      -1,    -1,    -1,    85,    -1,    59,     8,    89,    90,    23,
      12,    93,    -1,    -1,    68,    97,    -1,    99,    72,   101,
      -1,    23,    -1,    -1,    38,    -1,    40,    81,    -1,    -1,
      84,    -1,    -1,     8,   116,    49,    38,    12,    40,   121,
     122,    -1,    -1,    -1,    -1,    -1,    -1,    49,    23,   103,
      -1,    -1,    -1,    -1,    68,    -1,    -1,    59,     8,    -1,
      35,    -1,    12,    38,    -1,    40,    68,    81,    -1,    83,
      84,    -1,     8,    23,    49,    -1,    12,    -1,    -1,    81,
      -1,    -1,    84,    -1,    -1,    -1,    36,    23,    38,   103,
      40,    -1,     8,    68,    -1,    -1,    12,    -1,    -1,    49,
      -1,   103,    38,    -1,    40,    -1,    81,    23,    -1,    84,
      -1,    -1,    -1,    49,    -1,    -1,    -1,    -1,    68,    -1,
      -1,    -1,    38,    -1,    40,    -1,    -1,    -1,   103,    -1,
      -1,    81,    68,    49,    84,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    81,    -1,    -1,    84,    -1,
      -1,    -1,    68,   103,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    98,    -1,    -1,    81,    -1,   103,    84,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,   103
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint16 yystos[] =
{
       0,     3,    18,    22,    27,    32,    41,    42,    43,    65,
      70,    74,    85,    89,    90,    93,    97,    99,   101,   116,
     121,   122,   132,   133,   134,   135,   139,   141,   162,   163,
     164,   167,   169,   171,   174,   177,   178,   201,   208,   209,
     210,   211,   219,   222,   223,   224,   225,   228,   229,   232,
      47,   118,    75,    19,    66,    77,   115,   127,   142,   143,
     152,   179,   180,    19,    34,    47,   118,   165,   127,    67,
      21,    67,   117,   127,   172,   173,    33,    45,    60,   175,
      67,   182,   183,   127,   118,     8,    23,    30,    44,    62,
      63,    67,    73,   110,   127,   128,   234,   236,   237,   238,
     245,   255,    29,    72,   212,   236,    47,    48,   220,   220,
     237,    72,   169,   230,   263,    29,   258,     0,    98,   134,
      24,    17,    69,   127,    51,   261,    47,   118,   140,   127,
     148,   260,    92,    38,    34,    47,   118,    46,    99,   217,
     265,    67,   181,   182,   260,   127,   261,   127,    67,   168,
      67,   170,   182,   237,   234,   257,   172,   257,   257,    17,
     127,   127,   122,   176,    38,   127,   184,    23,    68,   192,
     265,   168,   127,   125,   127,   127,   187,   188,   189,   237,
     241,   242,   127,   223,   245,   248,    67,    17,    53,   243,
     125,   126,    63,   239,   239,    14,    63,   138,   169,   213,
     214,   237,   251,   254,    45,   226,    38,     5,     4,    77,
     124,   253,   237,    67,   233,   250,   251,   236,   170,   179,
      79,    91,   136,   263,   127,   127,    75,   261,   261,   261,
     127,   245,   218,   254,    99,   181,    17,    75,    13,   166,
     127,   166,   250,   127,    95,    95,   173,    45,     5,   256,
      50,   127,   237,    38,    40,    49,    68,   235,    16,   185,
      63,   193,    23,   183,     5,    16,    87,    17,    88,    17,
      17,    53,    95,    95,    95,     8,   127,   182,   236,   246,
     247,   237,   237,    16,   267,   267,   237,    31,   240,   240,
     260,   214,   237,     5,   112,   113,   216,    17,    20,    37,
      39,   105,   215,   267,     8,    12,    23,    53,    59,    81,
      84,   103,   235,   252,    67,   127,   221,   127,   230,    59,
     231,   235,   263,   127,   245,   250,    17,    78,   204,   264,
     265,   265,   127,   127,    42,    15,    28,    55,    71,    79,
      91,    99,   137,    59,   127,   127,   127,   127,    94,    17,
     218,    95,   180,   127,   166,    95,   128,   127,    45,    95,
      38,    38,    38,    38,    49,   237,   127,    62,   186,   127,
     194,    23,   193,   254,   189,   237,   127,   248,   237,   239,
      95,    67,   254,    95,    95,    95,    17,   243,   229,   244,
      16,    88,   127,   267,   267,   120,   215,   127,   251,   237,
     122,   237,   122,   264,    38,   237,   237,    38,   237,   254,
     263,   237,    38,   237,    38,   237,   237,     5,    38,   133,
      17,   263,   263,    53,    95,   251,    10,   102,   266,    75,
      54,   127,   127,   127,   127,    66,   106,   115,   123,   128,
       7,   149,    56,   144,   108,   146,   144,   100,   153,   254,
     182,   149,    75,   128,    76,   190,   187,   190,   235,    16,
     195,    49,    23,   240,   127,   127,   127,   255,   254,    88,
     267,   237,   237,   266,   237,   237,    83,   237,   237,   237,
     127,   254,    95,   127,   237,   237,   263,   264,   205,   206,
     237,   125,    64,   262,   127,   127,    15,    67,   150,   254,
     237,    75,   145,   202,   127,    28,   147,   145,   237,   127,
      75,    95,    87,    30,   191,   237,   127,   190,   254,   109,
     264,   262,   237,   252,     5,   227,   237,   266,    17,     6,
      26,   207,   125,   150,    59,   151,   263,    22,    69,   203,
     146,    54,   146,     5,    11,    52,    61,    80,    94,   104,
     107,   119,   154,   155,   156,   127,   127,    95,   190,    83,
     196,     8,   197,   254,   266,     5,   111,   127,   262,   206,
      95,   263,   253,    53,   147,   147,    30,   255,    75,   255,
      96,    73,   156,    88,   127,    38,   259,    31,   125,   198,
     186,    35,   262,   127,    67,    73,   114,   150,   237,   260,
      73,    75,   237,    31,    31,   199,    88,   254,   127,   249,
     151,   151,   151,    30,    57,    73,   125,    31,   125,   200,
      36,    17,    95,    25,   157,    57,   127,   127,   158,     9,
     127,   127,    93,   133,   159,   160,   254,    98,   127,    86,
      58,   161,    36,   160,    98,    98,   133,   249,    98,    30,
     161,   260,    98,    30
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 191 "cypher.y"
    { YYACCEPT; }
    break;

  case 5:
#line 200 "cypher.y"
    { alter = true; }
    break;

  case 6:
#line 201 "cypher.y"
    { comment = true; }
    break;

  case 9:
#line 204 "cypher.y"
    { drop = true; }
    break;

  case 10:
#line 205 "cypher.y"
    { execute = true; }
    break;

  case 12:
#line 207 "cypher.y"
    { explain = true; }
    break;

  case 13:
#line 208 "cypher.y"
    { load = true; }
    break;

  case 14:
#line 209 "cypher.y"
    { match = true; }
    break;

  case 15:
#line 210 "cypher.y"
    { merge = true; }
    break;

  case 16:
#line 211 "cypher.y"
    { prepare = true; }
    break;

  case 17:
#line 212 "cypher.y"
    { reindex = true; }
    break;

  case 19:
#line 214 "cypher.y"
    { rtn = true; }
    break;

  case 20:
#line 215 "cypher.y"
    { set_path = true; }
    break;

  case 21:
#line 216 "cypher.y"
    { show = true; }
    break;

  case 23:
#line 218 "cypher.y"
    { unwind = true; }
    break;

  case 24:
#line 219 "cypher.y"
    { where = true; }
    break;

  case 25:
#line 220 "cypher.y"
    { with = true; }
    break;

  case 26:
#line 230 "cypher.y"
    { graph_name = (yyvsp[(3) - (4)].str_val); }
    break;

  case 28:
#line 235 "cypher.y"
    { alter_graph = true; }
    break;

  case 29:
#line 236 "cypher.y"
    { alter_graph_name = (yyvsp[(2) - (2)].str_val); rename_graph = true; }
    break;

  case 45:
#line 289 "cypher.y"
    { create = true; }
    break;

  case 46:
#line 291 "cypher.y"
    { edge_name = (yyvsp[(4) - (8)].str_val); create_elabel = true; }
    break;

  case 47:
#line 293 "cypher.y"
    { graph_name = (yyvsp[(4) - (6)].str_val); create_graph = true; }
    break;

  case 48:
#line 295 "cypher.y"
    { label_name = (yyvsp[(4) - (8)].str_val); create_vlabel = true; }
    break;

  case 49:
#line 297 "cypher.y"
    { create_function = true; }
    break;

  case 50:
#line 298 "cypher.y"
    { create = true; }
    break;

  case 55:
#line 309 "cypher.y"
    { inheritance = true; }
    break;

  case 92:
#line 393 "cypher.y"
    { declare_list->idt = (yyvsp[(1) - (3)].str_val); }
    break;

  case 93:
#line 395 "cypher.y"
    { list_append(&declare_list, NULL, (yyvsp[(2) - (4)].str_val)); }
    break;

  case 98:
#line 406 "cypher.y"
    { return_query = true; }
    break;

  case 106:
#line 441 "cypher.y"
    { label_name = (yyvsp[(2) - (3)].str_val); drop_label = true; }
    break;

  case 107:
#line 443 "cypher.y"
    { graph_name = (yyvsp[(3) - (4)].str_val); drop_graph = true; }
    break;

  case 108:
#line 444 "cypher.y"
    { label_name = (yyvsp[(2) - (3)].str_val); drop_label = true; }
    break;

  case 110:
#line 449 "cypher.y"
    { cascade = true; }
    break;

  case 127:
#line 518 "cypher.y"
    {
        label_name = (yyvsp[(3) - (7)].str_val); file_path = (yyvsp[(5) - (7)].str_val); graph_name = (yyvsp[(7) - (7)].str_val); load_labels = true;
      }
    break;

  case 128:
#line 522 "cypher.y"
    {
        edge_name = (yyvsp[(2) - (6)].str_val); file_path = (yyvsp[(4) - (6)].str_val); graph_name = (yyvsp[(6) - (6)].str_val); load_edges = true;
      }
    break;

  case 130:
#line 529 "cypher.y"
    { with_ids = true; }
    break;

  case 133:
#line 544 "cypher.y"
    { optional = true; }
    break;

  case 145:
#line 575 "cypher.y"
    { (yyval.str_val) = NULL; }
    break;

  case 146:
#line 576 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 147:
#line 580 "cypher.y"
    { (yyval.str_val) = NULL; }
    break;

  case 148:
#line 581 "cypher.y"
    { (yyval.str_val) = (yyvsp[(2) - (2)].str_val); }
    break;

  case 149:
#line 585 "cypher.y"
    { (yyval.pair) = NULL; }
    break;

  case 150:
#line 586 "cypher.y"
    { (yyval.pair) = (yyvsp[(2) - (3)].pair); }
    break;

  case 151:
#line 590 "cypher.y"
    { (yyval.pair) = NULL; }
    break;

  case 152:
#line 591 "cypher.y"
    { (yyval.pair) = (yyvsp[(1) - (1)].pair); }
    break;

  case 153:
#line 595 "cypher.y"
    { (yyval.pair) = (yyvsp[(1) - (1)].pair); }
    break;

  case 154:
#line 596 "cypher.y"
    { (yyval.pair) = (yyvsp[(3) - (3)].pair); }
    break;

  case 155:
#line 601 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->idt = (yyvsp[(1) - (3)].str_val);
        (yyval.pair)->exp = (yyvsp[(3) - (3)].str_val);
    }
    break;

  case 160:
#line 619 "cypher.y"
    { rel_direction = 0; }
    break;

  case 161:
#line 620 "cypher.y"
    { rel_direction = -1; }
    break;

  case 162:
#line 621 "cypher.y"
    { rel_direction = 1; }
    break;

  case 165:
#line 631 "cypher.y"
    { (yyval.str_val) = NULL; }
    break;

  case 166:
#line 632 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 167:
#line 636 "cypher.y"
    { (yyval.str_val) = NULL; }
    break;

  case 168:
#line 637 "cypher.y"
    { (yyval.str_val) = (yyvsp[(2) - (4)].str_val); }
    break;

  case 171:
#line 646 "cypher.y"
    { (yyval.pat) = NULL; }
    break;

  case 172:
#line 647 "cypher.y"
    { (yyval.pat) = (yyvsp[(2) - (2)].pat); }
    break;

  case 173:
#line 651 "cypher.y"
    { (yyval.pat) = NULL; }
    break;

  case 174:
#line 653 "cypher.y"
    { 
        (yyval.pat) = (EdgePattern*) malloc(sizeof(EdgePattern));
        (yyval.pat)->lower = (yyvsp[(1) - (3)].int_val); 
        (yyval.pat)->dot = (yyvsp[(2) - (3)].bool_val);
        (yyval.pat)->upper = (yyvsp[(3) - (3)].int_val);
      }
    break;

  case 175:
#line 660 "cypher.y"
    { 
        (yyval.pat) = (EdgePattern*) malloc(sizeof(EdgePattern));
        (yyval.pat)->upper = (yyvsp[(3) - (3)].int_val); 
      }
    break;

  case 176:
#line 667 "cypher.y"
    { (yyval.bool_val) = false; }
    break;

  case 177:
#line 668 "cypher.y"
    { (yyval.bool_val) = true; }
    break;

  case 178:
#line 672 "cypher.y"
    { (yyval.int_val) = 0; }
    break;

  case 179:
#line 673 "cypher.y"
    { (yyval.int_val) = (yyvsp[(1) - (1)].int_val); }
    break;

  case 188:
#line 721 "cypher.y"
    { (yyval.int_val) = 1; }
    break;

  case 189:
#line 722 "cypher.y"
    { (yyval.int_val) = 1; }
    break;

  case 190:
#line 723 "cypher.y"
    { (yyval.int_val) = -1; }
    break;

  case 200:
#line 781 "cypher.y"
    { rtn_list->exp = (yyvsp[(1) - (2)].pair)->exp; rtn_list->idt = (yyvsp[(1) - (2)].pair)->idt; type_list->exp = (yyvsp[(2) - (2)].str_val); }
    break;

  case 201:
#line 783 "cypher.y"
    {
        list_append(&rtn_list, (yyvsp[(3) - (4)].pair)->exp, (yyvsp[(3) - (4)].pair)->idt);
        list_append(&type_list, (yyvsp[(4) - (4)].str_val), NULL);
      }
    break;

  case 210:
#line 810 "cypher.y"
    { set = true; }
    break;

  case 214:
#line 826 "cypher.y"
    { graph_name = (yyvsp[(4) - (4)].str_val); }
    break;

  case 217:
#line 835 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 218:
#line 837 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s, %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val)); (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 221:
#line 865 "cypher.y"
    { sql_select = true; }
    break;

  case 240:
#line 947 "cypher.y"
    { (yyval.str_val) = "="; }
    break;

  case 241:
#line 948 "cypher.y"
    { (yyval.str_val) = "=="; }
    break;

  case 242:
#line 949 "cypher.y"
    { (yyval.str_val) = "!="; }
    break;

  case 243:
#line 950 "cypher.y"
    { (yyval.str_val) = "<"; }
    break;

  case 244:
#line 951 "cypher.y"
    { (yyval.str_val) = ">"; }
    break;

  case 245:
#line 952 "cypher.y"
    { (yyval.str_val) = "<="; }
    break;

  case 246:
#line 953 "cypher.y"
    { (yyval.str_val) = ">="; }
    break;

  case 247:
#line 954 "cypher.y"
    { (yyval.str_val) = "<>"; }
    break;

  case 248:
#line 958 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (2)].str_val); }
    break;

  case 249:
#line 959 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 250:
#line 964 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "!_null");
        (yyval.str_val) = temp;
        free(temp);
    }
    break;

  case 251:
#line 971 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%d", (yyvsp[(2) - (3)].int_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 252:
#line 978 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%f", (yyvsp[(2) - (3)].float_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 253:
#line 985 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 254:
#line 987 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "?_bool");
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 255:
#line 994 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "[]_list");
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 256:
#line 1001 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "{}_property");
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 257:
#line 1008 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "|_sql");
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 258:
#line 1014 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 259:
#line 1015 "cypher.y"
    { (yyval.str_val) = (yyvsp[(2) - (5)].str_val); }
    break;

  case 260:
#line 1016 "cypher.y"
    { (yyval.str_val) = (yyvsp[(2) - (3)].pair)->idt; }
    break;

  case 261:
#line 1017 "cypher.y"
    { (yyval.str_val) = "dollar_int"; }
    break;

  case 262:
#line 1018 "cypher.y"
    { (yyval.str_val) = "dollar_identifier"; }
    break;

  case 263:
#line 1019 "cypher.y"
    { (yyval.str_val) = "*"; }
    break;

  case 278:
#line 1058 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 279:
#line 1059 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 280:
#line 1060 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 281:
#line 1061 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (4)].str_val); }
    break;

  case 286:
#line 1076 "cypher.y"
    { 
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(1) - (1)].str_val);
        list_append(&id_val_list, (yyval.pair)->exp, (yyval.pair)->idt);
    }
    break;

  case 287:
#line 1083 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(1) - (3)].str_val);
        list_append(&id_val_list, (yyval.pair)->exp, (yyval.pair)->idt);
    }
    break;

  case 288:
#line 1090 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(1) - (3)].str_val);
    }
    break;

  case 293:
#line 1109 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = (yyvsp[(1) - (2)].str_val);
        (yyval.pair)->idt = NULL;
    }
    break;

  case 294:
#line 1115 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(4) - (4)].str_val);
      }
    break;

  case 295:
#line 1122 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(7) - (7)].str_val);
      }
    break;

  case 296:
#line 1128 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = "bool";
        (yyval.pair)->idt = NULL;
      }
    break;

  case 297:
#line 1134 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = (yyvsp[(5) - (5)].str_val);
        (yyval.pair)->idt = NULL;
      }
    break;

  case 298:
#line 1140 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = "bool";
        (yyval.pair)->idt = NULL;
      }
    break;

  case 299:
#line 1146 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = NULL;
        (yyval.pair)->idt = (yyvsp[(3) - (3)].str_val);
      }
    break;

  case 300:
#line 1152 "cypher.y"
    {
        (yyval.pair) = (MapPair*) malloc(sizeof(MapPair));
        (yyval.pair)->exp = "case";
        (yyval.pair)->idt = NULL;
      }
    break;

  case 303:
#line 1165 "cypher.y"
    { (yyval.str_val) = "AND"; }
    break;

  case 304:
#line 1166 "cypher.y"
    { (yyval.str_val) = "OR"; }
    break;

  case 305:
#line 1167 "cypher.y"
    { (yyval.str_val) = "XOR"; }
    break;

  case 306:
#line 1171 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 307:
#line 1173 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s = %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 308:
#line 1180 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s + %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 309:
#line 1187 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s += %s", (yyvsp[(1) - (4)].str_val), (yyvsp[(4) - (4)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 310:
#line 1194 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s - %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 311:
#line 1201 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s -= %s", (yyvsp[(1) - (4)].str_val), (yyvsp[(4) - (4)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 312:
#line 1208 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s * %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 313:
#line 1215 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s *= %s", (yyvsp[(1) - (4)].str_val), (yyvsp[(4) - (4)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 314:
#line 1222 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s / %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 315:
#line 1229 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s /= %s", (yyvsp[(1) - (4)].str_val), (yyvsp[(4) - (4)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 316:
#line 1236 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s %% %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 317:
#line 1243 "cypher.y"
    {
        char* temp = (char*) malloc(sizeof(char));
        sprintf(temp, "%s ^ %s", (yyvsp[(1) - (3)].str_val), (yyvsp[(3) - (3)].str_val));
        (yyval.str_val) = temp;
        free(temp);
      }
    break;

  case 318:
#line 1252 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 319:
#line 1253 "cypher.y"
    { (yyval.str_val) = (yyvsp[(1) - (1)].str_val); }
    break;

  case 326:
#line 1278 "cypher.y"
    { (yyval.str_val) = NULL; }
    break;

  case 327:
#line 1279 "cypher.y"
    { (yyval.str_val) = (yyvsp[(2) - (2)].str_val); }
    break;

  case 342:
#line 1318 "cypher.y"
    { (yyval.str_val) = "agtype"; }
    break;

  case 343:
#line 1320 "cypher.y"
    {
	    if (strcmp((yyvsp[(3) - (3)].str_val), "pg_bigint") == 0 || strcmp((yyvsp[(3) - (3)].str_val), "numeric") == 0)
            (yyval.str_val) = "int";
        else if (strcmp((yyvsp[(3) - (3)].str_val), "pg_float8") == 0)
            (yyval.str_val) = "float";
        else
            (yyval.str_val) = (yyvsp[(3) - (3)].str_val);
      }
    break;


/* Line 1267 of yacc.c.  */
#line 3307 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 1329 "cypher.y"


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

