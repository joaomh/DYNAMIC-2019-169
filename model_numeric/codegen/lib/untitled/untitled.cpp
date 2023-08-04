//
// File: untitled.cpp
//
// MATLAB Coder version            : 4.1
// C/C++ source code generated on  : 11-Oct-2019 16:03:27
//

// Include Files
#include <cmath>
#include <math.h>
#include "rt_nonfinite.h"
#include <float.h>
#include "untitled.h"
#include "untitled_emxutil.h"

// Function Declarations
static double rt_powd_snf(double u0, double u1);
static double rt_remd_snf(double u0, double u1);

// Function Definitions

//
// Arguments    : double u0
//                double u1
// Return Type  : double
//
static double rt_powd_snf(double u0, double u1)
{
  double y;
  double d0;
  double d1;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    d0 = std::abs(u0);
    d1 = std::abs(u1);
    if (rtIsInf(u1)) {
      if (d0 == 1.0) {
        y = 1.0;
      } else if (d0 > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

//
// Arguments    : double u0
//                double u1
// Return Type  : double
//
static double rt_remd_snf(double u0, double u1)
{
  double y;
  double b_u1;
  double q;
  if (rtIsNaN(u0) || rtIsInf(u0) || (rtIsNaN(u1) || rtIsInf(u1))) {
    y = rtNaN;
  } else {
    if (u1 < 0.0) {
      b_u1 = std::ceil(u1);
    } else {
      b_u1 = std::floor(u1);
    }

    if ((u1 != 0.0) && (u1 != b_u1)) {
      q = std::abs(u0 / u1);
      if (std::abs(q - std::floor(q + 0.5)) <= DBL_EPSILON * q) {
        y = 0.0 * u0;
      } else {
        y = std::fmod(u0, u1);
      }
    } else {
      y = std::fmod(u0, u1);
    }
  }

  return y;
}

//
// Arguments    : double D
//                double N
//                emxArray_real_T *B
// Return Type  : void
//
void untitled(double D, double N, emxArray_real_T *B)
{
  emxArray_real_T *y;
  int k;
  double ndbl;
  double apnd;
  double u0;
  int nm1d2;
  emxArray_real_T *b_y;
  int n;
  emxInit_real_T(&y, 2);

  //@>14266
  if (                                 //@>1a522
      rtIsNaN(                         //@>14d8b
              N                        //@>14d89
              -                        //@>14d8c
              1.0)) {
    k =                                //@>17003
      y->size[0] *                     //@>17010
      y->size[1];

    //@>1701e
    y->size                            //@>1d9d4
      [                                //@>16165
      0]                               //@>156cd
      =                                //@>1d743
      1;

    //@>17165
    y->size                            //@>1d9d8
      [                                //@>161b2
      1]                               //@>156d9
      =                                //@>1d749
      1;
    emxEnsureCapacity_real_T(          //@>17057
      y, k);

    //@>17177
    y->data                            //@>1d9f6
      [                                //@>163a6
      0]                               //@>163ab
      =                                //@>1639a
      rtNaN;
  } else                               //@>14268
if (                                   //@>14bfe
    N                                  //@>14bfc
    -                                  //@>14bff
    1.0                                //@>14257
    <                                  //@>14277
    0.0) {
    //@>1704b
    y->size                            //@>1d9d6
      [                                //@>1618c
      0]                               //@>1571b
      =                                //@>1d740
      1;

    //@>1716f
    y->size                            //@>1d9da
      [                                //@>161d9
      1]                               //@>15727
      =                                //@>1d746
      0;
  } else                               //@>1426a
if (                                   //@>1a524
    rtIsInf(                           //@>14d90
            N                          //@>14d8e
            -                          //@>14d91
            1.0)                       //@>1a6c0
    && (                               //@>14c12
        N                              //@>14c10
        -                              //@>14c13
        1.0                            //@>14259
        ==                             //@>14278
        0.0)) {
    k =                                //@>171ad
      y->size[0] *                     //@>171ba
      y->size[1];

    //@>171c8
    y->size                            //@>1d9dc
      [                                //@>1622d
      0]                               //@>15777
      =                                //@>1d74c
      1;

    //@>171df
    y->size                            //@>1d9e2
      [                                //@>16344
      1]                               //@>15783
      =                                //@>1d752
      1;
    emxEnsureCapacity_real_T(          //@>171da
      y, k);

    //@>17224
    y->data                            //@>1da02
      [                                //@>164a2
      0]                               //@>164a7
      =                                //@>16496
      rtNaN;
  } else                               //@>1426e
if (                                   //@>1a526
    std::floor(                        //@>14d95
               N                       //@>14d93
               -                       //@>14d96
               1.0)                    //@>1425b
    ==                                 //@>14c30
    N                                  //@>14c2e
    -                                  //@>14c31
    1.0) {
    k =                                //@>17201
      y->size[0] *                     //@>1720e
      y->size[1];

    //@>1721c
    y->size                            //@>1d9de
      [                                //@>162b3
      0]                               //@>162b6
      =                                //@>1d74f
      1;

    //@>19b3e
    nm1d2                              //@>19b40
      =                                //@>19575
      (int)                            //@>1a530
      std::floor(-                     //@<19577
                 (                     //@>162bc
                  0.0                  //@>162bb
                  - (                  //@>18d5a
                     N                 //@>18d58
                     -                 //@>18d5b
                     1.0)));

    //@>1725c
    y->size                            //@>1d9e0
      [                                //@>162c7
      1]                               //@>162ca
      =                                //@>19b42
      nm1d2                            //@>162b8
      +                                //@>162c0
      1;
    emxEnsureCapacity_real_T(          //@>17257
      y, k);

    //@>162f3
    for (                              //@>1d7b3
         k =                           //@>162f0
         0;                            //@>1d7bb
         k <= nm1d2;                   //@>1d7b8
         k                             //@>1d7bd
         ++) {
      //@>172bd
      y->data[                         //@>162d8
        k]                             //@>162df
        = (                            //@>18d64
           N                           //@>18d62
           -                           //@>18d65
           1.0)                        //@>162d3
        -                              //@>197de
        (double)                       //@>162cd
        k;
    }
  } else {
    //@>14411
    ndbl                               //@>14410
      =                                //@>1a528
      std::floor((                     //@>14d9b
                  0.0                  //@>14d9a
                  - (                  //@>14d9e
                     N                 //@>14d9c
                     -                 //@>14d9f
                     1.0))             //@>14d99
                 /                     //@>14da0
                 -1.0                  //@>14d98
                 +                     //@>14da1
                 0.5);

    //@>1439c
    apnd                               //@>1439b
      = (                              //@>14c44
         N                             //@>14c42
         -                             //@>14c45
         1.0)                          //@>143d3
      + -                              //@<19563
      //@>1439f
      ndbl;

    //@>19d3c
    u0                                 //@>19d3e
      =                                //@>1a52a
      std::abs(                        //@>19bc3
               N                       //@>19bc1
               -                       //@>19bc4
               1.0);

    //@>19d69
    if (!                              //@<1a261
        (                              //@>19d57
         u0                            //@>19d59
         >                             //@>19e41
         0.0)) {
      //@>19d66
      u0                               //@>19d67
        =                              //@>19e45
        0.0;
    }

    //@>143e2
    if (                               //@>1a52c
        std::abs(                      //@>14da4
                 0.0                   //@>14da3
                 -                     //@>14da6
                 apnd)                 //@>143d6
        <                              //@>143f3
        4.4408920985006262E-16         //@>19561
        *                              //@>19d38
        u0) {
      //@>143aa
      ndbl                             //@>1d7be
        ++;

      //@>143af
      apnd                             //@>143ae
        =                              //@>143f4
        0.0;
    } else                             //@>143e5
  if (                                 //@>14c61
      0.0                              //@>14c60
      -                                //@>14c63
      apnd                             //@>143d8
      >                                //@>143b2
      0.0) {
      //@>143b4
      apnd                             //@>143b3
        = (                            //@>14c67
           N                           //@>14c65
           -                           //@>14c68
           1.0)                        //@>143da
        + -                            //@<1955e
        (                              //@>143b7
         ndbl                          //@>143d9
         -                             //@>143b9
         1.0);
    } else {
      //@>143bb
      ndbl                             //@>1d7bf
        ++;
    }

    //@>1a267
    if (                               //@>143c7
        ndbl                           //@>143dd
        >=                             //@>143c9
        0.0) {
      //@>1a26b
      n                                //@>1a26a
        =                              //@>1955c
        (int)                          //@>143cc
        ndbl;
    } else {
      //@>1a1d1
      n                                //@>1a1d0
        =                              //@>1d75b
        0;
    }

    k =                                //@>17442
      y->size[0] *                     //@>1744f
      y->size[1];

    //@>1745d
    y->size                            //@>1d9ea
      [                                //@>1681c
      0]                               //@>1681e
      =                                //@>1d75e
      1;

    //@>17470
    y->size                            //@>1d9ec
      [                                //@>16831
      1]                               //@>16833
      =                                //@>16809
      n;
    emxEnsureCapacity_real_T(          //@>1746b
      y, k);

    //@>14354
    if (                               //@>14376
        n                              //@>14301
        >                              //@>14367
        0) {
      //@>1747e
      y->data                          //@>1da22
        [                              //@>168c2
        0]                             //@>142bd
        =                              //@>14c71
        N                              //@>14c6f
        -                              //@>14c72
        1.0;

      //@>14356
      if (                             //@>1437a
          n                            //@>14302
          >                            //@>14369
          1) {
        //@>17553
        y->data[                       //@>16922
          n                            //@>17c0d
          -                            //@>17c0c
          1]                           //@>142c0
          =                            //@>1437e
          apnd;

        //@>1449c
        nm1d2                          //@>1449b
          = (                          //@>14c7d
             n                         //@>17c0a
             -                         //@>17c09
             1)                        //@>19555
          /                            //@>144a1
          2;

        //@>14358
        for (                          //@>1d7a7
             k =                       //@>14306
             0;                        //@>1d7af
             k <=                      //@>18d29
             nm1d2                     //@>17c00
             -                         //@>17bff
             2;                        //@>1d7ac
             k                         //@>1d7c3
             ++) {
          //@>1765b
          y->data[                     //@>18d45
            1                          //@>18d44
            +                          //@>18d47
            k]                         //@>142d0
            = (                        //@>14c87
               N                       //@>14c85
               -                       //@>14c88
               1.0)                    //@>1430e
            + -                        //@<19568
            (                          //@>18d4a
             1.0                       //@>18d49
             +                         //@>1981a
             (double)                  //@>18d4c
             k);

          //@>176b8
          y->data[(                    //@>16cdb
                   n                   //@>19845
                   -                   //@>18d51
                   k)                  //@>19848
            -                          //@>17c06
            2]                         //@>142d8
            =                          //@>14388
            apnd                       //@>1430f
            - (-                       //@<19564
               (                       //@>18d54
                1.0                    //@>18d53
                +                      //@>1982a
                (double)               //@>18d56
                k));
        }

        //@>1435e
        if (                           //@>14c9e
            nm1d2                      //@>19554
            <<                         //@>19553
            1                          //@>14310
            ==                         //@>14ca2
            n                          //@>17c04
            -                          //@>17c03
            1) {
          //@>1762d
          y->data[                     //@>16bbd
            nm1d2]                     //@>142e4
            = ((                       //@>14cc6
                N                      //@>14cc4
                -                      //@>14cc7
                1.0)                   //@>14312
               +                       //@>14390
               apnd)                   //@>14311
            /                          //@>142ea
            2.0;
        } else {
          //@>175ff
          y->data[                     //@>16b5f
            nm1d2]                     //@>142ef
            = (                        //@>14cac
               N                       //@>14caa
               -                       //@>14cad
               1.0)                    //@>14314
            + -                        //@<19549
            //@>1981f
            (double)                   //@>14cb2
            nm1d2;

          //@>17689
          y->data[                     //@>16c7b
            nm1d2                      //@>16c79
            +                          //@>16c7c
            1]                         //@>142f7
            =                          //@>1438c
            apnd                       //@>14315
            - (-                       //@<19545
          //@>19836
               (double)                //@>14cbd
               nm1d2);
        }
      }
    }
  }

  emxInit_real_T(&b_y, 2);

  //@>1456d
  nm1d2                                //@>1456c
    =                                  //@>171ea
    y->size[                           //@>1646c
    1];
  k =                                  //@>1726e
    b_y->size[0] *                     //@>1727b
    b_y->size[1];

  //@>17289
  b_y->size                            //@>1d9e4
    [                                  //@>1653f
    0]                                 //@>16541
    =                                  //@>1d758
    1;

  //@>1729e
  b_y->size                            //@>1d9e6
    [                                  //@>16554
    1]                                 //@>16556
    =                                  //@>172a8
    y->size[                           //@>1652d
    1];
  emxEnsureCapacity_real_T(            //@>17299
    b_y, k);

  //@>145af
  for (                                //@>1d79a
       k =                             //@>14593
       0;                              //@>1d7a2
       k <                             //@>145b9
       nm1d2;                          //@>1d79f
       k                               //@>1d7c0
       ++) {
    //@>17336
    b_y->data[                         //@>18d2b
      k]                               //@>145ec
      =                                //@>1a53c
      rt_powd_snf(                     //@>145f1
                  2.0,                 //@>17365
                  y->data[             //@>18d2d
                  k]);
  }

  emxFree_real_T(&y);

  //@>15813
  k                                    //@>15815
    =                                  //@>172ed
    b_y->size[                         //@>1658a
    0]                                 //@>1953f
    *                                  //@>172f8
    b_y->size[                         //@>165b6
    1];
  nm1d2 =                              //@>17312
    b_y->size[0] *                     //@>1731f
    b_y->size[1];

  //@>1732d
  b_y->size                            //@>1d9e8
    [                                  //@>165e0
    0]                                 //@>1584c
    =                                  //@>1d761
    1;
  emxEnsureCapacity_real_T(            //@>173a2
    b_y, nm1d2);

  //@>15dc9
  nm1d2                                //@>15dcb
    =                                  //@>15dc2
    k                                  //@>17c10
    -                                  //@>17c0f
    1;

  //@>167ae
  for (                                //@>1d78e
       k =                             //@>167ab
       0;                              //@>1d796
       k <=                            //@>18d2f
       nm1d2;                          //@>1d793
       k                               //@>1d7c1
       ++) {
    //@>173da
    b_y->data[                         //@>1679a
      k]                               //@>167a1
      =                                //@>1678b
      D                                //@>16789
      /                                //@>17409
      b_y->data[                       //@>16790
      k];
  }

  //@>1468e
  nm1d2                                //@>1468d
    =                                  //@>173cf
    b_y->size[                         //@>16861
    1];

  //@>146c2
  for (                                //@>1d781
       k =                             //@>146a7
       0;                              //@>1d789
       k <                             //@>146c7
       nm1d2;                          //@>1d786
       k                               //@>1d7c2
       ++) {
    //@>174d7
    b_y->data[                         //@>18d31
      k]                               //@>146cd
      =                                //@>1a542
      std::floor(                      //@>17505
                 b_y->data[            //@>18d33
                 k]);
  }

  k =                                  //@>174b3
    B->size[0] *                       //@>174c0
    B->size[1];

  //@>174ce
  B->size                              //@>1d9ee
    [                                  //@>169b7
    0]                                 //@>169b9
    =                                  //@>1d764
    1;

  //@>1753f
  B->size                              //@>1d9f0
    [                                  //@>169cc
    1]                                 //@>169ce
    =                                  //@>17549
    b_y->size[                         //@>169a5
    1];
  emxEnsureCapacity_real_T(            //@>1753a
    B, k);

  //@>147ab
  nm1d2                                //@>147aa
    =                                  //@>17582
    b_y->size[                         //@>16a3b
    1];

  //@>147f1
  for (                                //@>1d774
       k =                             //@>147cc
       0;                              //@>1d77c
       k <                             //@>147f6
       nm1d2;                          //@>1d779
       k                               //@>1d7c4
       ++) {
    //@>1759a
    B->data[                           //@>18d35
      k]                               //@>147fc
      =                                //@>1a546
      rt_remd_snf(                     //@>175c9
                  b_y->data[           //@>18d37
                  k],                  //@>14801
                  2.0);
  }

  emxFree_real_T(&b_y);
}

//
// File trailer for untitled.cpp
//
// [EOF]
//
