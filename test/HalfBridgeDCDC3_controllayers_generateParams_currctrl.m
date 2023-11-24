% Generates PCT parameters for Half-Bridge Converter Control Layer 
% Model (Current Control)
%
% Matthew Milton
% 04.30.2019
%===================================================================

close all;
clear all;
clc;

addpath('../util');
addpath('../');

%===================================================================

NVAR = 5;
ORDER = 2;

[nvar_,ord_,P_,C_,D_,doublek_] = initPCT(NVAR, ORDER);
beep;
clc;

%===================================================================

ONE = 1.0;

DT  = 1.0e-6;
C  = 1000.0e-6;
L  = 10000.0e-6;
R  = 0.001;

TOLERANCE = 0.10;

CP_STOC     = pct(C,     (C*TOLERANCE),     1);
CN_STOC     = pct(C,     (C*TOLERANCE),     2);
LA_STOC     = pct(L,     (L*TOLERANCE),     3);
LB_STOC     = pct(L,     (L*TOLERANCE),     4);
LC_STOC     = pct(L,     (L*TOLERANCE),     5);

Z1P = ( ONE - DT/R/CP_STOC );
Z2P = ( DT/R/CP_STOC );
Z3P = ( DT/CP_STOC );
Z4N = ( ONE - DT/R/CN_STOC );
Z5N = ( DT/R/CN_STOC );
Z6N = ( DT/CN_STOC );
Z7A = ( DT/LA_STOC );
Z8B = ( DT/LB_STOC );
Z9C = ( DT/LC_STOC );

%===================================================================

format long;

diary on

fprintf('=====\n');
fprintf('Current Control:  Euler Forward PCT Parameters\n\n');

fprintf('Z1P:');
num2str(Z1P.val,15)

fprintf('Z2P:');
num2str(Z2P.val,15)

fprintf('Z3P:');
num2str(Z3P.val,15)

fprintf('Z4N:');
num2str(Z4N.val,15)

fprintf('Z5N:');
num2str(Z5N.val,15)

fprintf('Z6N:');
num2str(Z6N.val,15)

fprintf('Z7A:');
num2str(Z7A.val,15)

fprintf('Z8B:');
num2str(Z8B.val,15)

fprintf('Z9C:');
num2str(Z9C.val,15)

diary off

%===================================================================
beep;