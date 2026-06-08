%{
#include "sintatico.tab.h"
#include <stdio.h>
#include <stdlib.h>

extern int has_error;
%}

%option noyywrap
%option yylineno


DIGITO_NAO_ZERO [1-9]
DIGITO          [0-9]
NUMERO_INTEIRO  {DIGITO_NAO_ZERO}{DIGITO}*


LETRA_MAI       [A-Z]
LETRA_MIN       [a-z]
LETRA           [A-Za-z]
ID_VALIDO       {LETRA_MAI}{LETRA}*{LETRA_MIN}{LETRA}*
FUNC_VALIDA     _{ID_VALIDO}

%%

"elgio"     { return ELGIO; }
"."         { return PONTO; }


"numero"    { return NUMERO_TIPO; }
"NADA"      { return NADA; }
"NEG"       { return NEG; }
"EXP"       { return EXP; }

"enquanto"  { return ENQUANTO; }
"se"        { return SE; }
"entao"     { return ENTAO; }
"senao"     { return SENAO; }
"para"      { return PARA; }
"inicio"    { return INICIO; }
"fim"       { return FIM; }

"maior"     { return MAIOR; }
"menor"     { return MENOR; }
"igual"     { return IGUAL; }
"diferente" { return DIFERENTE; }
"migual"    { return MIGUAL; }
"Migual"    { return MIGUAL_UP; }

"="         { return ATRIBUICAO; }
"+"         { return MAIS; }
"-"         { return MENOS; }
"x"         { return VEZES; }
"/"         { return DIVISAO; }
"%"         { return MODULO; }

"("         { return ABRE_PAR; }
")"         { return FECHA_PAR; }
","         { return VIRGULA; }

{NUMERO_INTEIRO} { return NUM; }


{FUNC_VALIDA} {
   return ID_FUNC;
}


{ID_VALIDO} {
    return ID;
}


[ \t\r\n]+  { /* ignora */ }

"*"[^\n]* { /* comentario de linha - ignora */ }


{LETRA_MAI}{LETRA}*[0-9_][A-Za-z0-9_]* {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

_{LETRA}[A-Za-z0-9_]*[0-9_][A-Za-z0-9_]* {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

_{LETRA_MIN}[A-Za-z0-9_]* {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

_{LETRA_MAI}{LETRA_MAI}+[A-Za-z0-9_]* {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

{LETRA_MAI} {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

[a-z][a-zA-Z0-9_]* {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

. {
    printf("Erro lexico na linha %d: '%s'\n", yylineno, yytext);
    has_error = 1;
}

%%
