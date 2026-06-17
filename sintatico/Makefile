all:
	# Roda o Bison no arquivo .y para gerar o sintatico.tab.c e sintatico.tab.h
	bison -d sintatico.y

	# Roda o Flex no seu analisador.l para gerar o lex.yy.c
	flex analisador.l

	# Compila os dois arquivos .c juntos em um único executável chamado 'analisador'
	gcc sintatico.tab.c lex.yy.c -o analisador

clean:
	# Limpa todos os arquivos temporários gerados por ambas as ferramentas
	rm -f lex.yy.c *.tab.c *.tab.h analisador
