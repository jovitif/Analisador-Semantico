%{
#include <iostream>
#include <stdio.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>
using std::cout;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_RESET   "\x1b[0m"

/* cada letra do alfabeto é uma variável */
double variables[26];

%}

%union {
	double num;
	int ind;
}

%token CLASSE 
%token CLASSE_RESERVADA 
%token PROPRIEDADE 
%token PROPRIEDADE_ISOF 
%token PROPRIEDADE_HAS 
%token TIPODADO 
%token NUM 
%token INDIVIDUO 
%token ONLY_RESERVADA
%token OR_RESERVADA
%token SOME_RESERVADA
%token ALL_RESERVADA 
%token VALUE_RESERVADA
%token MIN_RESERVADA 
%token MAX_RESERVADA 
%token EXACTLY_RESERVADA 
%token THAT_RESERVADA
%token NOT_RESERVADA 
%token AND_RESERVADA 
%token INDIVIDUALS_RESERVADA 
%token EQUIVALENT_RESERVADA 
%token SUBCLASSOF_RESERVADA 
%token DISJOINTCLASSES_RESERVADA 
%token ABREPAR
%token FECHAPAR
%token ABRECHAVE
%token FECHACHAVE
%token ABRECOLCHETE
%token FECHACOLCHETE
%token VIRGULA
%token RELOP
%token VAR


%%
classe:   classe_primitiva| classe_primitiva classe { cout << "uma classe primitiva\n";}
			| classe_coberta| classe_coberta classe { cout << "uma classe coberta\n";}
			| classe_enumerada| classe_enumerada classe { cout << "uma classe enumerada\n";}
			| classe_definida| classe_definida classe {cout << "uma classe definida\n";};


classe_primitiva: CLASSE_RESERVADA CLASSE subclassof disjointclasses individuos;

classe_coberta: CLASSE_RESERVADA CLASSE coberta|CLASSE_RESERVADA CLASSE coberta individuos;

coberta:  EQUIVALENT_RESERVADA coberta_lista;

coberta_lista: CLASSE OR_RESERVADA coberta_lista|CLASSE;

classe_enumerada: CLASSE_RESERVADA CLASSE enumerada;

enumerada: EQUIVALENT_RESERVADA ABRECHAVE enumerada_lista FECHACHAVE;
enumerada_lista: CLASSE VIRGULA enumerada_lista | CLASSE;

classe_definida: CLASSE_RESERVADA CLASSE equivalentto disjointclasses individuos;


subclassof: SUBCLASSOF_RESERVADA definicao
equivalentto: EQUIVALENT_RESERVADA definicao

definicao: CLASSE 
			| propriedade reservada CLASSE virgula
			| propriedade reservada TIPODADO virgula
			| CLASSE AND_RESERVADA parenteses virgula
			| CLASSE AND_RESERVADA parenteses definicao virgula
			| AND_RESERVADA parenteses virgula
			| AND_RESERVADA parenteses definicao virgula
			| CLASSE VIRGULA definicao virgula
			| propriedade ONLY_RESERVADA CLASSE virgula {cout << "axioma de fechamento";}
			| propriedade ONLY_RESERVADA parenteses virgula {cout << "axioma de fechamento";}
			| propriedade quantificador NUM CLASSE virgula
			| propriedade quantificador NUM TIPODADO virgula
			| propriedade reservada TIPODADO ABRECOLCHETE RELOP NUM FECHACOLCHETE virgula

parenteses: ABREPAR conteudo FECHAPAR;
conteudo: definicao |propriedade reservada parenteses {cout << "aninhada ";};	


reservada: SOME_RESERVADA | VALUE_RESERVADA| ALL_RESERVADA

disjointclasses: DISJOINTCLASSES_RESERVADA disjointclasses_lista| ;

disjointclasses_lista: disjointclasses_lista VIRGULA CLASSE | CLASSE;

individuos: INDIVIDUALS_RESERVADA individuos_lista | ; 

individuos_lista: individuos_lista VIRGULA INDIVIDUO | INDIVIDUO;

propriedade: PROPRIEDADE | PROPRIEDADE_ISOF | PROPRIEDADE_HAS;

quantificador: MIN_RESERVADA| MAX_RESERVADA|EXACTLY_RESERVADA;

virgula: VIRGULA| ;


%%

extern FILE * yyin;  
int main(int argc, char ** argv)
{
    if (argc > 1)
    {
        FILE * file;
        file = fopen(argv[1], "r");
        if (!file)
        {
            std::cout << "Arquivo " << argv[1] << " não encontrado!\n";
            exit(1);
        }
        yyin = file;

	}

	 yyparse();

}

void yyerror(const char * s)
{
	extern int yylineno;    

	extern char * yytext;   
    std::cout << ANSI_COLOR_YELLOW << "Erro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
}