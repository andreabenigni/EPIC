clear all;
close all;
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               EPIC2: Easy Polynomial Chaos (v.2.1.0)               %%%
%%%         Authors: M. Milton, A. Benigni, S. Schwarz, A. Monti       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File Name: testcos.m (gaussian)                                    %%%
%%% This example tests the cosine overloading operator, the results    %%%
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

NUM_UNCERTAIN_VARIABLES = 1;
ORDER = 8;

PC_SPACE_GAUSSIAN = PolynomialChaosSpace(NUM_UNCERTAIN_VARIABLES, ORDER, 'gaussian');
PC_SPACE_GAUSSIAN.computeInnerProductsForHermitePolynomials();


% Polynomial Chaos
c = pce(PC_SPACE_GAUSSIAN,0.2,0.4,1);

cos_a = cos(c);
cos_b = cos(c)-2*cos(c/3);
cos_c = cos(c).*cos(c);

% Monte-Carlo
sample = 10000;
c_mc = gaussian(0.2,0.4,sample);

c1 = cos(c_mc);
c2 = cos(c_mc)-2*cos(c_mc/3);
c3 = cos(c_mc).*cos(c_mc);

% Resampling of PC variables
c1p = resample(cos_a,sample);
c2p = resample(cos_b,sample);
c3p = resample(cos_c,sample);

figure(1)
minlim = min(min(c1),min(c1p));
maxlim = max(max(c1),max(c1p));
[n1,p1]=hist(c1,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c1p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(c2),min(c2p));
maxlim = max(max(c2),max(c2p));
[n1,p1]=hist(c2,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c2p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(c3),min(c3p));
maxlim = max(max(c3),max(c3p));
[n1,p1]=hist(c3,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(c3p,[minlim:abs(maxlim-minlim)/100:maxlim]);
bar(p1,n1);hold on; bar(p2,n2,'facecolor','none', 'EdgeColor','r')
