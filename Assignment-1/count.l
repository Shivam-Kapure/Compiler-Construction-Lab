%{
#include <stdio.h>
int count = 0;
%}

%%
[C][a-zA-Z0-9]*    { count++; }
.|\n                    { ECHO; }
%%

int yywrap()
{
    return 1;
}

int main()
{
    yylex();
    printf("\nNumber of identifiers: %d\n", count);
    return 0;
}