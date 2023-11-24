close all;
clear all;
clc;

addpath('util');

nvar = 3;
order = 2;

initPCT(nvar, order);

temp = pct(0,0,0);

p = temp.getP();

ret = importPCTDataFromCPP('buckConverterEPICResults.csv',p, 4)