%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
%}

%option noyywrap

DIGIT       [0-9]
LETTER      [A-Za-z_]
INTEGER     {DIGIT}+
FLOAT       ({DIGIT}+\.{DIGIT}*|\.{DIGIT}+)
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*

%%

"=="            { printf("EQUALS\t\t%s\n", yytext); }
"="             { printf("ASSIGN\t\t%s\n", yytext); }
"+"             { printf("PLUS\t\t%s\n", yytext); }
"-"             { printf("MINUS\t\t%s\n", yytext); }
"*"             { printf("MULTIPLY\t%s\n", yytext); }
"/"             { printf("DIVIDE\t\t%s\n", yytext); }

{FLOAT}         { printf("FLOAT\t\t%s\n", yytext); }
{INTEGER}       { printf("INTEGER\t\t%s\n", yytext); }
{IDENTIFIER}    { printf("IDENTIFIER\t%s\n", yytext); }

[ \t\r\n]+      ;

.               { printf("INVALID\t\t%s\n", yytext); }

%%

int main(void)
{
    char filename[256];

    printf("Enter filename: ");
    scanf("%255s", filename);

    yyin = fopen(filename, "r");

    if (yyin == NULL)
    {
        printf("Unable to open file: %s\n", filename);
        return 1;
    }

    printf("\nGenerated tokens:\n");

    yylex();

    fclose(yyin);

    return 0;
}