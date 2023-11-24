function c=mrdivide(a,b)

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

% \brief overloaded operator for matrix/array right division (/) for pce object arrays
% \param a dividend of operation
% \param b divisor of operation
% \return c quotient of operation, c=a/b

	if(isscalar(b))
		
		nelement = numel(a);
		c(size(a,1),size(a,2)) = srdivide(a(nelement), b);
		
		for i = 1:1:(nelement-1)
			c(i) = srdivide(a(i),b);
		end
		
% 	elseif( isscalar(a) && ~isscalar(b) && isa(b, 'pce') )
% 		
% 		error('pce::mrdivide(a,b) -- divisor b cannot be a pce array/matrix as pce array inversion is unsupported');
% 		
		
	else
		error('pce::mrdivide(a,b) -- a and b must either both be scalars or at least b must be a scalar; pce array inversion is unsupported');
	end
    
end
 