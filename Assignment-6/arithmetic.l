%{
#include "arithmetic.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+               { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]* { return IDENTIFIER; }

"="                  { return ASSIGN; }

"+"                  { return PLUS; }
"-"                  { return MINUS; }
"*"                  { return MULTIPLY; }
"/"                  { return DIVIDE; }
"%"                  { return MODULO; }

"("                  { return LPAREN; }
")"                  { return RPAREN; }

[ \t]+               ;
\n                   { return NEWLINE; }

.                    { return INVALID; }

%%

int yywrap()
{
    return 1;
}