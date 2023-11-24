function c = srdivide(a,b)

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

% \brief non-overloaded operator for right element-wise division between scalar (1x1) pce/double
% objects
% \param a first operand
% \param b second operand
% \return c quotient of a/b

	if(isa(a,'pce') && isa(b,'pce'))
		if( ~isequal(a.space, b.space) )
			error('pce::srdivide(a,b) -- a and b are not in same polynomial chaos space');
		end %if
        
        c = pce(a.space, 0.0, 0.0, 0);
		P = a.space.num_coefficients;
		coeff = zeros(P,P);
		
		for k=1:P
            for i=1:P
                ins=0.0;
                for j=1:P
                     ins = ins + a.space.inner_products(i,j,k) * b.val(j);
                end
                        coeff (k,i)=ins;
            end
        end
        
        
         c.val = coeff\a.val';    
         c.val = c.val';
		
        
    elseif(isa(a,'double') && isa(b,'pce'))
		
		c = pce(b.space, 0.0, 0.0, 0);
		z = pce(b.space, a, 0.0, 0.0);
		P = b.space.num_coefficients;
		coeff = zeros(P,P);
		
		for k=1:P
            for i=1:P
                ins=0.0;
                for j=1:P
                     ins = ins + b.space.inner_products(i,j,k) * b.val(j);
                end
                        coeff (k,i)=ins;
            end
        end
        
        
         c.val = coeff\z.val';    
         c.val = c.val';
		
	elseif(isa(a,'pce') && isa(b,'double'))
		
		c = pce(a.space, 0.0, 0.0, 0);
        c.val = (a.val)/b;
		
	else
		
		error('pce::srdivide(a,b) -- a and b are not doubles nor pce types');
        
	end %if
    
end
 