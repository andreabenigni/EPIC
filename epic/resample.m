function samplec = resample(c,sample)

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


c_p = c.space.order;
c_n = c.space.num_variables;

ind=revlex(c_n,c_p);

if c.dist_type == "uniform"
    for k = 1:(c_n)
        y(k,:) = uniform(-1,1,sample);
    end

    for i=1:sample
        samplec(i) = 0;
        for var = 1:length(ind)
            interm(var) = c.val(var);
            for ord = 1:c_n
                interm(var) = interm(var)*lege(y(ord,i),ind(var,ord));      
            end
            samplec(i) = samplec(i)+interm(var);
        end
    end
elseif c.dist_type == "gaussian"
    for k = 1:(c_n)
        y(k,:) = gaussian(0,1,sample);
    end

    for i=1:sample
        samplec(i) = 0;
        for var = 1:length(ind)
            interm(var) = c.val(var);
            for ord = 1:c_n
                interm(var) = interm(var)*herm(y(ord,i),ind(var,ord));      
            end
            samplec(i) = samplec(i)+interm(var);
        end
    end
end

end
