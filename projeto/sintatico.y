%{
#include <iostream>
#include <cctype>
using namespace std;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

%}

%token DIGIT
%token ALPHA

%%

calc: 	expr '\n'		{ cout << $1 << endl; }
	| 	calc expr '\n' 	{ cout << $2 << endl; }	
	;

expr: 	expr '+' term	{ $$ = $1 + $3; }
	| 	term
	;

term:	term '*' fact	{ $$ = $1 * $3, cout << "realizando multiplicação!!!!\n"; }
	|	fact
	;

fact:	'(' expr ')'	{ $$ = $2;}
	|	DIGIT			{cout << "DIGITO\n";}
	|	ALPHA			{cout << "ALFABETO\n", $$=$1;}
	;

%%

int yylex() 
{
	char ch;
	ch = cin.get();

    if (isdigit(ch))
	{
		yylval = ch - '0';
		return DIGIT;
	}else if(isalpha(ch)){
		return ALPHA;
	}

	return ch;
}

void yyerror(const char * s)
{
   	cout << "ERRO: " << s << endl;
}

int main()
{
	yyparse();
}