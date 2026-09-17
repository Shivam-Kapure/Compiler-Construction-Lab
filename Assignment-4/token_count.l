%{
#include <stdio.h>

int keywords = 0;
int identifiers = 0;
int operators = 0;
int numbers = 0;
int symbols = 0;
%}

LETTER      [A-Za-z_]
DIGIT       [0-9]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*
NUMBER      {DIGIT}+

%%

int|float|char|double|long|short|void|if|else|for|while|return {
    printf("%s : Keyword\n", yytext);
    keywords++;
}

"+"|"-"|"*"|"/"|"%"|"=" {
    printf("%s : Operator\n", yytext);
    operators++;
}

{NUMBER} {
    printf("%s : Number\n", yytext);
    numbers++;
}

{IDENTIFIER} {
    printf("%s : Identifier\n", yytext);
    identifiers++;
}

";"|","|"("|")"|"{"|"}" {
    printf("%s : Special Symbol\n", yytext);
    symbols++;
}

[ \t\n]+ ;

. ;

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

    printf("\n========== TOKEN COUNT ==========\n");
    printf("Keywords       : %d\n", keywords);
    printf("Identifiers    : %d\n", identifiers);
    printf("Operators      : %d\n", operators);
    printf("Numbers        : %d\n", numbers);
    printf("Special Symbols: %d\n", symbols);

    if(yyin)
        fclose(yyin);

    return 0;
}