//
// File: main.cpp
//
// MATLAB Coder version            : 4.1
// C/C++ source code generated on  : 11-Oct-2019 16:03:27
//

//***********************************************************************
// This automatically generated example C main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************
// Include Files
#include "rt_nonfinite.h"
#include "untitled.h"
#include "main.h"
#include "untitled_terminate.h"
#include "untitled_emxAPI.h"
#include "untitled_initialize.h"

// Function Declarations
static double argInit_real_T();
static void main_untitled();

// Function Definitions

//
// Arguments    : void
// Return Type  : double
//
static double argInit_real_T()
{
  return 0.0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_untitled()
{
  emxArray_real_T *B;
  emxInitArray_real_T(&B, 2);

  // Initialize function 'untitled' input arguments.
  // Call the entry-point 'untitled'.
  untitled(argInit_real_T(), argInit_real_T(), B);
  emxDestroyArray_real_T(B);
}

//
// Arguments    : int argc
//                const char * const argv[]
// Return Type  : int
//
int main(int, const char * const [])
{
  // Initialize the application.
  // You do not need to do this more than one time.
  untitled_initialize();

  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_untitled();

  // Terminate the application.
  // You do not need to do this more than one time.
  untitled_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
