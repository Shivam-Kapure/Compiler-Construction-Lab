%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER
%token IDENTIFIER
%token ASSIGN
%token PLUS MINUS MULTIPLY DIVIDE MODULO
%token LPAREN RPAREN
%token NEWLINE
%token INVALID

%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%right UMINUS

%%

input:
      expression NEWLINE
        {
            printf("Valid arithmetic expression.\n");
        }
    | input expression NEWLINE
        {
            printf("Valid arithmetic expression.\n");
        }
    ;

expression:
      expression PLUS expression
    | expression MINUS expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    | expression MODULO expression
    | MINUS expression %prec UMINUS
    | LPAREN expression RPAREN
    | NUMBER
    | IDENTIFIER
    ;

%%

void yyerror(const char *s)
{
    printf("Invalid arithmetic expression.\n");
}

int main()
{
    printf("Arithmetic Expression Syntax Analyzer\n\n");
    yyparse();
    return 0;
}