%{
#include <iostream>
#include <stdio.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <regex>
using namespace std;


int yylex(void);
int yyparse(void);
void yyerror(const char *);
extern int yylineno;  

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_RESET   "\x1b[0m"
#define ANSI_COLOR_BLUE    "\x1b[34m" 

/* cada letra do alfabeto é uma variável */


double variables[26];
extern char * yytext;   
extern string classeAtual;
extern string propriedadeAtual;
extern string tipoDadoAtual;
extern string intervaloAtual;
extern string numAtual;
extern string quantificadorAtual;
extern string nomeClasseAtual;
char isPropriedade[10];
int precedencia = 0;
bool PrecedenciaFechamento = false;
int qntClasses = 0;
int qntDefinida = 0;
int qntPrimitiva = 0;
int qntEnumerada = 0;
int qntCoberta = 0;
int qntAxiomaDeFechamento = 0;
int qntAninhada = 0;
int qntEspecial = 0;
char sobrecarregamento[50];
bool semanticError = false;
bool aninhada = false;
bool fechamento =false;
bool colchete = false;
int linhaAtual = 0;
int erros = 0;


void saida(string saida){
	
	linhaAtual = yylineno;
	cout << saida;
 	if(aninhada == true){
		cout << "com aninhamento "; 
		aninhada =false;
	}

	if(fechamento == true){
		cout << "com axioma de fechamento ";
		fechamento = false;
	}
	cout << "\n|-----------------------------------------------------------------|";
	cout << endl;
}

string intervalo(string intervalo){
	
	const char * op = intervalo.c_str();
	
	if(strcmp(op, "<") == 0){
		return "menor que ";
	}
	else if(strcmp(op, ">") == 0 ){
		return "maior que ";
	}
	else if(strcmp(op, "<=") == 0){
		return "menor ou igual que ";
	}
	else if(strcmp(op,">=") == 0){
		return "maior ou igual que ";
	}
	else if(strcmp(op, "=") == 0){
		return "igual que ";
	}
	else{
		return "diferente que ";
	}
	return " ";
}

string operador(string operador){
	const char * op = operador.c_str();
	if(strcmp(op, "min") == 0){
		return "no minimo ";
	}
	else if(strcmp(op, "max") == 0){
		return "no maximo";
	}
	else if(strcmp(op,"exactly") == 0){
		return  "exatamente";
	}
	return " ";
}
%}







%token CLASSE CLASSE_RESERVADA PROPRIEDADE PROPRIEDADE_HAS  PROPRIEDADE_ISOF TIPODADO NUM INDIVIDUO ONLY_RESERVADA OR_RESERVADA SOME_RESERVADA ALL_RESERVADA 
%token VALUE_RESERVADA MIN_RESERVADA MAX_RESERVADA EXACTLY_RESERVADA THAT_RESERVADA NOT_RESERVADA AND_RESERVADA INDIVIDUALS_RESERVADA EQUIVALENT_RESERVADA SUBCLASSOF_RESERVADA 
%token DISJOINTCLASSES_RESERVADA ABREPAR FECHAPAR ABRECHAVE FECHACHAVE ABRECOLCHETE FECHACOLCHETE VIRGULA op VAR


%%



classe:  classe   classe_primitiva { saida("| uma classe primitiva|");   qntClasses++; qntPrimitiva++;}
			| classe  classe_coberta {saida("| uma classe coberta|");  qntClasses++; qntCoberta++;}
			| classe  classe_enumerada  {saida( "| uma classe enumerada|")  ;qntClasses++; qntEnumerada++;}
			| classe  classe_definida {saida("| uma classe definida|");  qntClasses++; qntDefinida++;}
			| classe classe_especial {saida("| uma classe especial|");  qntClasses++;qntEspecial++;}
			| error classe             
    		| 
    		;


classe_primitiva: classe_id  subclassof   disjointclasses individuos;

classe_coberta: classe_id  coberta
			| classe_id  coberta individuos;

coberta:  EQUIVALENT_RESERVADA coberta_lista;

coberta_lista: CLASSE OR_RESERVADA coberta_lista 
			|CLASSE;

classe_enumerada: classe_id  enumerada;

enumerada: EQUIVALENT_RESERVADA ABRECHAVE enumerada_lista FECHACHAVE;

enumerada_lista: CLASSE VIRGULA enumerada_lista 
			| CLASSE;

classe_definida: classe_id equivalentto  disjointclasses  individuos;

classe_especial: classe_id   disjointclasses
				| classe_id  equivalentto  subclassof  disjointclasses  individuos;

classe_id: {cout << "|linha " << linhaAtual << " | " << classeAtual << " | " << endl; }  CLASSE_RESERVADA  {precedencia = 1;};

subclassof:  SUBCLASSOF_RESERVADA  {precedencia = 3;} definicao  

equivalentto:  EQUIVALENT_RESERVADA   definicao {precedencia = 2;}

definicao: CLASSE virgula definicao
			| propriedade reservada CLASSE {  cout << ANSI_COLOR_BLUE << "|sobrecarga do tipo (object property) " << propriedadeAtual << " na linha " << yylineno << ANSI_COLOR_RESET << "|" << endl; strcpy(isPropriedade, " "); } virgula definicao 
			| propriedade reservada TIPODADO { cout << ANSI_COLOR_BLUE << "|sobrecarga do tipo (data property) " << propriedadeAtual << " na linha " << yylineno << ANSI_COLOR_RESET << "|" << endl; strcpy(isPropriedade, " "); } virgula definicao 
			| CLASSE and;
			| parenteses and;
			| fechamento {qntAxiomaDeFechamento++; fechamento = true; PrecedenciaFechamento = true;} 
			| parenteses definicao
			| definicaoQuantificador
			| propriedade reservada TIPODADO ABRECOLCHETE {colchete = true;} op NUM FECHACOLCHETE {colchete = false; cout << ANSI_COLOR_BLUE << "|propriedade: " << propriedadeAtual << " na linha " << yylineno << " é do tipo: " << tipoDadoAtual << " e precisa ser " << intervalo(intervaloAtual) <<  numAtual  << ANSI_COLOR_RESET << "|" << endl; strcpy(isPropriedade, " "); numAtual = " "; intervaloAtual = " ";} virgula definicao 
			| CLASSE OR_RESERVADA definicao
			| ;

and: AND_RESERVADA parenteses virgula definicao and
			| AND_RESERVADA definicao and|;

parenteses: ABREPAR conteudo FECHAPAR;

conteudo: definicao 
			|propriedade reservada parenteses { qntAninhada++; aninhada = true;};



fechamento:  propriedade ONLY_RESERVADA CLASSE   
			| propriedade ONLY_RESERVADA parenteses  
			| propriedade ONLY_RESERVADA CLASSE virgula definicaoQuantificador


definicaoQuantificador: | propriedade quantificador NUM CLASSE virgula definicao { cout << ANSI_COLOR_BLUE <<"|propriedade: " << propriedadeAtual << " na linha " << yylineno << " precisa ter " << operador(quantificadorAtual) << " " << numAtual << " " << nomeClasseAtual << ANSI_COLOR_RESET << "|" << endl; numAtual = " "; quantificadorAtual = " ";}
						| propriedade quantificador NUM TIPODADO virgula definicao { cout << ANSI_COLOR_BLUE <<"|propriedade: " << propriedadeAtual << " na linha " << yylineno << " precisa ter " << operador(quantificadorAtual) << " " << numAtual << " " << tipoDadoAtual << ANSI_COLOR_RESET << "|" << endl; numAtual = " "; quantificadorAtual = " "; }
reservada: SOME_RESERVADA {strcpy(isPropriedade, yytext); }
			| VALUE_RESERVADA {strcpy(isPropriedade, yytext); }
			| ALL_RESERVADA {strcpy(isPropriedade, yytext); };

disjointclasses: DISJOINTCLASSES_RESERVADA  disjointclasses_lista {precedencia = 4;}
			| ;

disjointclasses_lista:   CLASSE VIRGULA disjointclasses_lista
			| CLASSE;

individuos: INDIVIDUALS_RESERVADA   individuos_lista  {precedencia = 0;}
			| ; 

individuos_lista: individuos_lista VIRGULA INDIVIDUO 
			| INDIVIDUO;

propriedade: PROPRIEDADE 
			| PROPRIEDADE_ISOF 
			| PROPRIEDADE_HAS 
			| PROPRIEDADE PROPRIEDADE ;

quantificador: MIN_RESERVADA
			| MAX_RESERVADA
			| EXACTLY_RESERVADA;

virgula: VIRGULA
			| ;


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
	cout << "\nRealizando analise semantica...\n\n";
	 yyparse();
	cout << "\nCONTAGEM DE CLASSES E ERROS\n";
	cout << "\n|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de classes| " << qntClasses << "\n"; 
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de classes primitivas| " << qntPrimitiva << "\n";
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de classes definidas| " << qntDefinida << "\n";
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de classes enumeradas| " << qntEnumerada << "\n";
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de classes cobertas| " << qntCoberta << "\n";
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de axiomas de fechamento| " << qntAxiomaDeFechamento << "\n";
	cout << "|-----------------------------------------------------------------|"; 
	cout << "\n|Quantidade de aninhadas| " << qntAninhada << "\n"; 
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de especiais| " << qntEspecial << "\n";   
	cout << "|-----------------------------------------------------------------|";
	cout << "\n|Quantidade de erros|" << erros << "\n";  
	cout << "|-----------------------------------------------------------------|\n";
}

void syntax(const char *s){
	if(  strcmp(isPropriedade,"some") == 0  && colchete == false   ||strcmp(isPropriedade,"value") == 0 || strcmp(isPropriedade,"all") == 0 ){
		cout << ANSI_COLOR_YELLOW  << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: ser classe ou tipo de dado depois do "<< isPropriedade <<   "(linha " << yylineno << ")";
		cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
		strcpy(isPropriedade, " ");
	}else if(colchete == true && numAtual == " " || colchete == true &&  intervaloAtual == " " || colchete == true && numAtual == " " && intervaloAtual == " ") {
		cout << ANSI_COLOR_YELLOW  << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: é necessário informar um intervalo depois do "<< isPropriedade <<   "(linha " << yylineno << ")";
		cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
		numAtual = " ";
		intervaloAtual = " ";
	}
	else if(quantificadorAtual != " " && numAtual == " " && colchete == false ){
		cout << ANSI_COLOR_YELLOW  << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: é necessário informar um numero depois do  "<< quantificadorAtual <<   "(linha " << yylineno << ")";
		cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
		quantificadorAtual = " ";
	}
	else{
		cout << ANSI_COLOR_RED  << "|linha " << yylineno << ": " << classeAtual << "  Erro (" << s << "): motivo: \"" << yytext << "\" (linha " << yylineno << ")";
		cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
	}
}

void yyerror(const char * s)
{
	erros++;
	if(PrecedenciaFechamento){
		PrecedenciaFechamento = false;
		regex propriedade("[a-z][A-Za-z]*");
			if(regex_match(yytext,propriedade)){
				cout << ANSI_COLOR_YELLOW << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: axiomas de fechamento só podem aparecer depois de declarações existenciais de propriedades" <<   "(linha " << yylineno << ")";
				cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
			}
			else{
				syntax(s);
			}
	}
	else{
		switch (precedencia){
				case 0:
					if(strcmp(yytext,"EquivalentTo:") == 0 || strcmp(yytext,"SubClassOf:") == 0 || strcmp(yytext,"DisjointClasses:") == 0 || strcmp(yytext,"Individuals:") == 0){
						cout << ANSI_COLOR_YELLOW  << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: deveria ser class: em vez de "<< yytext <<   "(linha " << yylineno << ")";
						cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
					}
					else{
						syntax(s);
					}
					break;
				case 1:
					
					if(strcmp(yytext,"Class:") == 0 || strcmp(yytext,"SubClassOf:") == 0 || strcmp(yytext,"DisjointClasses:") == 0 || strcmp(yytext,"Individuals:") == 0){
						cout << ANSI_COLOR_YELLOW   << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: deveria ser EquivalentTo: em vez de "<< yytext <<   "(linha " << yylineno << ")";
						cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
					}
					else{
						syntax(s);
					}
					break;
				case 2:
				
					if(strcmp(yytext,"Class:") == 0 || strcmp(yytext,"EquivalentTo:") == 0 || strcmp(yytext,"DisjointClasses:") == 0 || strcmp(yytext,"Individuals:") == 0){
							cout << ANSI_COLOR_YELLOW   << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: deveria ser SubClassOf: em vez de "<< yytext <<   "(linha " << yylineno << ")";
							cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
						}
						else{
							syntax(s);
						}
						break;
				case 3:
					if(strcmp(yytext,"Class:") == 0 || strcmp(yytext,"EquivalentTo:") == 0 || strcmp(yytext,"SubClassOf:") == 0 || strcmp(yytext,"Individuals:") == 0){
						cout << ANSI_COLOR_YELLOW   << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: deveria ser DisjointClasses: em vez de "<< yytext <<   "(linha " << yylineno << ")";
						cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
					}
					else{
						syntax(s);
					}
					break;
				case 4:
				
					if(strcmp(yytext,"Class:") == 0 || strcmp(yytext,"EquivalentTo:") == 0 || strcmp(yytext,"SubClassOf:") == 0 || strcmp(yytext,"DisjointClasses:") == 0){
						cout << ANSI_COLOR_YELLOW   << "|linha " << yylineno << ": " << classeAtual << "  Erro( semantic error ): motivo: deveria ser Individuals: em vez de "<< yytext <<   "(linha " << yylineno << ")";
						cout << ANSI_COLOR_RESET << "\n|-----------------------------------------------------------------|\n";
					}
					else{
						syntax(s);
					}
					break;
			
		}
	}
	
	

}
