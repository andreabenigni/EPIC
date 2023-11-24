function ret = evaluateHermitePolynomial(x,order)

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

% \brief evaluates a Probabilist's Hermite polynomial of order n at point(s) x
%
% ...
%
% \param x the point value(s) to evaluate the polynomial at
% \param order the order (or degree) of the polynomial that is to be evaluated
% \return ret the value(s) of the polynomial at x

if(~isscalar(order))
    error('evaluateHermitePolynomial(x,order) -- order must be a scalar');
end %if
if(order < 0)
    error('evaluateHermitePolynomial(x,order) -- order cannot be less than 0');
end %if

y = zeros(size(x));
y1 = x;
y2 = ones(size(x));

if(order == 0)
    ret = y2;
    return
elseif(order == 1)
    ret = x;
    return 
else
    
    for n = 2:1:order
        
        y = x.*y1 - ((n)-1.0).*y2;
		y2 = y1;
		y1 = y;
        
    end %for
    
end %if

    ret = y;

return

end %function