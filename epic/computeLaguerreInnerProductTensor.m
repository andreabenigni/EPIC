function C = computeLaguerreInnerProductTensor(num_variables, order)
    
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
    
P = computeNumberOfPCTCoefficients(num_variables, order); % number of terms in PCE expansions
C = zeros(P,P,P); % inner product tensor 

% The weight is the pdf of the csi variable
w = 0.5;

% integrated variable
integ = zeros(1,num_variables);

% Gauss-Legendre Quadrature integration coefficients c and points x
c = [0.2491470458134028 0.2491470458134028 0.2334925365383548 0.2334925365383548 0.2031674267230659 0.2031674267230659 0.1600783285433462 0.1600783285433462 0.1069393259953184 0.1069393259953184 0.0471753363865118 0.0471753363865118];
x = [-0.1252334085114689 0.1252334085114689 -0.3678314989981802 0.3678314989981802 -0.5873179542866175 0.5873179542866175 -0.7699026741943047 0.7699026741943047 -0.9041172563704749 0.9041172563704749 -0.9815606342467192 0.9815606342467192];

% compute inner products tensor C

ind= revlex(num_variables,order); % indices for reverse lexicographic ordering (???)

for i=1:P
    % Calculate order of polynomial for each variable in polynomial i
    for j=1:P
        % Calculate order of polynomial for each variable in polynomial j
        for k=1:P
            % Calculate order of polynomial for each variable in polynomial k
            C(i,j,k) = w;
            
            % Calculate the internal product dimension by dimension
            for s=1:num_variables
                integ(s) = 0;
                % Quadrature formula
                for t=1:12
                    integ(s)=integ(s)+c(t)*evaluateLaguerrePolynomial(x(t),ind(i,s))*evaluateLaguerrePolynomial(x(t),ind(j,s))*evaluateLaguerrePolynomial(x(t),ind(k,s));                   
                end
                C(i,j,k)= C(i,j,k)*integ(s);
            end
        end
    end
end

% rescale inner product ternsor by the norm
for k=1:P
    norm = w;
    % Calculate the inner product dimension by dimension
      for s=1:num_variables
            integ(s) = 0;
            % Quadrature formula
            for t=1:12
                integ(s)=integ(s)+c(t)*evaluateLaguerrePolynomial(x(t),ind(k,s))*evaluateLaguerrePolynomial(x(t),ind(k,s));
            end
            norm = norm*integ(s);
     end
     C(:,:,k) = C(:,:,k)/norm;
end

return
    
end %function
