/* Name: Antonio Ramirez */
/* Project: Project 4 */
/* Date: 10 May 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */


/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <string>
#include <vector>
#include <map>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<Types> symbols;

%}

%error-verbose

%union
{
	CharPtr iden;
	Types type;
}

%token <iden> IDENTIFIER

%token <type> INT_LITERAL REAL_LITERAL BOOL_LITERAL

%token ADDOP MULOP REMOP EXPOP RELOP ANDOP OROP NOTOP

%token ARROW

%token BEGIN_ BOOLEAN CASE ELSE END ENDIF ENDCASE ENDREDUCE FUNCTION IF INTEGER
IS OTHERS REAL REDUCE RETURNS THEN WHEN

%type <type> type statement statement_ reductions expression relation term
	factor primary conjunct exponent negation function_header_ function_header 
	body statements cases case_ case 

%%

function:	
	function_header_ variable_ body {checkAssignment($1, $3, "Function Return");} ;

function_header_:
	function_header ';' {$$ = $1;} |
	error ';' {$$ = MISMATCH;} ; 

function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type {$$ = $5;} ;

parameters:
	parameter |
	parameter ',' parameters |
	;

parameter: 
	IDENTIFIER ':' type ;

variable_:
	variable | 
	error ; 

variable:
	variable IDENTIFIER ':' type IS statement_ {checkAssignment($4, $6, "Variable Initialization"); if (symbols.find($2, $4)) appendError(DUPLICATE_IDENTIFIER, $2);
		symbols.insert($2, $4);} ; | 
	;

type:
	INTEGER {$$ = INT_TYPE;} |
	REAL {$$ = REAL_TYPE;} |
	BOOLEAN {$$ = BOOL_TYPE;} ;

body:
	BEGIN_ statements END ';' {$$ = $2;} ;

statements:
	statements statement_  {$$ = $2;}| 
	;
    
statement_:
	statement ';' {$$ = $1;}|
	error ';' {$$ = MISMATCH;} ;
	
statement:
expression |
IF expression THEN statement_ ELSE statement_ ENDIF {$$ = checkIfStatement($2, $4, $6);} |
CASE expression IS cases OTHERS ARROW statement_ ENDCASE {$$ = checkCase($2);} |
REDUCE operator reductions ENDREDUCE {$$ = $3;} ;

cases:
cases case_ {$$ = $1 == NOT_SET ? $2 : checkCaseType($1, $2);} |
 {$$ = NOT_SET;};

case_: case ';' {$$ = $1;}|
error ';' {$$ = MISMATCH;} ;

case:
WHEN INT_LITERAL ARROW statement {$$ = $4;};

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ {$$ = checkArithmetic($1, $2);} |
	{$$ = INT_TYPE;} ;
		    
expression:
	expression OROP conjunct {$$ = checkLogical($1, $3);} |
	conjunct ;

conjunct:
	conjunct ANDOP relation {$$ = checkLogical($1, $3);} |
	relation ;

relation:
	relation RELOP term {$$ = checkRelational($1, $3);} |
	term;

term:
	term ADDOP factor {$$ = checkArithmetic($1, $3);} |
	factor ;
      
factor:
	factor MULOP exponent {$$ = checkArithmetic($1, $3);} | 
	factor REMOP exponent {$$ = checkRem($1, $3);} |
	exponent ;

exponent:
	negation EXPOP exponent {$$ = checkArithmetic($1, $3);} | 
	negation ;

negation:
	NOTOP primary {$$ = checkNegation($2);} | 
	primary ;

primary:
	'(' expression ')' {$$ = $2;} | 
	INT_LITERAL | REAL_LITERAL | BOOL_LITERAL |
	IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);} ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
