%{ 
#include <iostream>
#include <cstdio>
#include <string>
#include "sintatico.tab.h"
using std::cout;
using std::cin;
using std::string;
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
{classe_reservada} return CLASSE_RESERVADA;
{equivalentTo}  return EQUIVALENT_RESERVADA;
{individuals} return INDIVIDUALS_RESERVADA;
{subclassof} return SUBCLASSOF_RESERVADA;
{disjointclasses}  return DISJOINTCLASSES_RESERVADA;
{numero}   return NUM; 
{propriedade_isof}  return PROPRIEDADE_ISOF;
{propriedade_has}  return PROPRIEDADE_HAS;
{propriedade} return PROPRIEDADE;
{tipoDado} return TIPODADO;
{classe}   return CLASSE; 
{individuo} return INDIVIDUO; 
"(" return ABREPAR; 
")" return FECHAPAR;
"{" return ABRECHAVE;
"}" return FECHACHAVE;
"["  return ABRECOLCHETE;
"]" return FECHACOLCHETE;
"," return VIRGULA;
"<" return RELOP;
">" return RELOP;
"=" return RELOP;

%%