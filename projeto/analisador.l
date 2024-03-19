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
/*Class: Spiciness EquivalentTo: {Hot , Medium , Mild}*/
/*Classe_reservada classe especial */
classe_reservada (Class:)
reservada (some|all|value|min|max|exactly|that|not|and|only|or)
equivalentTo (EquivalentTo:)
individuals (Individuals:)
subclassof (SubClassOf:)
disjointclasses (DisjointClasses:)
especial ("{"|"}"|"("|")"|"["|"]"|","|"<"|">"|"=")
propriedade  [a-z][A-Za-z0-9]*
propriedade_has (has[A-Za-z]+)
classe [A-Z][a-zA-Z_]+
propriedade_isof {propriedade}("is"[A-Z][a-zA-Z_]+"of")
tipoDado (owl|rdfs|xsd):[A-Za-z0-9_]+
cardinalidade [0-9]+

%%

{reservada} { yylval.reservada = strdup(yytext); return RESERVADA; }
{classe_reservada} {yylval.classe_reservada = strdup(yytext); return CLASSE_RESERVADA;}
{equivalentTo} { yylval.equivalentTo = strdup(yytext); return EQUIVALENT_RESERVADA;} 
{individuals} { yylval.individuals = strdup(yytext); return INDIVIDUALS_RESERVADA;}
{subclassof} {yylval.subclassof = strdup(yytext); return SUBCLASSOF_RESERVADA;}
{disjointclasses} {yylval.disjointclasses = strdup(yytext); return DISJOINTCLASSES_RESERVADA;}
{numero}    { yylval.num = atof(yytext); return NUM; }
{especial} {yylval.especial = strdup(yytext); return ESPECIAL; }
{propriedade_isof} {yylval.propriedade_isof = strdup(yytext); return PROPRIEDADE_ISOF;}
{propriedade_has} {yylval.propriedade_has = strdup(yytext); return PROPRIEDADE_HAS;}
{propriedade} {yylval.propriedade = strdup(yytext); return PROPRIEDADE;}
{tipoDado} {yylval.tipoDado = strdup(yytext); return TIPODADO;}
{classe}   { yylval.classe = strdup(yytext); return CLASSE; }
{individuo} { yylval.individuo = strdup(yytext); return INDIVIDUO; }

%%
