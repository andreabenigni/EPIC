function c=sminus(a,b)

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

% \brief overloads binary minus operator (-) for scalar pce objects

	if(isa(a,'pce') && isa(b,'pce'))
		if( ~isequal(a.space, b.space) )
			error('pce::minus(a,b) -- a and b are not in same polynomial chaos space');
		end %if
        
        c = pce(a.space, 0.0, 0.0, 0);
		c.val = a.val - b.val;
        
    elseif(isa(a,'double') && isa(b,'pce'))
		
		c = pce(b.space, 0.0, 0.0, 0);
		c.val = -b.val;
		c.val(1) = a-b.val(1);
		
	elseif(isa(a,'pce') && isa(b,'double'))
		
		c = pce(a.space, 0.0, 0.0, 0);
        c.val = a.val;
        c.val(1) = a.val(1)-b;
		
	else
		
		error('pce::minus(a,b) -- a and b are not doubles nor pce types');
        
	end %if
    
end



