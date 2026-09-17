%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);

int result;
int eof_error = 0;
%}

%token NUMBER
%token INVALID

%left '+' '-'
%left '*' '/'

%%

input:
      expression '\n'    { result = $1; }
    | expression          { result = $1; }
    ;

expression:
      expression '+' expression    { $$ = $1 + $3; }
    | expression '-' expression    { $$ = $1 - $3; }
    | expression '*' expression    { $$ = $1 * $3; }
    | expression '/' expression    { $$ = $1 / $3; }
    | NUMBER                       { $$ = $1; }
    ;

%%

int yyerror(const char *s)
{
    printf("Syntax error\n");
    return 0;
}

int main()
{
    if (yyparse() == 0)
        printf("%d\n", result);

    return 0;
}