/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SINTATICO_TAB_H_INCLUDED
# define YY_YY_SINTATICO_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    CLASSE = 258,                  /* CLASSE  */
    CLASSE_RESERVADA = 259,        /* CLASSE_RESERVADA  */
    PROPRIEDADE = 260,             /* PROPRIEDADE  */
    PROPRIEDADE_ISOF = 261,        /* PROPRIEDADE_ISOF  */
    PROPRIEDADE_HAS = 262,         /* PROPRIEDADE_HAS  */
    TIPODADO = 263,                /* TIPODADO  */
    NUM = 264,                     /* NUM  */
    INDIVIDUO = 265,               /* INDIVIDUO  */
    ONLY_RESERVADA = 266,          /* ONLY_RESERVADA  */
    OR_RESERVADA = 267,            /* OR_RESERVADA  */
    SOME_RESERVADA = 268,          /* SOME_RESERVADA  */
    ALL_RESERVADA = 269,           /* ALL_RESERVADA  */
    VALUE_RESERVADA = 270,         /* VALUE_RESERVADA  */
    MIN_RESERVADA = 271,           /* MIN_RESERVADA  */
    MAX_RESERVADA = 272,           /* MAX_RESERVADA  */
    EXACTLY_RESERVADA = 273,       /* EXACTLY_RESERVADA  */
    THAT_RESERVADA = 274,          /* THAT_RESERVADA  */
    NOT_RESERVADA = 275,           /* NOT_RESERVADA  */
    AND_RESERVADA = 276,           /* AND_RESERVADA  */
    INDIVIDUALS_RESERVADA = 277,   /* INDIVIDUALS_RESERVADA  */
    EQUIVALENT_RESERVADA = 278,    /* EQUIVALENT_RESERVADA  */
    SUBCLASSOF_RESERVADA = 279,    /* SUBCLASSOF_RESERVADA  */
    DISJOINTCLASSES_RESERVADA = 280, /* DISJOINTCLASSES_RESERVADA  */
    ABREPAR = 281,                 /* ABREPAR  */
    FECHAPAR = 282,                /* FECHAPAR  */
    ABRECHAVE = 283,               /* ABRECHAVE  */
    FECHACHAVE = 284,              /* FECHACHAVE  */
    ABRECOLCHETE = 285,            /* ABRECOLCHETE  */
    FECHACOLCHETE = 286,           /* FECHACOLCHETE  */
    VIRGULA = 287,                 /* VIRGULA  */
    RELOP = 288,                   /* RELOP  */
    VAR = 289                      /* VAR  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 24 "sintatico.y"

	double num;
	int ind;

#line 103 "sintatico.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SINTATICO_TAB_H_INCLUDED  */
