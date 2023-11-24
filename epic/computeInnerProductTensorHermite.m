function C = computeInnerProductTensorHermite(num_variables, order)
    
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
    
P = computeNumberOfPCTCoefficients(num_variables, order); % number of terms in PCE expansions
C = zeros(P,P,P); % inner product tensor; return value of this function

% The weight is the pdf of the csi variable
w = sqrt(2);

% integrated variable
integ = zeros(1,num_variables);

% Gauss-Hermite Quadrature/integration coefficients c and points x
c = [2.6585516843599424e-07, 8.573687043588192e-05, 2.658551684363556e-07, 0.0039053905846291983, 0.05160798561588431, 0.26049231026416114, 0.5701352362624784, 0.5701352362624776, 0.260492310264161, 8.573687043587673e-05, 0.05160798561588406, 0.003905390584629052];
x = [-3.8897248978697805, -3.020637025120896, 3.88972489786978, -2.279507080501061, -1.5976826351526057, -0.9477883912401647, -0.31424037625435974, 0.3142403762543594, 0.9477883912401635, 3.0206370251208874, 1.5976826351526021, 2.2795070805010598];

% compute inner products tensor C
ind= revlex(num_variables,order); % indices for reverse lexicographic ordering of poly by order(???)

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
                    integ(s)=integ(s)+c(t)*evaluateHermitePolynomial(w*x(t),ind(i,s))*evaluateHermitePolynomial(w*x(t),ind(j,s))*evaluateHermitePolynomial(w*x(t),ind(k,s));                   
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
                integ(s)=integ(s)+c(t)*evaluateHermitePolynomial(w*x(t),ind(k,s))*evaluateHermitePolynomial(w*x(t),ind(k,s));
            end
            norm = norm*integ(s);
     end
     C(:,:,k) = C(:,:,k)/norm;
end

return
    
end %function