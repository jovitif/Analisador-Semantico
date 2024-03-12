%{ 
#include "sintatico.tab.h"
extern double variables[26];
%}

%option yylineno
%option noyywrap

numero  [0-9]+("."[0-9]+)?
var     [a-z]
classe [A-Z][a-zA-Z_]
individuo [A-Z][a-zA-Z0-9_]*[0-9]+
eol  \n
reservada (some|all|value|min|max|exactly|that|not|and|only|or|Class:|EquivalentTo:|Individuals:|SubClassOf:|DisjointClasses:)
equivalentTo (EquivalentTo:)
especial ("{"|"}"|"("|")"|"["|"]"|","|"<"|">"|"=")
propriedade  [a-z][A-Za-z0-9]*
tipoDado (owl|rdfs|xsd):[A-Za-z0-9_]+
cardinalidade [0-9]+

%%

[\t ]+		{ ; /* ignora espaços em branco */ }
{numero}    { yylval.num = atof(yytext); return NUM; }
{var}		{ yylval.ind = yytext[0] - 'a'; return VAR; }
{reservada} { yylval.reservada = strdup(yytext); return RESERVADA; }
{individuo} { yylval.individuo = strdup(yytext); return INDIVIDUO; }
{classe}   { yylval.classe = strdup(yytext); return CLASSE; }
{equivalentTo} { yylval.equivalentTo = strdup(yytext); return EQUIVALENT;} 
.|\n		{ return yytext[0]; }

%%
