%{ 
#include "sintatico.tab.h"
extern double variables[26];
%}

%option yylineno
%option noyywrap

numero  [0-9]+("."[0-9]+)?
var     [a-z]

individuo [A-Z][a-zA-Z0-9_]*[0-9]+
eol  [ \t\n]
brancos [eol]+

classe_reservada (Class:)
equivalentTo (EquivalentTo:)
individuals (Individuals:)
subclassof (SubClassOf:)
disjointclasses (DisjointClasses:)
propriedade  [a-z][A-Za-z0-9]*
propriedade_has (has[A-Za-z]+)
classe [A-Z][a-zA-Z_]+
propriedade_isof {propriedade}("is"[A-Z][a-zA-Z_]+"of")
tipoDado (owl|rdfs|xsd):[A-Za-z0-9_]+
cardinalidade [0-9]+

%%

only {yylval.only_reservada = strdup(yytext); return ONLY_RESERVADA; }
or {yylval.or_reservada = strdup(yytext); return OR_RESERVADA; }
some {yylval.some_reservada = strdup(yytext); return SOME_RESERVADA;}
all  {yylval.all_reservada = strdup(yytext); return ALL_RESERVADA;}
value {yylval.value_reservada = strdup(yytext); return VALUE_RESERVADA;}
min {yylval.min_reservada = strdup(yytext); return MIN_RESERVADA;}
max {yylval.max_reservada = strdup(yytext); return MAX_RESERVADA;}
exactly {yylval.exactly_reservada = strdup(yytext); return EXACTLY_RESERVADA;}
that {yylval.that_reservada = strdup(yytext); return THAT_RESERVADA;}
not {yylval.not_reservada = strdup(yytext); return NOT_RESERVADA;}
and {yylval.and_reservada = strdup(yytext); return AND_RESERVADA;}
{classe_reservada} {yylval.classe_reservada = strdup(yytext); return CLASSE_RESERVADA;}
{equivalentTo} { yylval.equivalentTo = strdup(yytext); return EQUIVALENT_RESERVADA;} 
{individuals} { yylval.individuals = strdup(yytext); return INDIVIDUALS_RESERVADA;}
{subclassof} {yylval.subclassof = strdup(yytext); return SUBCLASSOF_RESERVADA;}
{disjointclasses} {yylval.disjointclasses = strdup(yytext); return DISJOINTCLASSES_RESERVADA;}
{numero}    { yylval.num = atof(yytext); return NUM; }
{propriedade_isof} {yylval.propriedade_isof = strdup(yytext); return PROPRIEDADE_ISOF;}
{propriedade_has} {yylval.propriedade_has = strdup(yytext); return PROPRIEDADE_HAS;}
{propriedade} {yylval.propriedade = strdup(yytext); return PROPRIEDADE;}
{tipoDado} {yylval.tipoDado = strdup(yytext); return TIPODADO;}
{classe}   { yylval.classe = strdup(yytext); return CLASSE; }
{individuo} { yylval.individuo = strdup(yytext); return INDIVIDUO; }
"(" {yylval.abrePar = strdup(yytext); return ABREPAR; }
")" {yylval.fechaPar = strdup(yytext); return FECHAPAR;}
"{" {yylval.abreChave = strdup(yytext); return ABRECHAVE;}
"}" {yylval.fechaChave = strdup(yytext); return FECHACHAVE;}
"[" {yylval.abreColchete = strdup(yytext); return ABRECOLCHETE;}
"]" {yylval.fechaColchete = strdup(yytext); return FECHACOLCHETE;}
"," {yylval.virgula = strdup(yytext); return VIRGULA;}
"<" {yylval.relop = strdup(yytext); return RELOP;}
">" {yylval.relop = strdup(yytext); return RELOP;}
"=" {yylval.relop = strdup(yytext); return RELOP;}
