%option noyywrap

%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>

int position = 0;
%}

%%

[0-9]+      {
                yylval = atoi(yytext);
                position += yyleng;
                return NUMBER;
            }

[ \t]+      {
                position += yyleng;
            }

\n          {
                position = 0;
                return '\n';
            }

"+"         {
                position++;
                return '+';
            }

"-"         {
                position++;
                return '-';
            }

"*"         {
                position++;
                return '*';
            }

"/"         {
                position++;
                return '/';
            }

.           {
                printf("Illegal character '%s' at line 1, position %d\n",
                       yytext, position);
                position++;
                return INVALID;
            }

%%