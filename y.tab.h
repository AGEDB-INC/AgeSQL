/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

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
/* Line 1529 of yacc.c.  */
#line 319 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

