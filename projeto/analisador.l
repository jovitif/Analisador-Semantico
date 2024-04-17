%{ 
#include <iostream>
#include <cstdio>
#include <string>
#include "sintatico.tab.h"
using std::cout;
using std::cin;
using std::string;

string classeAtual;
string propriedadeAtual;
%}

%option yylineno
%option noyywrap

numero  [0-9]+("."[0-9]+)?
individuo [A-Z][a-zA-Z0-9_]*[0-9]+
propriedade  [a-z][A-Za-z0-9]*
propriedade_has (has[A-Za-z]+)
propriedade_isof {propriedade}("is"[A-Z][a-zA-Z_]+"of")
classe [A-Z][a-zA-Z_]+
tipoDado (owl|rdfs|xsd):[A-Za-z0-9_]+
inicioClasse "Class:"[[:space:]]+{classe}

%%
[ \t\n]+ ;
only  return ONLY_RESERVADA; 
or  return OR_RESERVADA; 
some return SOME_RESERVADA;
all   return ALL_RESERVADA;
value return VALUE_RESERVADA;
min  return MIN_RESERVADA;
max  return MAX_RESERVADA;
exactly return EXACTLY_RESERVADA;
that return THAT_RESERVADA;
not  return NOT_RESERVADA;
and  return AND_RESERVADA;
{inicioClasse}  { classeAtual = yytext;  return CLASSE_RESERVADA;}
EquivalentTo:  return EQUIVALENT_RESERVADA;
Individuals: return INDIVIDUALS_RESERVADA;
SubClassOf: return SUBCLASSOF_RESERVADA;
DisjointClasses: return DISJOINTCLASSES_RESERVADA;
"(" return ABREPAR; 
")" return FECHAPAR;
"{" return ABRECHAVE;
"}" return FECHACHAVE;
"["  return ABRECOLCHETE;
"]" return FECHACOLCHETE;
"," return VIRGULA;
"<" return op;
">" return op;
"=" return op;
">=" return op;
"<=" return op;
"<>" return op;
{numero}   return NUM; 
{propriedade_isof}  { propriedadeAtual = yytext; return PROPRIEDADE_ISOF;}
{propriedade_has}  { propriedadeAtual = yytext; return PROPRIEDADE_HAS;}
{propriedade} { propriedadeAtual = yytext; return PROPRIEDADE;}
{tipoDado} return TIPODADO;
{classe} return CLASSE; 
{individuo} return INDIVIDUO; 

%%