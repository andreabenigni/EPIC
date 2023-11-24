% Generates PCT parameters for Half-Bridge Converter Control Layer 
% Model (Voltage Control)
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

NVAR = 2;
ORDER = 2;

[nvar_,ord_,P_,C_,D_,doublek_] = initPCT(NVAR, ORDER);
beep;
clc;

%===================================================================

ONE = 1.0;

DT  = 1.0e-6;
C  = 100.0e-6;
R  = 10.0;

TOLERANCE = 0.10;

C_STOC     = pct(C,     (C*TOLERANCE),     1);
R_STOC     = pct(R,     (R*TOLERANCE),     2);

Z1 = ( ONE - DT/(R_STOC*C_STOC) );
Z2 = ( DT/C_STOC );

%===================================================================

format long;

fprintf('=====\n');
fprintf('Voltage Control:  Euler Forward PCT Parameters\n\n');

fprintf('P:');
P_

fprintf('Z1:');
Z1.val

fprintf('Z2:');
Z2.val

%===================================================================
beep;