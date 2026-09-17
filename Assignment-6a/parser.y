%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token NUMBER ID

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
    expression '\n'
    {
        printf("Valid arithmetic expression\n");
        YYACCEPT;
    }
    ;

expression:
      expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | '(' expression ')'
    | '-' expression %prec UMINUS
    | NUMBER
    | ID
    ;

%%

int yyerror(const char *s)
{
    printf("Invalid arithmetic expression\n");
    return 0;
}

int main(void)
{
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}