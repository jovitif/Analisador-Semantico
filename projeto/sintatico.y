%{
/* analisador sintático para uma calculadora básica */
#include <iostream>
using std::cout;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

/* cada letra do alfabeto é uma variável */
double variables[26];
%}

%union {
	double num;
	int ind;
	char *classe;
	char *individuo;
	char *reservada;
	char *equivalentTo;
	char *subClassOf;
	char *classe_reservada;
	char *especial;
}

%token <ind> VAR
%token <num> NUM
%token <classe> CLASSE
%token <classe_reservada> CLASSE_RESERVADA
%token <individuo> INDIVIDUO
%token <reservada> RESERVADA
%token <equivalentTo> EQUIVALENT
%token <subClassOf> SUBCLASSOF
%token <especial> ESPECIAL

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
instrucao: individuals | coberta;
individuals: RESERVADA individuo {cout << "individuos \n";}
	;
individuo : INDIVIDUO individuo {cout << "teste \n";}
	| 		INDIVIDUO  {cout << "teste \n";}
	;
//primitiva:
//definida:
//fechamento:
//aninhada:
//enumerada:
coberta: CLASSE_RESERVADA CLASSE RESERVADA coberta2 
coberta2:	CLASSE | CLASSE ESPECIAL | coberta2 {cout << "Classe coberta\n";};
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
			cout << "Arquivo " << argv[1] << " não encontrado!\n";
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
	cout << "Erro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
}
