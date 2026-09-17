%{
#include <stdio.h>
%}

%%

"//".*                  { }

"/*"([^*]|\*+[^*/])*\*+"/"    { }

[ \t\n]+                { }

.                       { printf("%s", yytext); }

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