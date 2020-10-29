/* Name: Antonio Ramirez */
/* Project: Project 3 */
/* Date: 26 APR 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */


/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <math.h>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"
#include "stdlib.h"
#include <stdio.h>
#include <cmath>

int yylex();
void yyerror(const char* message);

Symbols<int> symbols;

int result;
double * userInput;
%}

%error-verbose

%union
{
	CharPtr iden;
	Operators oper;
	int value;
}

%token<iden> IDENTIFIER

%token<value> INT_LITERAL REAL_LITERAL BOOL_LITERAL TRUE FALSE CASE

%token<oper> ADDOP MULOP REMOP EXPOP RELOP OROP NOTOP
%token ANDOP

%token ARROW

%token BEGIN_ BOOLEAN ELSE END ENDIF ENDCASE ENDREDUCE FUNCTION IF INTEGER
IS OTHERS REAL REDUCE RETURNS THEN WHEN

%type <value> body statements statement_ statement reductions expression conjunct exponent negation relation term
	factor primary case_ cases case
%type <oper> operator

%%

function:	
	function_header_ variable_ body {result = $3;};

function_header_:
	function_header ';' |
	error ';' ; 

function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ;

parameters:
	parameter |
	parameter ',' parameters |
	;

parameter: 
	IDENTIFIER ':' type {symbols.insert($1, userInput[0]);} ;

variable_:
	variable | 
	error ; 

variable:
	variable IDENTIFIER ':' type IS statement_ {symbols.insert($2, $6);}; | 
	;

type:
	INTEGER |
	REAL |
	BOOLEAN ;

body:
	BEGIN_ statements END ';' {$$ = $2;};

statements:
	statements statement_ {$$ = $2;}| 
	{$$ = 0;};
    
statement_:
	statement ';' |
	error ';' {$$ = 0;} ;
	
statement:
expression |
IF expression THEN statement_ ELSE statement_ ENDIF {if ($2 == true) {
             $$=$4;
         }
         else {
             $$=$6;
         }
     }
    |
CASE expression IS cases OTHERS ARROW statement_ ENDCASE {$$ = $<value>4 == 1 ? 4 : 7;}|
REDUCE operator reductions ENDREDUCE {$$ = $3;} ;

cases:
cases case_ {$$ = $2;}|
 {$$ = 0;};

case_: case ';' |
error ';' {$$ = 0;} ;

case:
WHEN INT_LITERAL ARROW statement ;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ {$$ = evaluateReduction($<oper>0, $1, $2);} |
	{$$ = $<oper>0 == ADD ? 0 : 1;} ;
		    
expression:
	expression OROP conjunct {$$ = $1 || $3;} |
	conjunct ;

conjunct:
	conjunct ANDOP relation {$$ = $1 && $3;} |
	relation ;

relation:
	relation RELOP term {$$ = evaluateRelational($1, $2, $3);} |
	term;

term:
	term ADDOP factor {$$ = evaluateArithmetic($1, $2, $3);} |
	factor ;
      
factor:
	factor MULOP exponent {$$ = evaluateArithmetic($1, $2, $3);}| 
	factor REMOP exponent {$$ = $1 % $3;} |
	exponent ;

exponent:
	negation EXPOP exponent {$$ = pow($1, $3); } | 
	negation ;

negation:
	NOTOP primary {$$ = $2;} | 
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
	userInput = new double[argc - 1];
	for (int i = 1; i < argc; i++)
		userInput[i - 1] = atof(argv[i]); 
	 
	firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	return 0;
} 
