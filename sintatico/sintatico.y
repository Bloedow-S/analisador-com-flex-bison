%{
#include <stdio.h>
#include <stdlib.h>
extern int yylineno;
int yyerror(char *s);
int yylex();
%}

%token ID ID_FUNC NUM ELGIO
%token NUMERO_TIPO NADA NEG EXP
%token ENQUANTO SE ENTAO SENAO PARA
%token INICIO FIM PONTO ATRIBUICAO
%token MAIS MENOS VEZES DIVISAO MODULO
%token MAIOR MENOR IGUAL DIFERENTE MIGUAL MIGUAL_UP
%token ABRE_PAR FECHA_PAR VIRGULA ERRO_LEXICO

%%

/* Ponto de entrada — expandido pelo Aluno 03 */
programa
    : lista_comandos
    ;

lista_comandos
    : comando
    | lista_comandos comando
    ;

lista_comandos_opt
    : /* vazio */
    | lista_comandos
    ;

bloco
    : INICIO PONTO lista_comandos_opt FIM PONTO
    ;

/* Comandos do Aluno 02 (Expandido com regras do Aluno 03) */
comando
    : atribuicao_normal
    | atribuicao_elgio
    | enquanto
    | para
    | NEG ID PONTO
    | declaracao_var
    | definicao_funcao
    | condicional_se
    | bloco
    ;

/* ------------------------------------------------------------------ */
/* Expansao Aluno 03: Declaracao de variaveis e funcoes               */
/* ------------------------------------------------------------------ */

declaracao_var
    : NUMERO_TIPO ID PONTO
    ;

definicao_funcao
    : NUMERO_TIPO ID_FUNC ABRE_PAR def_params FECHA_PAR PONTO bloco
    ;

def_params
    : operando_def_param
    | def_params VIRGULA operando_def_param
    | /* sem parametros */
    ;

operando_def_param
    : NUMERO_TIPO ID
    ;

condicional_se
    : SE expr_logica PONTO ENTAO PONTO bloco SENAO PONTO bloco
    ;


operador_mat
    : MAIS
    | MENOS
    | VEZES
    | DIVISAO
    | MODULO
    | EXP
    ;


operando_param
    : ID
    | NUM
    | NADA
    ;

lista_params
    : operando_param
    | lista_params VIRGULA operando_param
    ;

chamada_func
    : ID_FUNC ABRE_PAR lista_params FECHA_PAR
    | ID_FUNC ABRE_PAR FECHA_PAR
    ;

operando
    : ID
    | NUM
    | NADA
    | chamada_func
    ;

expr_mat
    : operando
    | expr_mat operador_mat operando
    ;

/* Atribuicao normal: ID = expr_mat . */
atribuicao_normal
    : ID ATRIBUICAO expr_mat PONTO
    ;


operando_elgio
    : ID
    | NUM
    | NADA
    ;

expr_elgio
    : operando_elgio
    | expr_elgio operador_mat operando_elgio
    ;

atribuicao_elgio
    : ELGIO ATRIBUICAO expr_elgio PONTO
    ;


operador_rel
    : MAIOR
    | MENOR
    | IGUAL
    | DIFERENTE
    | MIGUAL
    | MIGUAL_UP
    ;

operando_rel
    : ID
    | NUM
    | NADA
    ;

expr_logica
    : operando_rel operador_rel operando_rel
    ;

enquanto
    : ENQUANTO expr_logica PONTO bloco
    ;

limite_para
    : NUM
    | ID
    ;

para
    : PARA ID limite_para PONTO bloco
    ;

%%

int yyerror(char *s) {
    printf("Erro sintatico na linha %d\n", yylineno);
    return 1;
}

int main(void) {
    return yyparse();
}
