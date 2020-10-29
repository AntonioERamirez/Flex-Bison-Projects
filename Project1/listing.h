// Name: Antonio Ramirez
// Project: Project 1
// Date: 29 Mar 2020
// Description: Header file for listing.cc, unmodified from the given code.

// Compiler Theory and Design
// Dr. Duane J. Jarc

// This file contains the function prototypes for the functions that produce the // compilation listing

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

