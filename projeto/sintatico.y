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
	char *individuals;
	char *individuo;
	char *only;
	char *or;
	char *reservada;
	char *equivalentTo;
	char *subclassof;
	char *disjointclasses;
	char *classe_reservada;
	char *especial;
	char *propriedade;
	char *propriedade_isof;
	char *tipoDado;
	char *propriedade_has;
	char *abrePar;
	char *fechaPar;
	char *abreChave;
	char *fechaChave;

}

%token <classe> CLASSE 
%token <classe_reservada> CLASSE_RESERVADA 
%token <propriedade> PROPRIEDADE 
%token <propriedade_isof> PROPRIEDADE_ISOF 
%token <propriedade_has> PROPRIEDADE_HAS 
%token <tipoDado> TIPODADO 
%token <num> NUM 
%token <individuo> INDIVIDUO 
%token <only> ONLY
%token <or> OR
%token <individuals> INDIVIDUALS_RESERVADA 
%token <reservada> RESERVADA 
%token <equivalentTo> EQUIVALENT_RESERVADA 
%token <subclassof> SUBCLASSOF_RESERVADA 
%token <disjointclasses> DISJOINTCLASSES_RESERVADA 
%token <especial> ESPECIAL
%token <abrePar> abrePar
%token <fechaPar> fechaPar 
%token <ind> VAR
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
instrucao: classe_primitiva { cout << "uma classe primitiva\n";}
			| classe_coberta { cout << "uma classe coberta\n";}
			| classe_enumerada { cout << "uma classe enumerada\n";}
			| classe_definida {cout << "uma classe definida\n";};


classe_primitiva: classe subclassof | classe subclassof disjointclasses | classe subclassof individuos | classe subclassof disjointclasses individuos;

classe_coberta: classe coberta;

classe_enumerada: classe enumerada;

classe_definida: classe equivalentto individuos | classe equivalentto;

equivalentto: EQUIVALENT_RESERVADA CLASSE RESERVADA ESPECIAL PROPRIEDADE_HAS RESERVADA CLASSE ESPECIAL
			| EQUIVALENT_RESERVADA CLASSE RESERVADA ESPECIAL PROPRIEDADE_HAS RESERVADA TIPODADO ESPECIAL ESPECIAL NUM ESPECIAL ESPECIAL;

enumerada: EQUIVALENT_RESERVADA ESPECIAL enumerada_lista;

enumerada_lista: CLASSE ESPECIAL enumerada_lista | CLASSE ESPECIAL ;

coberta:  EQUIVALENT_RESERVADA coberta_lista;

coberta_lista: CLASSE RESERVADA coberta_lista | CLASSE;

classe: CLASSE_RESERVADA CLASSE;

subclassof: SUBCLASSOF_RESERVADA subclassof_lista;

subclassof_lista: propriedade RESERVADA CLASSE ESPECIAL subclassof_lista | propriedade RESERVADA TIPODADO ESPECIAL subclassof_lista |  propriedade RESERVADA CLASSE 
			|  propriedade RESERVADA TIPODADO |CLASSE ESPECIAL subclassof_lista| propriedade ONLY CLASSE {cout << "axioma de fechamento";} | propriedade ONLY CLASSE ESPECIAL subclassof_lista {cout << "axioma de fechamento";}
			| propriedade abrePar PROPRIEDADE_HAS RESERVADA abrePar PROPRIEDADE_HAS RESERVADA CLASSE fechaPar fechaPar {cout << "aninhada";};

disjointclasses: DISJOINTCLASSES_RESERVADA disjointclasses_lista

disjointclasses_lista: disjointclasses_lista ESPECIAL CLASSE | CLASSE;

individuos: INDIVIDUALS_RESERVADA individuos_lista;

individuos_lista: individuos_lista ESPECIAL INDIVIDUO | INDIVIDUO;

propriedade: PROPRIEDADE | PROPRIEDADE_ISOF | PROPRIEDADE_HAS;


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
