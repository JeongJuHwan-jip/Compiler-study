%{ 
#include <stdio.h> 
#include <string.h> 
#include "y.tab.h"

extern FILE *yyin;
char *FILE_name;

void yyerror(const char *str) 
{
  extern int yylineno;
  extern char *yytext;
  fprintf(stderr, "%s:%d: error: %s '%s' token\n", FILE_name, yylineno, str, yytext);
}

int yywrap() {
  return 1; 
}

int main(argc, argv)
int argc;
char **argv;
{
	++argv, --argc;
	if( argv > 0 ) {
		yyin = fopen(argv[0], "r");
		FILE_name = argv[0];
	}
	else
		yyin = stdin;
	yyparse();
	return 0;
}

%} 
%token DEFINE INT VOID IF FOR CONTINUE OP_ASSIGN OP_INC OP_ADD OP_MUL OP_LOGIC OP_REL

%union
{
  int number;
  char *string;
}
%token <number> NUM
%token <string> ID

%type <string> variable
%type <string> assignments

%% 
program: /* empty */ 
    | program line
    ;
line: 
    header
    | function
    | fline
    ;
fline:
    expression
    | statement
    | clause
    ;

header:	
    DEFINE ID NUM
    { printf("Header(Define)\n"); }
    ;

function: 
    type ID '(' func_declarations ')' '{' contents '}'
    { printf("Function (%s) matched!\n", $2); }
    ;
type: 
    VOID
    | INT
    ;

func_declarations: /* empty */
    | declarations
    { printf("Expression(FunctionArgsDec)\n"); }
    ;
declarations:
    declarations ',' declaration
    | declaration
    ;
declaration:
    type variable
    ;
variable:
    ID arrays
    { $$=$1; }
    ;
arrays:
    | arrays array
    ;
array:
    '[' ']'
    | '[' expression ']'
    ; 

expression: 
    factor
    | factor OP_AM expression
    ;
OP_AM:
    OP_ADD
    | OP_MUL
    ;
factor:
    variable
    | NUM
    ;

contents:
    | contents fline
    ;

multi_declaration:
    type variables
    ;
variables:
    variable
    | variables ',' variable
    ;
statement: 
    error ';'
    | multi_declaration ';'
    { printf("Statement(Declaration)\n"); }
    | assignments ';'
    { printf("Statement(Assignment,%s)\n", $1); }
    | CONTINUE ';'
    { printf("Statement(Continue)\n"); }
    ;

assignments: 
    variable OP_ASSIGN expression
    { $$=$1; }
    ;

clause:
    FOR '(' InitializeStatement ';' TestExpressions ';' UpdateStatement ')' content
    { printf("Clause(for) matched!\n"); }
    | IF '(' TestExpressions ')' content
    { printf("Clause(if) matched!\n"); }
    ;
content:
    '{' contents '}'
    | fline
    ;

InitializeStatement:
    | assignments
    { printf("Statement(Initialize)\n"); }
    ;
TestExpressions:
    | TestExpression
    { printf("Expression(Test)\n"); }
    ;
TestExpression:
    TestFactor
    | TestFactor OP_LOGIC TestExpression
    ;
TestFactor:
    expression OP_REL expression
    | expression
    ;
UpdateStatement:
    | ID OP_INC
    { printf("Statement(Update)\n"); }
    ;
%%
