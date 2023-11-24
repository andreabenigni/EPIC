% Generates parameters for HalfBridge DCDC1 current control (simple) Digital Twin Model
% Matthew Milton
% 06.04.2019
%===================================================================

close all;
clear all;
clc;

addpath('../util');
addpath('../');

%===================================================================

NVAR = 1;
ORDER = 2;

initPCT(NVAR, ORDER);
beep;
clc;

%===================================================================

DT      = 1.0e-6;
L       = 10000.0e-6;

TOLERANCE_PERCENTAGE = 0.1;

L_STOC = pct(L, L*TOLERANCE_PERCENTAGE, 1);

Z = DT/L_STOC;

%===================================================================

format long;

fprintf('=====\n');

fprintf('Z (DT/L)\n');
Z.val

%===================================================================
beep;