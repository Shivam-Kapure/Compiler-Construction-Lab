%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Symbol
{
    char name[50];
    char datatype[20];
    int line;
    int address;
    int bytes;
};

struct Symbol table[100];

int count = 0;
int current_line = 1;
int address = 1000;

char current_type[20] = "";

int get_bytes(char *type)
{
    if(strcmp(type, "char") == 0)
        return 1;
    if(strcmp(type, "short") == 0)
        return 2;
    if(strcmp(type, "int") == 0)
        return 4;
    if(strcmp(type, "float") == 0)
        return 4;
    if(strcmp(type, "double") == 0)
        return 8;
    if(strcmp(type, "long") == 0)
        return 8;

    return 0;
}

int is_keyword(char *word)
{
    char *keywords[] = {
        "auto", "break", "case", "const", "continue",
        "default", "do", "else", "enum", "extern",
        "for", "goto", "if", "register", "return",
        "signed", "sizeof", "static", "struct",
        "switch", "typedef", "union", "unsigned",
        "void", "volatile", "while"
    };

    int i;

    for(i = 0; i < (int)(sizeof(keywords) / sizeof(keywords[0])); i++)
    {
        if(strcmp(word, keywords[i]) == 0)
            return 1;
    }

    return 0;
}

int already_exists(char *name)
{
    int i;

    for(i = 0; i < count; i++)
    {
        if(strcmp(table[i].name, name) == 0)
            return 1;
    }

    return 0;
}

void add_symbol(char *name)
{
    int bytes;

    if(already_exists(name))
        return;

    bytes = get_bytes(current_type);

    if(bytes == 0)
        return;

    strcpy(table[count].name, name);
    strcpy(table[count].datatype, current_type);
    table[count].line = current_line;
    table[count].address = address;
    table[count].bytes = bytes;

    address = address + bytes;
    count++;
}

void display_table()
{
    int i;

    printf("\nSYMBOL TABLE\n");
    printf("---------------------------------------------------------------\n");
    printf("%-15s %-12s %-12s %-18s %-8s\n",
           "Name", "Data Type", "Line", "Memory Location", "Bytes");
    printf("---------------------------------------------------------------\n");

    for(i = 0; i < count; i++)
    {
        printf("%-15s %-12s %-12d %-18d %-8d\n",
               table[i].name,
               table[i].datatype,
               table[i].line,
               table[i].address,
               table[i].bytes);
    }

    printf("---------------------------------------------------------------\n");
}

%}

%x COMMENT

%%

"//".*                          ;

"/*"                            BEGIN(COMMENT);
<COMMENT>"*/"                   BEGIN(INITIAL);
<COMMENT>\n                     { current_line++; }
<COMMENT>.                      ;

\n                              { current_line++; }

[ \t\r]+                        ;

"int"                           { strcpy(current_type, "int"); }
"float"                         { strcpy(current_type, "float"); }
"double"                        { strcpy(current_type, "double"); }
"char"                          { strcpy(current_type, "char"); }
"short"                         { strcpy(current_type, "short"); }
"long"                          { strcpy(current_type, "long"); }

[a-zA-Z_][a-zA-Z0-9_]*          {
                                    if(!is_keyword(yytext))
                                    {
                                        if(strlen(current_type) > 0)
                                            add_symbol(yytext);
                                    }
                                }

.                               ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *file;

    file = fopen("input.c", "r");

    if(file == NULL)
    {
        printf("Cannot open input.c\n");
        return 1;
    }

    yyin = file;

    yylex();

    fclose(file);

    display_table();

    return 0;
}