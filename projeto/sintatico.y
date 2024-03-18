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

int main()
{
	yyparse();
}

void yyerror(const char * s)
{
	/* variáveis definidas no analisador léxico */
	extern int yylineno;    
	extern char * yytext;   
	
	/* mensagem de erro exibe o símbolo que causou erro e o número da linha */
    cout << "Erro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
}
