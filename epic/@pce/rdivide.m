function c=rdivide(a,b)

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

% \brief overloaded operator for per-element r-division (./) for pce object arrays

	if(size(a) == size(b))
		
		nelement = numel(a);
		c(size(a,1),size(a,2)) = srdivide(a(nelement),b(nelement));
		
		for i = 1:1:(nelement-1)
			c(i) = srdivide(a(i),b(i));
		end
		
	elseif(isscalar(a))
		
		nelement = numel(b);
		c(size(b,1),size(b,2)) = srdivide(a, b(nelement));
		
		for i = 1:1:(nelement-1)
			c(i) = srdivide(a,b(i));
		end
		
	elseif(isscalar(b))
		
		nelement = numel(a);
		c(size(a,1),size(a,2)) = srdivide(a(nelement), b);
		
		for i = 1:1:(nelement-1)
			c(i) = srdivide(a(i),b);
		end
		
	else
		error('pce::rdivide(a,b) -- a and b must have same dimensions/size or at least one of a and b must be a scalar');
	end

end
 