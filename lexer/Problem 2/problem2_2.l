%{
#include <stdio.h>
%}

%%

"#define"		printf("DEFINE ");
"int"			printf("INT ");
"void"			printf("VOID ");
"if"			printf("IF ");
"else"			printf("ELSE ");
"for"			printf("FOR ");
"="|"+="		printf("OP_ASSIGN ");
"++"			printf("OP_INC ");
"+"			printf("OP_ADD ");
"-"			printf("OP_SUB ");
"*"			printf("OP_MUL ");
"/"			printf("OP_DIV ");
"&&"|"||"		printf("OP_LOGIC ");
"!="|"=="|"<"|">"|"<="|">="	printf("OP_REL ");
[_a-zA-Z][_a-zA-Z0-9]* 	printf("ID ");
[0-9]+			printf("NUM ");
"//".*|"/*".*"*/"	printf("comment ");
"["|"]"|"("|")"|"{"|"}"|";"|","	printf("%s ", yytext);
[ \t]+			

%%

int main(argc, argv)
int argc;
char **argv;
{
++argv, --argc;
if( argv > 0 )
        yyin = fopen(argv[0], "r");
else
        yyin = stdin;
yylex();
return 0;
}