%{
#include <stdio.h>
%}

LETTER      [A-Za-z_]
DIGIT       [0-9]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*

%%

"+"         { printf("%s : Arithmetic Operator\n", yytext); }
"-"         { printf("%s : Arithmetic Operator\n", yytext); }
"*"         { printf("%s : Arithmetic Operator\n", yytext); }
"/"         { printf("%s : Arithmetic Operator\n", yytext); }
"%"         { printf("%s : Arithmetic Operator\n", yytext); }

{IDENTIFIER}    { printf("%s : Identifier\n", yytext); }

[ \t\n]+        ;

.               { printf("%s : Other Token\n", yytext); }

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

    if(yyin)
        fclose(yyin);

    return 0;
}