% Study on how distributions change when variables are operated on

%===================================================================================================
% CLEAN UP

close all;
clear all;
clc;

%===================================================================================================
% PATHS

addpath('../');
addpath('../util');

%===================================================================================================
% SYSTEM PARAMETERS

NSAMPLES = 10000;
NVARIABLES = 2;
ORDER  = 2;

%===================================================================================================
% PCE TYPE INITIALIZATION

fprintf('initalizing PCE type...\n');

[nvar_,ord_,P_,C_,D_,doublek_] = initPCT(NVARIABLES,ORDER);

pct_test_object = pct(0,0,0);
P = pct_test_object.getP();

fprintf('initalizing DONE.\n\n');

%===================================================================================================
% PCE VARAIBLES

A = pct(3,3*0.1,1);
B = pct(5,5*0.1,2);

%===================================================================================================
% OPERATIONS

fprintf('computing with PCE variables...\n');

C_add = A+B;
C_sub = A-B;
C_mul = A*B;
C_div = A/B;
C_sin = sin(A);
C_muladd = A*B+A;
C_divsub = A/B-A;
C_pow2 = A^2;
C_pow3 = A^3;
C_pow4 = A^4;
C_pow10 = A^10;
C_mulsub = A*B-A;
C_divadd = A/B+A;
C_poly = A*B + A*C_add + B*C_sub;

fprintf('DONE.\n');

%===================================================================================================
% SAMPLING OF THE PCE VARIABLES

fprintf('sampling PCE variables...\n');

A_sampled     = resample( A, NSAMPLES);
B_sampled     = resample( B, NSAMPLES);
C_add_sampled = resample( C_add, NSAMPLES);
C_sub_sampled = resample( C_sub, NSAMPLES);
C_mul_sampled = resample( C_mul, NSAMPLES);
C_div_sampled = resample( C_div, NSAMPLES);
C_sin_sampled = resample( C_sin, NSAMPLES);
C_muladd_sampled = resample( C_muladd, NSAMPLES);
C_divsub_sampled = resample( C_divsub, NSAMPLES);
C_pow2_sampled = resample( C_pow2, NSAMPLES);
C_pow3_sampled = resample( C_pow3, NSAMPLES);
C_pow4_sampled = resample( C_pow4, NSAMPLES);
C_pow10_sampled = resample( C_pow10, NSAMPLES);
C_mulsub_sampled = resample( C_mulsub, NSAMPLES);
C_divadd_sampled = resample( C_divadd, NSAMPLES);
C_poly_sampled = resample( C_poly, NSAMPLES);

fprintf('DONE.\n');

%===================================================================================================
% PLOTTING BASIC HISTOGRAMS OF OPERATION RESULTS

figure; hist(A_sampled, 100); title('A');
figure; hist(B_sampled, 100); title('B');
figure; hist(C_add_sampled, 100); title('add');
figure; hist(C_sub_sampled, 100); title('sub');
figure; hist(C_mul_sampled, 100); title('mul');
figure; hist(C_div_sampled, 100); title('div');
figure; hist(C_sin_sampled, 100); title('sin');
figure; hist(C_muladd_sampled, 100); title('mul+add');
figure; hist(C_divsub_sampled, 100); title('div+sub');
figure; hist(C_pow2_sampled, 100); title('pow2');
figure; hist(C_pow3_sampled, 100); title('pow3');
figure; hist(C_pow4_sampled, 100); title('pow4');
figure; hist(C_pow10_sampled, 100); title('pow10');
figure; hist(C_mulsub_sampled, 100); title('mul+sub');
figure; hist(C_divadd_sampled, 100); title('div+add');
figure; hist(C_poly_sampled, 100); title('poly');

%===================================================================================================
