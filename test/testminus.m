clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testminus.m                                             %%%
%%% This example tests the minus overloading operator, the results    %%%
%%% obtained using the EPIC tool are compared for consistency with     %%%
%%% the one obtained using Monte Carlo approach.                       %%%
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


%Polynomial Chaos
a = pct(3,0.5,1);
b = pct(10,5,2);

a1 = [a b 5;
      a 3 b];
b1 = [b a b;
      b 1 a];

c1 = a1-b1;
c2 = 3-a1;
c3 = a1-3;
c4 = a-5;


%montecarlo
sample = 10000;
a_mc = uniform(2.5,3.5,sample);
b_mc = uniform(5,15,sample);

c111 = a_mc-b_mc;
c123 = b_mc-a_mc;
c211 = 3-a_mc;
c223 = 3-b_mc;
c311 = a_mc-3;
c411 = a_mc-5;


%Resampling of PC variables
c111p = resample(c1(1,1),sample);
c123p = resample(c1(2,3),sample);
c211p = resample(c2(1,1),sample);
c223p = resample(c2(2,3),sample);
c311p = resample(c3(1,1),sample);
c322p = resample(c3(2,2),sample);
c411p = resample(c4(1,1),sample);


figure(1)
minlim = min(min(c111),min(c111p));
maxlim = max(max(c111),max(c111p));
[n1,p1]=hist(c111,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c111p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c123),min(c123p));
maxlim = max(max(c123),max(c123p));
[n1,p1]=hist(c123,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c123p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(c211),min(c211p));
maxlim = max(max(c211),max(c211p));
[n1,p1]=hist(c211,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c211p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(4)
minlim = min(min(c223),min(c223p));
maxlim = max(max(c223),max(c223p));
[n1,p1]=hist(c223,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c223p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(5)
minlim = min(min(c311),min(c311p));
maxlim = max(max(c311),max(c311p));
[n1,p1]=hist(c311,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c311p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(6)
minlim = min(min(c411),min(c411p));
maxlim = max(max(c411),max(c411p));
[n1,p1]=hist(c411,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c411p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

