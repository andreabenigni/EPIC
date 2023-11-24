function c = stimes(a,b)

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

% \brief non-overloaded operator for multiplication between scalar (1x1) pce and double objects
% \param a first operand
% \param b second operrand
% \return c product of a*b

	if(isa(a,'pce') && isa(b,'pce'))
		if( ~isequal(a.space, b.space) )
			error('pce::stimes(a,b) -- a and b are not in same polynomial chaos space');
		end %if
        
        for i1 = 1:size(a,1)
            tmp = pce();
            tmp.space = a.space;
            tmp.val = zeros(1, length(a(1).val));
            tmp.var_index = 0;
            tmp.dist_type = a.dist_type;
            ccol(i1,1) = tmp;
        end
        c = ccol;
        for j1 = 1:size(b,2)-1
            c = [c ccol];
        end
        
		P = a.space.num_coefficients;
		
		for k=1:P
            c.val(k) = 0.0;
            for i=1:P
                for j=1:P
                    c.val(k) = c.val(k) + a.space.inner_products(i,j,k) * a.val(i)*b.val(j);
                end
            end
        end
        
    elseif(isa(a,'double') && isa(b,'pce'))
		
		c = pce(b.space, 0.0, 0.0, 0);
		c.val = a*b.val;
		
	elseif(isa(a,'pce') && isa(b,'double'))
		
		c = pce(a.space, 0.0, 0.0, 0);
        c.val = a.val*b;
		
	else
		
		error('pce::stimes(a,b) -- a and b are not doubles nor pce types');
        
	end %if
    
end