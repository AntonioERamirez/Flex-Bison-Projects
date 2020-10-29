// Name: Antonio Ramirez
// Project: Project 3
// Date: 26 Apr 2020

// CMSC 430
// Duane J. Jarc

// This file contains function definitions for the evaluation functions

typedef char* CharPtr;
enum Operators {LESS, ADD, MULTIPLY, SUBTRACT, EQUALS, NOTEQUAL, GREATERTHAN, GREQUALTO, LEQUALTO, DIVIDE, EXPONENT, REMAINDER, ARR};

int evaluateReduction(Operators operator_, int head, int tail);
int evaluateRelational(int left, Operators operator_, int right);
int evaluateArithmetic(int left, Operators operator_, int right);

