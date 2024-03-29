%{
#include <iostream>
#include <stdio.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>
using namespace std;


int yylex(void);
int yyparse(void);
void yyerror(const char *);
extern int yylineno;  

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_RESET   "\x1b[0m"

/* cada letra do alfabeto é uma variável */
double variables[26];

int qntClasses = 0;
int qntDefinida = 0;
int qntPrimitiva = 0;
int qntEnumerada = 0;
int qntCoberta = 0;
int qntAxiomaDeFechamento = 0;
int qntAninhada = 0;
int qntEspecial = 0;
bool aninhada = false;
bool fechamento =false;
int linhaAtual = 0;

void saida(string saida){
	cout << "linha " << linhaAtual << ": ";  linhaAtual = yylineno;
	cout << saida;
 	if(aninhada == true){
		cout << "com aninhamento "; 
		aninhada =false;
	}

	if(fechamento == true){
		cout << "com axioma de fechamento ";
		fechamento = false;
	}
	cout << endl;
}
%}



%token CLASSE CLASSE_RESERVADA PROPRIEDADE PROPRIEDADE_ISOF PROPRIEDADE_HAS TIPODADO NUM INDIVIDUO ONLY_RESERVADA OR_RESERVADA SOME_RESERVADA ALL_RESERVADA 
%token VALUE_RESERVADA MIN_RESERVADA MAX_RESERVADA EXACTLY_RESERVADA THAT_RESERVADA NOT_RESERVADA AND_RESERVADA INDIVIDUALS_RESERVADA EQUIVALENT_RESERVADA SUBCLASSOF_RESERVADA 
%token DISJOINTCLASSES_RESERVADA ABREPAR FECHAPAR ABRECHAVE FECHACHAVE ABRECOLCHETE FECHACOLCHETE VIRGULA op VAR


%%

classe:  classe classe_primitiva { saida("uma classe primitiva ");   qntClasses++; qntPrimitiva++;}
			| classe  classe_coberta { saida("uma classe coberta "); qntClasses++; qntCoberta++;}
			| classe  classe_enumerada  { saida("uma classe enumerada "); qntClasses++; qntEnumerada++;}
			| classe classe_definida {saida("uma classe definida "); qntClasses++; qntDefinida++;}
			| classe classe_especial {saida("uma classe especial "); qntClasses++;qntEspecial++;}
			| error classe             
    		| 
    		;


classe_primitiva: CLASSE_RESERVADA CLASSE subclassof disjointclasses individuos;

classe_coberta: CLASSE_RESERVADA CLASSE coberta
			|CLASSE_RESERVADA CLASSE coberta individuos;

coberta:  EQUIVALENT_RESERVADA coberta_lista;

coberta_lista: CLASSE OR_RESERVADA coberta_lista 
			|CLASSE;

classe_enumerada: CLASSE_RESERVADA CLASSE enumerada;

enumerada: EQUIVALENT_RESERVADA ABRECHAVE enumerada_lista FECHACHAVE;

enumerada_lista: CLASSE VIRGULA enumerada_lista 
			| CLASSE;

classe_definida: CLASSE_RESERVADA CLASSE equivalentto disjointclasses individuos;

classe_especial: CLASSE_RESERVADA CLASSE disjointclasses
			| CLASSE_RESERVADA CLASSE equivalentto subclassof disjointclasses individuos;

subclassof: SUBCLASSOF_RESERVADA definicao ;

equivalentto: EQUIVALENT_RESERVADA definicao;

definicao: CLASSE virgula definicao
			| propriedade reservada CLASSE virgula definicao 
			| propriedade reservada TIPODADO virgula definicao
			| CLASSE and;
			| parenteses and;
			| fechamento {qntAxiomaDeFechamento++; fechamento = true;}
			| parenteses definicao
			| propriedade quantificador NUM CLASSE virgula definicao
			| propriedade quantificador NUM TIPODADO virgula definicao
			| propriedade reservada TIPODADO ABRECOLCHETE op NUM FECHACOLCHETE virgula definicao
			| CLASSE OR_RESERVADA definicao
			| ;

and: AND_RESERVADA parenteses virgula definicao and
			| AND_RESERVADA definicao and|;

parenteses: ABREPAR conteudo FECHAPAR;

conteudo: definicao 
			|propriedade reservada parenteses { qntAninhada++; aninhada = true;};



fechamento:  propriedade ONLY_RESERVADA CLASSE virgula definicao 
			| propriedade ONLY_RESERVADA parenteses virgula definicao 


reservada: SOME_RESERVADA 
			| VALUE_RESERVADA
			| ALL_RESERVADA;

disjointclasses: DISJOINTCLASSES_RESERVADA disjointclasses_lista 
			| ;

disjointclasses_lista:   CLASSE VIRGULA disjointclasses_lista
			| CLASSE;

individuos: INDIVIDUALS_RESERVADA individuos_lista 
			| ; 

individuos_lista: individuos_lista VIRGULA INDIVIDUO 
			| INDIVIDUO;

propriedade: PROPRIEDADE 
			| PROPRIEDADE_ISOF 
			| PROPRIEDADE_HAS
			| PROPRIEDADE PROPRIEDADE
			| ;

quantificador: MIN_RESERVADA
			| MAX_RESERVADA
			|EXACTLY_RESERVADA;

virgula: VIRGULA
			| ;


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
	cout << "\nQuantidade de classes primitivas: " << qntPrimitiva << "\n";
	cout << "\nQuantidade de classes definidas: " << qntDefinida << "\n";
	cout << "\nQuantidade de classes enumeradas: " << qntEnumerada << "\n";
	cout << "\nQuantidade de classes cobertas: " << qntCoberta << "\n";
	cout << "\nQuantidade de axiomas de fechamento: " << qntAxiomaDeFechamento << "\n"; 
	cout << "\nQuantidade de aninhadas: " << qntAninhada << "\n"; 
	cout << "\nQuantidade de especiais: " << qntEspecial << "\n";     
}

void yyerror(const char * s)
{
    extern char * yytext;   
    cout << ANSI_COLOR_YELLOW << "\nErro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";

}
