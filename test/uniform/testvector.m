clear all;
close all;
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               EPIC2: Easy Polynomial Chaos (v.2.1.0)               %%%
%%%         Authors: M. Milton, A. Benigni, S. Schwarz, A. Monti       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testvector.m (uniform)                                  %%%
%%% This example tests the vector overloading operator, the results    %%%
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

PC_SPACE_UNIFORM = PolynomialChaosSpace(NUM_UNCERTAIN_VARIABLES, ORDER, 'uniform');
PC_SPACE_UNIFORM.computeInnerProductsForLegendrePolynomials();


% Polynomial Chaos
a = pce(PC_SPACE_UNIFORM,3,0.5,1);
b = pce(PC_SPACE_UNIFORM,10,5,2);

a1 = [a b 5; b 3 4];
b1 = [b a b; b -1 a];

c1 = a1+b1;
c2 = a1-b1;
c3 = a1.*b1;
c4 = [2 b; -2 a]*a1;
c5 = [a b; a 5]^3;

% Monte-Carlo
sample = 10000;
a_mc = uniform(2.5,3.5,sample);
b_mc = uniform(5,15,sample);

c111 = a_mc+b_mc;
c211 = a_mc-b_mc;
c213 = 5-b_mc;
c323 = 4*a_mc;
c321 = b_mc.*b_mc;
c411 = b_mc.*b_mc+2.*a_mc;
c423 = 4.*a_mc-10;
c521 = 25.*a_mc + a_mc.*(a_mc.^2 + b_mc.*a_mc) + 5.*a_mc.^2;

% Resampling of PC variables
c111p = resample(c1(1,1),sample);
c211p = resample(c2(1,1),sample);
c213p = resample(c2(1,3),sample);
c323p = resample(c3(2,3),sample);
c321p = resample(c3(2,1),sample);
c411p = resample(c4(1,1),sample);
c423p = resample(c4(2,3),sample);
c521p = resample(c5(2,1),sample);

figure(1)
minlim = min(min(c111),min(c111p));
maxlim = max(max(c111),max(c111p));
[n1,p1]=hist(c111,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c111p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c211),min(c211p));
maxlim = max(max(c211),max(c211p));
[n1,p1]=hist(c211,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c211p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(c213),min(c213p));
maxlim = max(max(c213),max(c213p));
[n1,p1]=hist(c213,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c213p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(4)
minlim = min(min(c323),min(c323p));
maxlim = max(max(c323),max(c323p));
[n1,p1]=hist(c323,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c323p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(5)
minlim = min(min(c321),min(c321p));
maxlim = max(max(c321),max(c321p));
[n1,p1]=hist(c321,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c321p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(6)
minlim = min(min(c411),min(c411p));
maxlim = max(max(c411),max(c411p));
[n1,p1]=hist(c411,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c411p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(7)
minlim = min(min(c423),min(c423p));
maxlim = max(max(c423),max(c423p));
[n1,p1]=hist(c423,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c423p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(8)
minlim = min(min(c521),min(c521p));
maxlim = max(max(c521),max(c521p));
[n1,p1]=hist(c521,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c521p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')
