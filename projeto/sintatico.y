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
}

%token <ind> VAR
%token <num> NUM
%token <classe> CLASSE
%token <individuo> INDIVIDUO
%token <reservada> RESERVADA
%token <equivalentTo> EQUIVALENT
%token <subClassOf> SUBCLASSOF

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
individuals: RESERVADA individuo {cout << "individuos \n";}
	;
individuo : INDIVIDUO individuo {cout << "teste \n";}
	| 		INDIVIDUO  {cout << "teste \n";}
	;

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
