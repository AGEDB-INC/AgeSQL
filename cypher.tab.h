/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_CYPHER_TAB_H_INCLUDED
# define YY_YY_CYPHER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
#ifdef RETURN
# undef RETURN
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ASC = 258,
    DESC = 259,
    DASH = 260,
    LT = 261,
    GT = 262,
    LBRACKET = 263,
    RBRACKET = 264,
    LPAREN = 265,
    RPAREN = 266,
    COLON = 267,
    PIPE = 268,
    COMMA = 269,
    SEMICOLON = 270,
    LBRACE = 271,
    RBRACE = 272,
    ASTERISK = 273,
    DOT = 274,
    MATCH = 275,
    ON = 276,
    WHERE = 277,
    WITH = 278,
    ORDER = 279,
    BY = 280,
    SKIP = 281,
    LIMIT = 282,
    RETURN = 283,
    AS = 284,
    AND = 285,
    OR = 286,
    XOR = 287,
    NOT = 288,
    exit_command = 289,
    INTEGER = 290,
    IDENTIFIER = 291,
    STRING = 292,
    COMPARATOR = 293,
    UNKNOWN = 294,
    ARROW = 295
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 59 "cypher.y"

    char* str_val;
    int int_val;
    bool bool_val;
    struct edge_pattern* pat;
    struct map_pair* pair;

#line 106 "cypher.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_CYPHER_TAB_H_INCLUDED  */
