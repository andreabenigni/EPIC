clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testpower.m                                             %%%
%%% This example tests the power overloading operator,                 %%%
%%% the results obtained using the EPIC tool are compared for          %%%
%%% consistency with the one obtained using Monte Carlo approach.      %%%
%%% Power operation x^a with a of type PCT not supported               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of EPIC.                                             %
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

initPCT(2,3);


%Polinomyal Chaos
a = pct(3,0.5,1);

b = [a a;
     a 5];

c1 = b^2;
c2 = a^5;


%montecarlo
sample = 10000;
a_mc = uniform(2.5,3.5,sample);


c111_mc = a_mc.*a_mc+a_mc.*a_mc;
c2_mc = a_mc.^5;

%Resampling of PC variables
c1_pc = resample(c1(1,1),sample);
c2_pc = resample(c2,sample);


figure(1)
minlim = min(min(c1_pc),min(c111_mc));
maxlim = max(max(c1_pc),max(c111_mc));
[n1,p1]=hist(c1_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c111_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c2_pc),min(c2_mc));
maxlim = max(max(c2_pc),max(c2_mc));
[n1,p1]=hist(c2_pc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c2_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')
