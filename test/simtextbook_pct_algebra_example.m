close all;
clear all;
clc;


addpath('..\');
addpath('..\util');

NVARIABLES = 1;
ORDER  = 1;

[nvar_,ord_,P_,C_,D_,doublek_] = initPCT(NVARIABLES,ORDER);

pct_test_object = pct(0,0,0);
P = pct_test_object.getP();

A = pct(0,0,0);
B = pct(0,0,0);
A.val = [10,0.5];
B.val = [5,-0.1];

C_add = A+B;
C_sub = A-B;
C_mul = A*B;
C_div = A/B;