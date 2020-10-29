// Name: Antonio Ramirez
// Project: Project 3
// Date: 26 Apr 2020

// CMSC 430
// Duane J. Jarc

// This file contains the bodies of the evaluation functions

#include <string>
#include <vector>
#include <cmath>

using namespace std;

#include "values.h"
#include "listing.h"

int evaluateReduction(Operators operator_, int head, int tail)
{
	if (operator_ == ADD)
		return head + tail;
	return head * tail;
}


int evaluateRelational(int left, Operators operator_, int right)
{
	int result;
	switch (operator_)
	{
		case LESS:
			result = left < right;
			break;
		case GREATERTHAN:
			result = left > right;
			break;	
		case EQUALS:
			result = left = right;
			break;	
		case NOTEQUAL:
			result = left /= right;
			break;	
		case LEQUALTO:
			result = left <= right;
			break;
		case GREQUALTO:
			result = left >= right;
			break;
	}
	return result;
}

int evaluateArithmetic(int left, Operators operator_, int right)
{
	int result;
	switch (operator_)
	{
		case ADD:
			result = left + right;
			break;
		case SUBTRACT:
			result = left - right;
			break;
		case MULTIPLY:
			result = left * right;
			break;
		case DIVIDE:
			result = left / right;
			break;
		case REMAINDER:
			result= left % right;
			break;
	}
	return result;
}

