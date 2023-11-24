close all;
clear all;
clc;

addpath('../util');

%=======================================================
nvar = 1;
ord  = 1;

exportPCTParametersToCPP(nvar,ord,'example_pct_params_061019.hpp');

%=======================================================
% nvar = 4;
% ord  = 2;
% 
% exportPCTParametersToCPP(nvar,ord,'buck_converter_pct_parameters_060619.hpp');

%=======================================================
% nvar = 8;
% ord  = 2;
% 
% fprintf('Computing PCT Parameters...\n');
% 
% [nvar,ord,P,C,D,doublek] = exportPCTParametersToCPP(nvar,ord,'BipHalfBridge3_pct_parameters.hpp');

%=======================================================
%  nvar = 18;
%  ord  = 2;


% nvar = 2;
% ord  = 2;
%  
%  fprintf('Computing PCT Parameters...\n');
%  
%  [nvar,ord,P,C,D,doublek] = exportPCTParametersToCPP(nvar,ord,'ConverterEmbedDT_PCT_parameters.hpp');
%  
% P
% 
% fprintf('...DONE.\n'); beep;

% %=======================================================
% nvar = 2;
% ord  = 2;
%  
%  fprintf('Computing PCT Parameters...\n');
%  
%  [nvar,ord,P,C,D,doublek] = exportPCTParametersToCPP(nvar,ord,'halfbridgeDCDC3_voltctrl_PCT_parameters.hpp');
%  
% P
% 
% fprintf('...DONE.\n'); beep;

%=======================================================
% 06.04.2019.T
% nvar = 1;
% ord  = 2;
%  
%  fprintf('Computing PCT Parameters...\n');
%  
%  [nvar,ord,P,C,D,doublek] = exportPCTParametersToCPP(nvar,ord,'halfbridgeDCDC1_currctrl_simple_PCT_parameters.hpp');
%  
% P
% 
% fprintf('...DONE.\n'); beep;

%=======================================================
% nvar = 5;
% ord  = 2;
%  
%  fprintf('Computing PCT Parameters...\n');
%  
%  [nvar,ord,P,C,D,doublek] = exportPCTParametersToCPP(nvar,ord,'halfbridgeDCDC3_currctrl_PCT_parameters.hpp');
%  
% P
% 
% fprintf('...DONE.\n'); beep;