// Name: Antonio Ramirez
// Project: Project 1
// Date: 29 Mar 2020
// Description: Modified from given code to support multiple errors per line
// as well as count the individual types of error. 

// Compiler Theory and Design
// Dr. Duane J. Jarc

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	if (totalErrors == 0)
	{
		printf("Compiled Successfully");
	} else
	{
		printf("\nTotal Errors: %d\n", totalErrors);
		printf("Lexical Errors: %d\n", lexicalErrors);
		printf("Syntax Errors: %d\n", syntaxErrors);
		printf("Semantic Errors: %d\n", semanticErrors);
	}
	
	printf("\r");
	displayErrors();
	printf("     \n");
	return totalErrors;
}

void appendError(ErrorCategories errorCategory, string message)
{
    string messages[] = { "Lexical Error, Invalid Character ", "Syntax Error, U", "Semantic Error, ",
                          "Semantic Error, Duplicate Identifier: ", "Semantic Error, Undeclared " };

    switch (errorCategory)
    {
        case LEXICAL:
            lexicalErrors++;
            break;
        case SYNTAX:
            message = message.substr(15);
            syntaxErrors++;
            break;
        case GENERAL_SEMANTIC:
        case DUPLICATE_IDENTIFIER:
        case UNDECLARED:
            semanticErrors++;
            break;
    }
    errors.push_back(messages[errorCategory] + message);
}

void displayErrors()
{
	if (error != "")
		printf("%s\n", error.c_str());
	error = "";
}
