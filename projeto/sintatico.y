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
	char *only_reservada;
	char *or_reservada;
	char *some_reservada;
	char *all_reservada;
	char *value_reservada;
	char *min_reservada;
	char *max_reservada;
	char *exactly_reservada;
	char *that_reservada;
	char *not_reservada;
	char *and_reservada;
	char *equivalentTo;
	char *subclassof;
	char *disjointclasses;
	char *classe_reservada;
	char *propriedade;
	char *propriedade_isof;
	char *tipoDado;
	char *propriedade_has;
	char *abrePar;
	char *fechaPar;
	char *abreChave;
	char *fechaChave;
	char *abreColchete;
	char *fechaColchete;
	char *virgula;
	char *relop;
}

%token <classe> CLASSE 
%token <classe_reservada> CLASSE_RESERVADA 
%token <propriedade> PROPRIEDADE 
%token <propriedade_isof> PROPRIEDADE_ISOF 
%token <propriedade_has> PROPRIEDADE_HAS 
%token <tipoDado> TIPODADO 
%token <num> NUM 
%token <individuo> INDIVIDUO 
%token <only_reservada> ONLY_RESERVADA
%token <or_reservada> OR_RESERVADA
%token <some_reservada> SOME_RESERVADA
%token <all_reservada> ALL_RESERVADA 
%token <value_reservada> VALUE_RESERVADA
%token <min_reservada> MIN_RESERVADA 
%token <max_reservada> MAX_RESERVADA 
%token <exactly_reservada> EXACTLY_RESERVADA 
%token <that_reservada> THAT_RESERVADA
%token <not_reservada> NOT_RESERVADA 
%token <and_reservada> AND_RESERVADA 
%token <individuals> INDIVIDUALS_RESERVADA 
%token <equivalentTo> EQUIVALENT_RESERVADA 
%token <subclassof> SUBCLASSOF_RESERVADA 
%token <disjointclasses> DISJOINTCLASSES_RESERVADA 
%token <abrePar> ABREPAR
%token <fechaPar> FECHAPAR
%token <abreChave> ABRECHAVE
%token <fechaChave> FECHACHAVE
%token <abreColchete> ABRECOLCHETE
%token <fechaColchete> FECHACOLCHETE
%token <virgula> VIRGULA
%token <relop> RELOP
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

enumerada: EQUIVALENT_RESERVADA ABRECHAVE enumerada_lista FECHACHAVE;

enumerada_lista: CLASSE VIRGULA enumerada_lista | CLASSE;

coberta:  EQUIVALENT_RESERVADA coberta_lista;

coberta_lista: CLASSE OR_RESERVADA coberta_lista | CLASSE;

classe: CLASSE_RESERVADA CLASSE;

subclassof: SUBCLASSOF_RESERVADA subclassof_lista;

subclassof_lista: propriedade RESERVADA CLASSE ESPECIAL subclassof_lista | propriedade RESERVADA TIPODADO ESPECIAL subclassof_lista |  propriedade RESERVADA CLASSE 
			|  propriedade RESERVADA TIPODADO |CLASSE ESPECIAL subclassof_lista| propriedade ONLY_RESERVADA CLASSE {cout << "axioma de fechamento ";} | propriedade ONLY_RESERVADA CLASSE ESPECIAL subclassof_lista {cout << "axioma de fechamento";}
			| propriedade ABREPAR PROPRIEDADE_HAS RESERVADA ABREPAR PROPRIEDADE_HAS RESERVADA CLASSE FECHAPAR FECHAPAR {cout << "aninhada";};

disjointclasses: DISJOINTCLASSES_RESERVADA disjointclasses_lista

disjointclasses_lista: disjointclasses_lista VIRGULA CLASSE | CLASSE;

individuos: INDIVIDUALS_RESERVADA individuos_lista;

individuos_lista: individuos_lista VIRGULA INDIVIDUO | INDIVIDUO;

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
