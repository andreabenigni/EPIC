function ret = pce_ones(pc_space, n_sz1, sz2, sz3)

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

% \brief create array of all deterministic ones in polynomial chaos expansion (PCE) space
%
% This function may become deprecated if ones function support is added to pce class.
%
% \param pc_space vector space definition for the PCE zeros; must be of type Polynomial Chaos Space;
% required
% \param n_sz1 if only argument after pc_space, sets dimension of the zeroed array to be
% n_sz1-by-n_sz1; otherwise, it is the first dimension of the created array; required
% \param sz2 the second dimension of the zeroed array; optional
% \param sz3 the third and final dimension of the zeroed array; optional

	if(nargin == 1)
		
		ret = pce(pc_space, 1.0, 0.0, 0);
		
	elseif(nargin == 2)
		
		if( mod(n_sz1, 1) ~= 0)
			
			error('pce_ones(pc_space, n_sz1) -- n_sz1 must be integer');
			
		else
			
			ret(n_sz1, n_sz1) = pce(pc_space, 1.0, 0.0, 0);
			for i = 1:1:numel(ret)
				ret(i) = pce(pc_space, 1.0, 0.0, 0);
			end
			
		end
		
	elseif(nargin == 3)
		
		if( mod(n_sz1, 1) ~= 0 || mod(sz2, 1) ~= 0)
			
			error('pce_ones(pc_space, n_sz1, sz2) -- n_sz1 and sz2 must be integers');
			
		else
			
			ret(n_sz1, sz2) = pce(pc_space, 1.0, 0.0, 0);
			for i = 1:1:numel(ret)
				ret(i) = pce(pc_space, 1.0, 0.0, 0);
			end
			
		end
		
	elseif(nargin == 4)
		
		if( mod(n_sz1, 1) ~= 0 || mod(sz2, 1) ~= 0 || mod(sz3, 1) ~= 0)
			
			error('pce_ones(pc_space, n_sz1, sz2, sz3) -- n_sz1, sz2, and sz3 must be integers');
			
		else
			
			ret(n_sz1, sz2, sz3) = pce(pc_space, 1.0, 0.0, 0);
			for i = 1:1:numel(ret)
				ret(i) = pce(pc_space, 1.0, 0.0, 0);
			end
			
		end
		
	else
		error('pce_ones() -- number of arguments must be between 1 and 4');
	end

end