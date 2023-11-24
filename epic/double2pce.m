function ret = double2pce(d, pc_space)
  
% \brief converts a double value to a deterministic polynomial chaos expansion (PCE)
% \param d the double value to convert to pce
% \param pce_space the PolynomialChaosSpace that the value will occupy in
% \return the value as a PCE object

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
    
    if(~isa(d,'double'))
        error('double2pce(d, pce_space) -- argument d is not a double');
    end

    if(~isa(pc_space,'PolynomialChaosSpace'))
        error('double2pce(d, pce_space) -- argument pce_space is not a PolynomialChaosSpace');
    end
    
    %ret = pce(pc_space, d, 0.0, 0);
	sz1 = size(d,1);
	sz2 = size(d,2);
	ret(sz1,sz2) = pce(pc_space, d(sz1,sz2), 0.0, 0);
	for i = 1:1:(numel(d)-1)
		ret(i) = pce(pc_space, d(i), 0.0, 0);
	end
    
    return;
    
end %function
