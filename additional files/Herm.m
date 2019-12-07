function y = Herm(x,n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
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


ch = zeros(1,n+1);

if n == 0
    y = 1;
elseif n==1
    y = x;
else
    chz2 = zeros(1,n+1);
    chz2(n+1) = 1;
    chz1 = zeros(1,n+1);
    chz1(n) = 1;
    
    for i=2:n
        ch1 = -1*(i-1).*chz2;
        ch2 = 1.*chz1;
        ch2 = shiftleft(ch2);
        ch = ch1+ch2;
        chz2 = chz1;
        chz1 = ch;
    end
    y = polyval(ch,x);
end



function v = shiftleft(ch)
p = length(ch);

for i=1:p-1;
    v(i)=ch(i+1);
end
v(p)=0;

    