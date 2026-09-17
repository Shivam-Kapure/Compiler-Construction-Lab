%{
#include <stdio.h>
#include <string.h>
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
    char line[1000];
    char program[10000] = "";

    printf("Enter the program.\n");
    printf("Press Enter on an empty line to finish:\n\n");

    while (fgets(line, sizeof(line), stdin) != NULL)
    {
        if (strcmp(line, "\n") == 0)
        {
            break;
        }

        if (strlen(program) + strlen(line) >= sizeof(program))
        {
            printf("Input is too large.\n");
            return 1;
        }

        strcat(program, line);
    }

    printf("\nGenerated tokens:\n");

    YY_BUFFER_STATE buffer = yy_scan_string(program);

    yylex();

    yy_delete_buffer(buffer);

    return 0;
}