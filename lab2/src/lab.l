%option noyywrap

%{
#include "grammar.h"
#include <math.h>
%}

%%


"&" {return BAND;} // here and below match operators = , and ()
"|" {return BOR;}
"^" {return BXOR;}
"~" {return BNOT;}
"=" {return ASSIGN;}
"," {return COMMA;}
"(" {return LPARENT;}
")" {return RPARENT;}

\n {return EOL;}

[ \t\r] //ignore whitespace

0[xX][0-9a-fA-F]+ {
        long int num = strtol(yytext, NULL, 16);
        if (num > pow(2,32)) 
            printf("ERROR: %s\n", yytext);
        else 
            return ILIT;
    } //match hex numbers, give error if above 2^32

[0-9][a-zA-Z0-9_]*  {printf("ERROR: %s\n", yytext); return 1; } //match anything else that starts with a number, but a word

[a-zA-Z_][a-zA-Z0-9_]*  {return IDENTIFIER;} //match function names (even b is a IDENTIFIER based on example)

<<EOF>> { return 0;}

. {printf("ERROR: %s\n", yytext); return 1; } // error anything that is left

%%