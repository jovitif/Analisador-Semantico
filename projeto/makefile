
# Compiladores
CPP=g++
Bison=bison
Lex=flex

# Dependências
all: lex.yy.c sintatico.tab.c
		$(cpp) lex.yy.c sintatico.tab.c -std=c++17 -o teste
lex.yy.c: analisador.l
	$(Lex) analisador.l

sintatico.tab.c: sintatico.y
	$(Bison) -d sintatico.y

clean:
	rm analisador lex.yy.c sintatico.tab.c sintatico.tab.h
