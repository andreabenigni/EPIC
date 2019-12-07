clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testsin.m                                              %%%
%%% This example tests the sin overloading operator,                   %%%
%%% the results obtained using the EPIC tool are compared for          %%%
%%% consistency with the one obtained using Monte Carlo approach.      %%%
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

initPCT(1,6);


%Polynomial Chaos
c = pct(pi/2,pi/2,1);

sine = sin(c);

%montecarlo
sample = 10000;
c_mc = uniform(0,pi,sample);

c111 = sin(c_mc);

%Resampling of PC variables
c111p = resample(sine,sample);

figure(1)
minlim = min(min(c111),min(c111p));
maxlim = max(max(c111),max(c111p));
[n1,p1]=hist(c111,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c111p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

