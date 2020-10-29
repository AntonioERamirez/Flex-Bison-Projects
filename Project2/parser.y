/* Name: Antonio Ramirez */
/* Project: Project 2 */
/* Date: 12 APR 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */


/* Compiler Theory conjunct Design
   Dr. Duane J. Jarc */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%error-verbose

%token IDENTIFIER

%token INT_LITERAL REAL_LITERAL BOOL_LITERAL

%token ADDOP MULOP REMOP EXPOP RELOP ANDOP OROP NOTOP

%token ARROW

%token BEGIN_ BOOLEAN CASE ELSE END ENDIF ENDCASE ENDREDUCE FUNCTION IF INTEGER
IS OTHERS REAL REDUCE RETURNS THEN WHEN

%%

function:	
	function_header_ variable_ body ;

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
	IDENTIFIER ':' type ;

variable_:
	variable | 
	error ; 

variable:
	variable IDENTIFIER ':' type IS statement_ ; | 
	;

type:
	INTEGER |
	REAL |
	BOOLEAN ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
expression |
IF expression THEN statement_ ELSE statement_ ENDIF |
CASE expression IS cases OTHERS ARROW statement_ ENDCASE |
REDUCE operator reductions ENDREDUCE ;

cases:
cases case_ |
 ;

case_: 
case ';' |
error ';' ;

case:
WHEN INT_LITERAL ARROW statement ;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression OROP conjunct |
	conjunct ;

conjunct:
	conjunct ANDOP relation | 
	relation;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP exponent | 
	factor REMOP exponent |
	exponent ;

exponent:
	negation EXPOP exponent | 
	negation ;

negation:
	NOTOP primary | 
	primary ;

primary:
	'(' expression ')' | 
	INT_LITERAL | REAL_LITERAL | BOOL_LITERAL |
	IDENTIFIER ;
    
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
