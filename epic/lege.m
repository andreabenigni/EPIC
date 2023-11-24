function y = lege(x,n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               EPIC2: Easy Polynomial Chaos (v.2.1.0)               %%%
%%%         Authors: M. Milton, A. Benigni, S. Schwarz, A. Monti       %%%
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

% \brief evaluates a Legendre polynomial of order n at point(s) x
%
% ...
%
% \param x the point value(s) to evaluate the polynomial at
% \param n the order (or degree) of the polynomial that is to be evaluated
% \return y the result of the evaluated polynomial

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
        ch1 = -(i-1).*chz2;
        ch2 = (2*i-1).*chz1;
        ch2 = shiftleft(ch2);
        ch = ch1+ch2;
        ch = 1/i.*ch;
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

    