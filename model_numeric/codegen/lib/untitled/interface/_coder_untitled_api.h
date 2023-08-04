/*
 * File: _coder_untitled_api.h
 *
 * MATLAB Coder version            : 4.1
 * C/C++ source code generated on  : 11-Oct-2019 16:03:27
 */

#ifndef _CODER_UNTITLED_API_H
#define _CODER_UNTITLED_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_untitled_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void untitled(real_T D, real_T N, emxArray_real_T *B);
extern void untitled_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1]);
extern void untitled_atexit(void);
extern void untitled_initialize(void);
extern void untitled_terminate(void);
extern void untitled_xil_terminate(void);

#endif

/*
 * File trailer for _coder_untitled_api.h
 *
 * [EOF]
 */
