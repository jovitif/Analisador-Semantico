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

int qntClasses = 0;

%}

%union {
	double num;
	int ind;
}

%token CLASSE CLASSE_RESERVADA PROPRIEDADE PROPRIEDADE_ISOF PROPRIEDADE_HAS TIPODADO NUM INDIVIDUO ONLY_RESERVADA OR_RESERVADA SOME_RESERVADA ALL_RESERVADA 
%token VALUE_RESERVADA MIN_RESERVADA MAX_RESERVADA EXACTLY_RESERVADA THAT_RESERVADA NOT_RESERVADA AND_RESERVADA INDIVIDUALS_RESERVADA EQUIVALENT_RESERVADA SUBCLASSOF_RESERVADA 
%token DISJOINTCLASSES_RESERVADA ABREPAR FECHAPAR ABRECHAVE FECHACHAVE ABRECOLCHETE FECHACOLCHETE VIRGULA RELOP VAR


%%
classe:   classe_primitiva| classe_primitiva classe { cout << "uma classe primitiva\n"; qntClasses++;}
			| classe_coberta| classe_coberta classe { cout << "uma classe coberta\n"; qntClasses++;}
			| classe_enumerada| classe_enumerada classe { cout << "uma classe enumerada\n"; qntClasses++;}
			| classe_definida| classe_definida classe {cout << "uma classe definida\n"; qntClasses++;};


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
			| propriedade ONLY_RESERVADA CLASSE virgula {cout << "axioma de fechamento"; qntClasses++;}
			| propriedade ONLY_RESERVADA parenteses virgula {cout << "axioma de fechamento"; qntClasses++;}
			| propriedade quantificador NUM CLASSE virgula
			| propriedade quantificador NUM TIPODADO virgula
			| propriedade reservada TIPODADO ABRECOLCHETE RELOP NUM FECHACOLCHETE virgula

parenteses: ABREPAR conteudo FECHAPAR;
conteudo: definicao |propriedade reservada parenteses {cout << "aninhada ";qntClasses++;};	


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
	cout << "Realizando analise sintatica...\n\n";
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
	cout << "\nQuantidade de classes: " << qntClasses << "\n"; 

}

void yyerror(const char * s)
{
	extern int yylineno;    

	extern char * yytext;   
    std::cout << ANSI_COLOR_YELLOW << "\nErro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
	//cout << "\nQuantidade de classes: " + qntClasses;

}