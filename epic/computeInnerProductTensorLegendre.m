function C = computeInnerProductTensorLegendre(num_variables, order)
    
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
    
P = computeNumberOfPCTCoefficients(num_variables, order); % number of terms in PCT expansions
C = zeros(P,P,P); % inner product tensor 

% The weight is the pdf of the csi variable
w = 0.5;

% integrated variable
integ = zeros(1,num_variables);

% Gauss-Legendre Quadrature integration coefficients c and points x
c = [0.0471753363865105, 0.10693932599532106, 0.1600783285433454, 0.2031674267230644, 0.23349253653835517, 0.2491470458134023, 0.2491470458134026, 0.04717533638651206, 0.10693932599531855, 0.16007832854334508, 0.23349253653835522, 0.2031674267230661];
x = [-0.9815606342467187, -0.9041172563704754, -0.7699026741943036, -0.5873179542866167, -0.36783149899817946, -0.12523340851146914, 0.1252334085114688, 0.9815606342467178, 0.904117256370475, 0.7699026741943039, 0.36783149899818013, 0.5873179542866176];

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
                    integ(s)=integ(s)+c(t)*evaluateLegendrePolynomial(x(t),ind(i,s))*evaluateLegendrePolynomial(x(t),ind(j,s))*evaluateLegendrePolynomial(x(t),ind(k,s));                   
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
                integ(s)=integ(s)+c(t)*evaluateLegendrePolynomial(x(t),ind(k,s))*evaluateLegendrePolynomial(x(t),ind(k,s));
            end
            norm = norm*integ(s);
     end
     C(:,:,k) = C(:,:,k)/norm;
end

return
    
end %function
