clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testu.m                                                 %%%
%%% This example tests the uplus and uminus operator overloading,      %%%
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

initPCT(2,3);


%Polinomyal Chaos
a = pct(3,0.5,1);
b = pct(10,5,2);

a1 = [a b 5;
      a 3 b];

c1 = +a;
c2 = -a;
c3 = +a1;
c4 = -a1;

%montecarlo
sample = 10000;
a_mc = uniform(2.5,3.5,sample);
b_mc = uniform(5,15,sample);

c1_mc = +a_mc;
c2_mc = -a_mc;
c311_mc = +a_mc;
c412_mc = -b_mc;

%Resampling of PC variables
c1p = resample(c1,sample);
c2p = resample(c2,sample);
c311p = resample(c3(1,1),sample);
c412p = resample(c4(1,2),sample);


figure(1)
minlim = min(min(c1_mc),min(c1p));
maxlim = max(max(c1_mc),max(c1p));
[n1,p1]=hist(c1_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c1p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c2_mc),min(c2p));
maxlim = max(max(c2_mc),max(c2p));
[n1,p1]=hist(c2_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c2p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(c311_mc),min(c311p));
maxlim = max(max(c311_mc),max(c311p));
[n1,p1]=hist(c311_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c311p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(4)
minlim = min(min(c412_mc),min(c412p));
maxlim = max(max(c412_mc),max(c412p));
[n1,p1]=hist(c412_mc,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c412p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')


