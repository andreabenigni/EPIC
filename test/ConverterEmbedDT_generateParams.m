% Generates parameters for Converter Embed Digital Twin Model
% Matthew Milton
% 03.27.2019
%===================================================================

close all;
clear all;
clc;

addpath('../util');
addpath('../');

%===================================================================

NVAR = 2;
ORDER = 2;

initPCT(NVAR, ORDER);
beep;
clc;

%===================================================================

DT      = 600.0e-6;
C       = 1800.0e-6;
ROUT    = 16.0;
ROUT2   = 16.0*32.0/(16.0+32.0);
ONE     = 1.0;

TOLERANCE_PERCENTAGE_C = 0.05;
TOLERANCE_PERCENTAGE_R = 0.02;

C_STOC     = pct(C,     (C*TOLERANCE_PERCENTAGE_C),     1);
ROUT_STOC  = pct(ROUT,  (ROUT*TOLERANCE_PERCENTAGE_R),  2);
ROUT2_STOC = pct(ROUT2, (ROUT2*TOLERANCE_PERCENTAGE_R), 2);

DToC   = DT/C_STOC;
DToRC  = DT/ROUT_STOC/C_STOC;
GOUT1  = ONE/ROUT_STOC;
Z1     = ONE/(ONE + DToRC);
DToRC2 = DT/ROUT2_STOC/C_STOC;
GOUT2  = ONE/ROUT2_STOC;
Z2     = ONE/(ONE + DToRC2);

%===================================================================

format long;

fprintf('=====');

DToC.val

GOUT1.val

Z1.val

GOUT2.val

Z2.val

%===================================================================
beep;