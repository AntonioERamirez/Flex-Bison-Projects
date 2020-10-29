/* Name: Antonio Ramirez */
/* Project: Project 3 */
/* Date: 26 APR 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */

/* Compiler Theory and Design
   Dr. Duane J. Jarc */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment ("//"|"--").*\n
line [\n]
id [A-Za-z](_?[A-Za-z0-9])*
digit [0-9]
int {digit}+
real {digit}+\.{digit}*([Ee][+-]?{digit}+)?
punc [\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"		{ ECHO; yylval.oper = LESS; return(RELOP); }
"="		{ ECHO; yylval.oper = EQUALS; return(RELOP); }
"/="		{ ECHO; yylval.oper = NOTEQUAL; return(RELOP); }
">"		{ ECHO; yylval.oper = GREATERTHAN; return(RELOP); }
">="		{ ECHO; yylval.oper = GREQUALTO; return(RELOP); }
"<="		{ ECHO; yylval.oper = LEQUALTO; return(RELOP); }
"+"		{ ECHO; yylval.oper = ADD; return(ADDOP); }
"-"		{ ECHO; yylval.oper = SUBTRACT; return(ADDOP); }
"*"		{ ECHO; yylval.oper = MULTIPLY; return(MULOP); }
"/"		{ ECHO; yylval.oper = DIVIDE; return(MULOP); }
"=>"	{ ECHO; yylval.oper = ARR; return(ARROW); }
"**"		{ ECHO; yylval.oper = EXPONENT; return(EXPOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
if		{ ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
or		{ ECHO; return(OROP); }
not		{ ECHO; return(NOTOP); }
rem		{ ECHO; yylval.oper = REMAINDER; return(REMOP); }
false { ECHO; yylval.value = FALSE; return(BOOL_LITERAL); }
true { ECHO; yylval.value = TRUE; return(BOOL_LITERAL); }
{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
{real}      { ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
