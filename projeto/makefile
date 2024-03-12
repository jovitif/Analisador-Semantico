# Dependências
all: teste

# Compiladores
CPP=g++
BISON=bison
LEX=flex

teste: lex.yy.c sintatico.tab.c
	$(CPP) lex.yy.c sintatico.tab.c -lfl -std=c++17 

lex.yy.c: analisador.l
	$(LEX) analisador.l

sintatico.tab.c: sintatico.y
	$(BISON) -d sintatico.y

clean:
	rm -f teste lex.yy.c sintatico.tab.c sintatico.tab.h a.out
