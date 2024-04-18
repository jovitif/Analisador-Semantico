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
string tipoDadoAtual;
string intervaloAtual;
string numAtual; 
string quantificadorAtual;
string nomeClasseAtual;
%}


%option yylineno
%option noyywrap

numero  [0-9]+("."[0-9]+)?
individuo [A-Z][a-zA-Z0-9_]*[0-9]+
propriedade  [a-z][A-Za-z]*
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
min  {quantificadorAtual = yytext; return MIN_RESERVADA;}
max  {quantificadorAtual = yytext; return MAX_RESERVADA;}
exactly { quantificadorAtual = yytext; return EXACTLY_RESERVADA;}
that return THAT_RESERVADA;
not  return NOT_RESERVADA;
and  return AND_RESERVADA;
{inicioClasse}  { classeAtual = yytext;   return CLASSE_RESERVADA;}
EquivalentTo: return EQUIVALENT_RESERVADA;
Individuals:  return INDIVIDUALS_RESERVADA;
SubClassOf:  return SUBCLASSOF_RESERVADA;
DisjointClasses:  return DISJOINTCLASSES_RESERVADA;
"(" return ABREPAR; 
")" return FECHAPAR;
"{" return ABRECHAVE;
"}" return FECHACHAVE;
"["  return ABRECOLCHETE;
"]" return FECHACOLCHETE;
"," return VIRGULA;
"<" { intervaloAtual = yytext; return op;}
">" { intervaloAtual = yytext; return op;}
"=" { intervaloAtual = yytext; return op;}
">=" { intervaloAtual = yytext; return op;}
"<=" { intervaloAtual = yytext; return op;}
"<>" { intervaloAtual = yytext; return op;}
{numero}  { numAtual = yytext; return NUM;} 
{propriedade_isof}  { propriedadeAtual = yytext; return PROPRIEDADE_ISOF;}
{propriedade_has}  { propriedadeAtual = yytext; return PROPRIEDADE_HAS;}
{propriedade} { propriedadeAtual = yytext; return PROPRIEDADE;}
{tipoDado} { tipoDadoAtual = yytext; return TIPODADO;}
{classe} {nomeClasseAtual = yytext; return CLASSE;} 
{individuo} return INDIVIDUO; 

%%