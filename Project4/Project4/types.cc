/* Name: Antonio Ramirez */
/* Project: Project 4 */
/* Date: 10 May 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */

// Compiler Theory and Design
// Duane J. Jarc

// This file contains the bodies of the type checking functions

#include <string>
#include <vector>

using namespace std;

#include "types.h"
#include "listing.h"

void checkAssignment(Types lValue, Types rValue, string message)
{
	if (lValue != MISMATCH && rValue != MISMATCH && lValue != rValue)
	{
		if ((lValue == INT_TYPE && rValue == REAL_TYPE) || (lValue == REAL_TYPE && rValue == INT_TYPE)){
			appendError(GENERAL_SEMANTIC, "Illegal Narrowing " + message);
		} else
		{
			appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
		}
		
	}
		
}

Types checkArithmetic(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left == BOOL_TYPE || right == BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Numeric Type Required");
		return MISMATCH;
	}
	if (left == INT_TYPE && right == INT_TYPE){
		return INT_TYPE;
	} else if ((left == INT_TYPE && right == REAL_TYPE) || (left == REAL_TYPE && right == INT_TYPE)){
		return REAL_TYPE;
	}
}


Types checkLogical(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left != BOOL_TYPE || right != BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Boolean Type Required");
		return MISMATCH;
	}	
		return BOOL_TYPE;
	return MISMATCH;
}

Types checkNegation(Types right)
{
	if (right == MISMATCH)
		return MISMATCH;
	if (right != BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Boolean Type Required");
		return MISMATCH;
	}	
		return BOOL_TYPE;
	return MISMATCH;
}

Types checkRelational(Types left, Types right)
{
	if (checkArithmetic(left, right) == MISMATCH)
		return MISMATCH;
	return BOOL_TYPE;
}

Types checkRem(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left != INT_TYPE || right != INT_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Remainder Operator Requires Integer Operands");
		return MISMATCH;
	}
	return REAL_TYPE;
}

Types checkIfStatement(Types conditional, Types thenStatement, Types elseStatement)
{
	if (conditional == MISMATCH)
		return MISMATCH;
	if (conditional != BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "If Expression Must Be Boolean");
		return MISMATCH;
	} else if (thenStatement != MISMATCH && elseStatement != MISMATCH && thenStatement != elseStatement)
	{
		appendError(GENERAL_SEMANTIC, "If-Then Type Mismatch");
		return MISMATCH;
	} 	

	if (thenStatement == INT_TYPE && elseStatement == INT_TYPE)
	{
		return INT_TYPE;
	} else if (thenStatement == REAL_TYPE && elseStatement == REAL_TYPE)
	{
		return REAL_TYPE;
	}
	
		return BOOL_TYPE;
	
	return MISMATCH;
}

Types checkCase(Types caseExpression)
{
	if (caseExpression != INT_TYPE){
		appendError(GENERAL_SEMANTIC, "Case Expression Not Integer");
		return MISMATCH;
	}

	if(caseExpression == INT_TYPE)
	{
		return INT_TYPE;
	} else if (caseExpression == REAL_TYPE)
	{
		return REAL_TYPE;
	} else if (caseExpression == BOOL_TYPE)
	{
		return BOOL_TYPE;
	} else 
	{
		return MISMATCH;
	}
}

Types checkCaseType (Types fValue, Types lValue)
{
	if (fValue == MISMATCH || lValue == MISMATCH || fValue != lValue)
	{
		appendError(GENERAL_SEMANTIC, "Case Types Mismatch");
		return MISMATCH;
		
	}

	return lValue;
	
}