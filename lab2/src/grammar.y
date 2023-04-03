%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"

int lineno = 1;

int yylex();
void yyerror();
%}



%token ILIT

%token ASSIGN COMMA LPARENT RPARENT IDENTIFIER
%token BAND BOR BXOR BNOT
%token EOL

%left BAND
%left BOR
%left BXOR
%left BNOT

%%

program
    : /* empty */
    | program statement
    ;

statement
    : EOL {lineno++;}
    | expression EOL {lineno++;}
    ;

expression
    : ILIT
    | IDENTIFIER
    | LPARENT expression RPARENT
    | expression ASSIGN expression
    | expression BOR expression
    | expression BXOR expression
    | expression BAND expression
    | BNOT expression
    | expression COMMA expression
    | expression LPARENT expression RPARENT
    ;

%%

void yyerror(char const *msg) {
    printf("Error on line %d: %s\n",lineno, msg);
}

int main(int argc, char **argv){
int ec;
// If no filename print Usage and take from stdin
if (argc == 1) {
    ec = yyparse();
    return ec;
}
// Too many arguments, close program
if (argc > 2) {
    return 1;
}

// Open file and check if can read
FILE *file = fopen(argv[1], "r");
if (!file) {
    perror(argv[1]);
    return 1;
}

yyin = file;
ec = yyparse();
fclose(file);
return ec;
}