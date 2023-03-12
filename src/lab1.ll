%option noyywrap

%{
#include <stdio.h>
%}

%%

[ \t\n] //ignore whitespace

"&" {printf("BAND: \"&\" \n");} // here and below match operators = , and ()
"|" {printf("BOR: \"|\"\n");}
"^" {printf("BXOR: \"^\"\n");}
"~" {printf("BNOT: \"~\"\n");}
"=" {printf("ASSIGN: \"=\"\n");}
"," {printf("COMMA: \",\"\n");}
"(" {printf("LPARENT: \"(\"\n");}
")" {printf("RPARENT: \")\"\n");}

0[xX][0-9a-fA-F]+ {printf("ILIT: \"%s\"\n", yytext);} //match hex numbers

[0-9][a-zA-Z0-9_]*  {printf("ERROR: %s\n", yytext);} //match anything else that starts with a number, but a word

[a-zA-Z_][a-zA-Z0-9_]*  {printf("IDENTIFIER: %s\n", yytext);} //match function names (even b is a IDENTIFIER based on example)

. {printf("ERROR: %s\n", yytext);} // error anything that is left

%%
int main(int argc, char **argv)
    {
    // If no filename print Usage and take from stdin
    if (argc == 1) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        printf("Escape char: ^D, write input below\n");
        yylex();
        return 0;
    }
    // Too many arguments, close program
    if (argc > 2) {
        fprintf(stderr, "Too many arguments, closing.\n");
        return 1;
    }

    // Open file and check if can read
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);
    return 0;
    }
