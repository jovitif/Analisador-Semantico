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