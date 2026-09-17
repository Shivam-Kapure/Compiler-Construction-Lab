%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);

double stack[100];
int top = -1;
%}

%union {
    double num;
}

%token <num> NUMBER
%token INVALID

%left '+' '-'
%left '*' '/'

%%

input:
    expression '\n'
    {
        if (top == 0)
        {
            printf("Result: %g\n", stack[top]);
        }
        else
        {
            printf("Invalid postfix expression\n");
        }

        top = -1;
    }
    ;

expression:
      NUMBER
      {
          stack[++top] = $1;
      }

    | expression expression '+'
      {
          if (top < 1)
          {
              yyerror("insufficient operands");
              YYABORT;
          }

          double b = stack[top--];
          double a = stack[top--];

          stack[++top] = a + b;
      }

    | expression expression '-'
      {
          if (top < 1)
          {
              yyerror("insufficient operands");
              YYABORT;
          }

          double b = stack[top--];
          double a = stack[top--];

          stack[++top] = a - b;
      }

    | expression expression '*'
      {
          if (top < 1)
          {
              yyerror("insufficient operands");
              YYABORT;
          }

          double b = stack[top--];
          double a = stack[top--];

          stack[++top] = a * b;
      }

    | expression expression '/'
      {
          if (top < 1)
          {
              yyerror("insufficient operands");
              YYABORT;
          }

          double b = stack[top--];
          double a = stack[top--];

          if (b == 0)
          {
              yyerror("division by zero");
              YYABORT;
          }

          stack[++top] = a / b;
      }

    | INVALID
      {
          yyerror("invalid character");
          YYABORT;
      }
    ;

%%

int yyerror(const char *s)
{
    printf("Error: %s\n", s);
    return 0;
}

int main()
{
    printf("Enter postfix expression: ");

    yyparse();

    return 0;
}