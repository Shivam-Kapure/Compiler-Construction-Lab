%{
#include <stdio.h>
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
    printf("Enter an expression or program. Press Ctrl+D to finish:\n");

    yylex();

    return 0;
}