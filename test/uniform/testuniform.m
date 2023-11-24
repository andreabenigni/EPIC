clear all;
close all;
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               EPIC2: Easy Polynomial Chaos (v.2.1.0)               %%%
%%%         Authors: M. Milton, A. Benigni, S. Schwarz, A. Monti       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testuniform.m (uniform)                                 %%%
%%% This example tests the uniform distribution, the results           %%%
%%% obtained using the EPIC2 tool are compared for consistency with    %%%
%%% the one obtained using Monte-Carlo approach.                       %%%
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

NUM_UNCERTAIN_VARIABLES = 2;
ORDER = 3;

% We look into uniform-distributed PCT variables (--> we require Legendre Polynomials):
PC_SPACE_UNIFORM = PolynomialChaosSpace(NUM_UNCERTAIN_VARIABLES, ORDER, 'uniform');
PC_SPACE_UNIFORM.computeInnerProductsForLegendrePolynomials();

% Let p~U(p_a=-1, p_b=1) and q~U(q_a=3, q_b=17):
p_a = -1;
p_b = 1;
q_a = 3;
q_b = 17;

% Definition of the random variables in PCT and MC domain:
p = pce(PC_SPACE_UNIFORM,(p_a+p_b)/2,p_b-(p_a+p_b)/2,1);
q = pce(PC_SPACE_UNIFORM,(q_a+q_b)/2,q_b-(q_a+q_b)/2,2);

p_mc = unifrnd(p_a,p_b,10000,1);
q_mc = unifrnd(q_a,q_b,10000,1);

% First, compare the random variables in the different domains against each other:
p_pct = resample(p, 10000);
q_pct = resample(q, 10000);

figure(1)
minlim = min(min(p_pct),min(p_mc));
maxlim = max(max(p_pct),max(p_mc));
[n1,p1]=hist(p_pct,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(p_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(q_pct),min(q_mc));
maxlim = max(max(q_pct),max(q_mc));
[n1,p1]=hist(q_pct,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(q_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

% Second, compare the sum of both random variables in the different domains against each other:
x = p+q;
x_pct = resample(x, 10000);

x_mc = p_mc + q_mc;

figure(3)
minlim = min(min(x_pct),min(x_mc));
maxlim = max(max(x_pct),max(x_mc));
[n1,p1]=hist(x_pct,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(x_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')


% Third, compare the product of both random variables in the different domains against each other:
y = p*q;
y_pct = resample(y, 10000);

y_mc = p_mc .* q_mc;

figure(4)
minlim = min(min(y_pct),min(y_mc));
maxlim = max(max(y_pct),max(y_mc));
[n1,p1]=hist(y_pct,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(y_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')
