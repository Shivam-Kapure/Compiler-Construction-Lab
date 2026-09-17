%{
#include <stdio.h>

int operators = 0;
int identifiers = 0;
int datatypes = 0;
%}

LETTER      [A-Za-z_]
DIGIT       [0-9]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*

%%

int|float|char|double|long|short|void {
    printf("%s : Data Type\n", yytext);
    datatypes++;
}

"+"|"-"|"*"|"/"|"%"|"=" {
    printf("%s : Operator\n", yytext);
    operators++;
}

{IDENTIFIER} {
    printf("%s : Identifier\n", yytext);
    identifiers++;
}

{DIGIT}+ {
    /* Ignore numbers */
}

[ \t\n]+ {
    /* Ignore whitespace */
}

. {
    /* Ignore everything else */
}

%%

int yywrap()
{
    return 1;
}

int main(int argc, char *argv[])
{
    if(argc > 1)
    {
        yyin = fopen(argv[1], "r");

        if(yyin == NULL)
        {
            printf("Cannot open file.\n");
            return 1;
        }
    }

    yylex();

    printf("\n===== Count =====\n");
    printf("Operators   : %d\n", operators);
    printf("Identifiers : %d\n", identifiers);
    printf("Data Types  : %d\n", datatypes);

    if(yyin)
        fclose(yyin);

    return 0;
}