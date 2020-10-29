/* Name: Antonio Ramirez */
/* Project: Project 4 */
/* Date: 10 May 2020 */
/* Description: Modified from given code to incorporate the necessary additons per rubric */

// Compiler Theory and Design
// Duane J. Jarc

// This file contains type definitions and the function
// prototypes for the type checking functions

typedef char* CharPtr;

enum Types {MISMATCH, INT_TYPE, BOOL_TYPE, REAL_TYPE, NOT_SET};

void checkAssignment(Types lValue, Types rValue, string message);
Types checkArithmetic(Types left, Types right);
Types checkLogical(Types left, Types right);
Types checkRelational(Types left, Types right);
Types checkNegation(Types right);
Types checkRem(Types left, Types right);
Types checkIfStatement(Types conditional, Types thenStatement, Types elseStatement);
Types checkCase(Types caseExpression);
Types checkCaseType(Types fValue, Types lValue);