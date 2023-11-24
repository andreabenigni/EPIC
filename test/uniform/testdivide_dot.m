close all;
clear all;
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               EPIC2: Easy Polynomial Chaos (v.2.1.0)               %%%
%%%         Authors: M. Milton, A. Benigni, S. Schwarz, A. Monti       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testdivide_dot.m (uniform)                              %%%
%%% This example tests the dot division overloading operator,          %%%
%%% the resultsobtained using the EPIC2 tool are compared for          %%%
%%% consistency with the one obtained using Monte-Carlo approach.      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of EPIC2.                                            %
%                                                                        %
% EPIC is free software: you can redistribute it and/or modify           %
% it under the terms of the GNU General Public License as published by   %
% the Free Software Foundation, either version 3 of the License, or      %
% (at your option) any later version.                                    %
%                                                                        %
% EPIC is distributed in the hope that it will be useful,                %
% but WITHOUT ANY WARRANTY; without even the implied warranty of         %
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          %
% GNU General Public License for more details.                           %
%                                                                        %
% You should have received a copy of the GNU General Public License      %
% along with EPIC.  If not, see <http://www.gnu.org/licenses/>.          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NUM_UNCERTAIN_VARIABLES = 3;
ORDER = 3;

PC_SPACE_UNIFORM = PolynomialChaosSpace(NUM_UNCERTAIN_VARIABLES, ORDER, 'uniform');
PC_SPACE_UNIFORM.computeInnerProductsForLegendrePolynomials();


% Polynomial Chaos
a = pce(PC_SPACE_UNIFORM,3,0.5,1);
b = pce(PC_SPACE_UNIFORM,10,5,2);

a1 = [a b a; a a b];
b1 = [b a a; b b b];

c1 = a./b;
c2 = 3./b;
c3 = a./3;
c4 = b1./a1;
c5 = a./a1;
c6 = a1./b;
c7 = 3./a1;
c8 = a1./3;

% Monte-Carlo
sample = 10000;
a_mc = uniform(2.5,3.5,sample);
b_mc = uniform(5,15,sample);

c1_mc = a_mc./b_mc;
c2_mc = 3./b_mc;
c3_mc = a_mc./3;
c412_mc = a_mc./b_mc;
c523_mc = a_mc./b_mc;
c621_mc = a_mc./b_mc;
c712_mc = 3./b_mc;
c823_mc = b_mc./3;

% Resampling of PC variables
c1_pc = resample(c1,sample);
c2_pc = resample(c2,sample);
c3_pc = resample(c3,sample);
c412_pc = resample(c4(1,2),sample);
c523_pc = resample(c5(2,3),sample);
c621_pc = resample(c6(2,1),sample);
c712_pc = resample(c7(1,2),sample);
c823_pc = resample(c8(2,3),sample);

figure(1)
minlim = min(min(c1_pc),min(c1_mc));
maxlim = max(max(c1_pc),max(c1_mc));
[n1,p1]=hist(c1_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c1_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c2_pc),min(c2_mc));
maxlim = max(max(c2_pc),max(c2_mc));
[n1,p1]=hist(c2_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c2_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(c3_pc),min(c3_mc));
maxlim = max(max(c3_pc),max(c3_mc));
[n1,p1]=hist(c3_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c3_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(4)
minlim = min(min(c412_pc),min(c412_mc));
maxlim = max(max(c412_pc),max(c412_mc));
[n1,p1]=hist(c412_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c412_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(5)
minlim = min(min(c523_pc),min(c523_mc));
maxlim = max(max(c523_pc),max(c523_mc));
[n1,p1]=hist(c523_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c523_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(6)
minlim = min(min(c621_pc),min(c621_mc));
maxlim = max(max(c621_pc),max(c621_mc));
[n1,p1]=hist(c621_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c621_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(7)
minlim = min(min(c712_pc),min(c712_mc));
maxlim = max(max(c712_pc),max(c712_mc));
[n1,p1]=hist(c712_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c712_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(8)
minlim = min(min(c823_pc),min(c823_mc));
maxlim = max(max(c823_pc),max(c823_mc));
[n1,p1]=hist(c823_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c823_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')