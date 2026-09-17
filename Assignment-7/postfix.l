%{
#include "postfix.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      {
                yylval = atoi(yytext);
                return NUMBER;
            }

[+\-*/%]    {
                return yytext[0];
            }

[ \t\n]+    {
                /* Ignore whitespace */
            }

.           {
                return yytext[0];
            }

%%

int yywrap()
{
    return 1;
}