function c=mtimes(a,b)

% \brief overloaded operator for array/matrix multiplication (*) for pce object arrays

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos                       %%%
%%%   Authors: Matthew Milton, Andrea Benigni, Antonello Monti         %%%
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
	
	if(isscalar(a))
		
		nelement = numel(b);
		c(size(b,1),size(b,2)) = stimes(a, b(nelement));
		
		for i = 1:1:(nelement-1)
			c(i) = stimes(a,b(i));
		end
		
	elseif(isscalar(b))
		
		nelement = numel(a);
		c(size(a,1),size(a,2)) = stimes(a(nelement), b);
		
		for i = 1:1:(nelement-1)
			c(i) = stimes(a(i),b);
		end
		
	elseif(size(a,2) == size(b,1))
		
		c( size(a,1), size(b,2) ) = pce;
		
		for i = 1:1:size(a,1)
			for j = 1:1:size(b,2)
				for k = 1:1:size(a,2)
					c(i,j) = c(i,j)+stimes( a(i,k), b(k,j) );
				end
			end
		end
		
	else
		error('pce::mtimes(a,b) -- a and b must have matching inner dimensions (a columns == b rows) or at least one of a and b must be a scalar');
	end
    
end