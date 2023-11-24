% Generates parameters for HalfBridge DCDC1 full Digital Twin Model
% Matthew Milton
% 06.06.2019
%===================================================================

close all;
clear all;
clc;

addpath('../util');
addpath('../');

%===================================================================

NVAR = 4;
ORDER = 2;

initPCT(NVAR, ORDER);
beep;
clc;

%===================================================================

ONE     = 1.0;       
DT      = 1.0e-6;
R_G     = 0.001;     
G_G     = ONE/R_G;   
C_DCI   = 1000.0e-6;	
L_DCO   = 10000.0e-6;
C_DCO   = 100.0e-6;	
R_LOAD  = 10.0;	   
G_LOAD  = ONE/R_LOAD;

TOLERANCE_PERCENTAGE = 0.1;

C_DCI_STOC  = pct(C_DCI , C_DCI*TOLERANCE_PERCENTAGE , 1);
L_DCO_STOC  = pct(L_DCO , L_DCO*TOLERANCE_PERCENTAGE , 2);
C_DCO_STOC  = pct(C_DCO , C_DCO*TOLERANCE_PERCENTAGE , 3);
R_LOAD_STOC = pct(R_LOAD, R_LOAD*TOLERANCE_PERCENTAGE, 4);

DToC_DCO    = DT/C_DCO_STOC;
DToC_DCI    = DT/C_DCI_STOC;
DToL_DCO    = DT/L_DCO_STOC;
G_LOAD_STOC = ONE/R_LOAD_STOC;


%===================================================================

format long;

fprintf('=====\n');

fprintf('DToC_DCO\n');
num2str(DToC_DCO.val,15)

fprintf('DToC_DCI\n');
num2str(DToC_DCI.val,15)

fprintf('DToL_DCO\n');
num2str(DToL_DCO.val,15)

fprintf('G_LOAD_STOC\n');
num2str(G_LOAD_STOC.val,15)

%===================================================================
beep;