%{
#include "parser.tab.h"
%}

%%

[0-9]+(\.[0-9]+)?       { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }

"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"("                     { return '('; }
")"                     { return ')'; }

[ \t]+                  ;
\n                      { return '\n'; }

.                       { return yytext[0]; }

%%

int yywrap(void)
{
    return 1;
}