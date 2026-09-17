%{
#include "postfix.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+(\.[0-9]+)?      {
                            yylval.num = atof(yytext);
                            return NUMBER;
                        }

"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }

[ \t]+                  ;

\n                      { return '\n'; }

.                       { return INVALID; }

%%

int yywrap(void)
{
    return 1;
}