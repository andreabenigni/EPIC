function [C_, D_, doublek_] = calccijk(n,p)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos (v.1.0)               %%%
%%%               Authors: Andrea Benigni, Antonello Monti             %%%
%%%           benignia@cec.sc.edu, amonti@eornerc.rwth-aachen.de       %%%
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

% n number of varaibles
% p order
global C
global D
global doublek

% The weight is the pdf of the csi variable
w = 0.5;

% Gauss-Legendre Quadrature coefficients and points
c = [0.2491470458134028 0.2491470458134028 0.2334925365383548 0.2334925365383548 0.2031674267230659 0.2031674267230659 0.1600783285433462 0.1600783285433462 0.1069393259953184 0.1069393259953184 0.0471753363865118 0.0471753363865118];
x = [-0.1252334085114689 0.1252334085114689 -0.3678314989981802 0.3678314989981802 -0.5873179542866175 0.5873179542866175 -0.7699026741943047 0.7699026741943047 -0.9041172563704749 0.9041172563704749 -0.9815606342467192 0.9815606342467192];


% total number of polynomials
P = factorial(n+p)/(factorial(n)*factorial(p));

% matrix of internal products
C = zeros(P,P,P);
ind= revlex(n,p);
for i=1:P
    % Calculate order of polynomial for each variable in polynomial i
    %ordi = conv102p(i-1,p,n);
    for j=1:P
        % Calculate order of polynomial for each variable in polynomial j
        %ordj = conv102p(j-1,p,n);
        for k=1:P
            % Calculate order of polynomial for each variable in polynomial k
            %ordk = conv102p(k-1,p,n);
            C(i,j,k) = w;
            D(i,j,k) = w;
            
            % Calculate the internal product dimension by dimension
            for s=1:n
                integ(s) = 0;
                integ2(s) = 0;
                % Quadrature formula
                for t=1:12
                    integ(s)=integ(s)+c(t)*Lege(x(t),ind(i,s))*Lege(x(t),ind(j,s))*Lege(x(t),ind(k,s));
                    integ2(s)=integ2(s)+c(t)*Lege(x(t),ind(i,s))*Lege(x(t),ind(k,s))/Lege(x(t),ind(j,s));
                end
                C(i,j,k)= C(i,j,k)*integ(s);
                D(i,j,k)= D(i,j,k)*integ(s);
            end
        end
    end
end
%     Riscale by the norm
    for k=1:P
        %ordk = conv102p(k-1,p,n);        
        norm = w;
        % Calculate the internal product dimension by dimension
          for s=1:n
                integ(s) = 0;
                % Quadrature formula
                for t=1:12
                    integ(s)=integ(s)+c(t)*Lege(x(t),ind(k,s))*Lege(x(t),ind(k,s));
                end
                norm = norm*integ(s);
         end
         C(:,:,k) = C(:,:,k)/norm;
         doublek(k) = norm;
    end

C_ = C;
D_ = D;
doublek_ = doublek;
    
end  
      
function ordv = conv102p(k,p,n)
C()
cur = k;
i = 1;
n = n+1;
while cur >= n
    ordv(i) = floor(cur/p);
    cur = mod(cur,p);
    i = i+1;
end
ordv(i) = cur;
if (i < n)
    ordv = shiftright(ordv,n-i);
end
end

function v = shiftright(in,n)

for p=1:n
    v(p) = 0;
end
for p=1:length(in)
    v(n+p) = in(p);
end
end





