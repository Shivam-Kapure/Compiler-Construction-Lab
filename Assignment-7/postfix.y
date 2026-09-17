%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER

%%

input:
      expression
      {
          printf("Result = %d\n", $1);
      }
      ;

expression:
      NUMBER
      {
          $$ = $1;
      }
      | expression expression '+'
      {
          $$ = $1 + $2;
      }
      | expression expression '-'
      {
          $$ = $1 - $2;
      }
      | expression expression '*'
      {
          $$ = $1 * $2;
      }
      | expression expression '/'
      {
          if ($2 == 0)
          {
              yyerror("Division by zero");
              YYABORT;
          }

          $$ = $1 / $2;
      }
      | expression expression '%'
      {
          if ($2 == 0)
          {
              yyerror("Modulo by zero");
              YYABORT;
          }

          $$ = $1 % $2;
      }
      ;

%%

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter postfix expression: ");
    yyparse();

    return 0;
}