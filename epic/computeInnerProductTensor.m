function C = computeInnerProductTensor(num_variables, order, poly_eval_func)
    
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

%   \brief computes the inner products of a given orthogonal polynomial type and stores results into a 3D tensor
%   \param num_variables number of random variables in system defined with Polynomial Chaos
%   \param order the order or degree of the polynomials
%   \param poly_eval_func a handle to the function that evaluates the orthogonal polynomial type; this func
%    must take as argument the point x and order of the polynomial; ie, evaluateLegendrePolynomial(x,order).
%   \return C the tensor containing the inner products for the given orthogonal polynomial type

if(~isscalar(num_variables))
    error('computeInnerProductTensor(num_variables, order, poly_eval_func) -- num_variables must be a scalar');
end %if
if(~isscalar(order))
    error('computeInnerProductTensor(num_variables, order, poly_eval_func) -- order must be a scalar');
end %if
if(~isa(poly_eval_func,'function_handle'))
    error('computeInnerProductTensor(num_variables, order, poly_eval_func) -- poly_eval_func must be a function handle');
end %if
    
P = computeNumberOfPCTCoefficients(num_variables, order); % number of terms in PCT expansions
C = zeros(P,P,P); % inner product tensor; return value of this function

% The weight is the pdf of the csi variable
w = 0.5;

% integrated variable
integ = zeros(1,num_variables);

% Gauss-Legendre Quadrature/integration coefficients c and points x
c = [0.2491470458134028 0.2491470458134028 0.2334925365383548 0.2334925365383548 0.2031674267230659 0.2031674267230659 0.1600783285433462 0.1600783285433462 0.1069393259953184 0.1069393259953184 0.0471753363865118 0.0471753363865118];
x = [-0.1252334085114689 0.1252334085114689 -0.3678314989981802 0.3678314989981802 -0.5873179542866175 0.5873179542866175 -0.7699026741943047 0.7699026741943047 -0.9041172563704749 0.9041172563704749 -0.9815606342467192 0.9815606342467192];

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
                    integ(s)=integ(s)+c(t)*poly_eval_func(x(t),ind(i,s))*poly_eval_func(x(t),ind(j,s))*poly_eval_func(x(t),ind(k,s));                   
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
                integ(s)=integ(s)+c(t)*poly_eval_func(x(t),ind(k,s))*poly_eval_func(x(t),ind(k,s));
            end
            norm = norm*integ(s);
     end
     C(:,:,k) = C(:,:,k)/norm;
end

return
    
end %function