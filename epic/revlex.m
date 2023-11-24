function z = revlex(n,p)
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

% \brief computes indices for reverse lexicographic ordering (revlex) of elements in PCT inner product tensors (???)
% \param n number of variables in PCT system that are random
% \param p order/degree of PCT polynomial applied

    P = factorial(n+p)/(factorial(n)*factorial(p));
    z = zeros(P,n);
    for k = 2:P
      ind = find(z(k-1,2:end));
      if isempty(ind)
          i =1;
      else
          i = ind(1)+1;
      end

      if ( i == 1 )
        t = z(k-1,1);
        z(k,n) = t + 1;
      elseif ( i < n )
        z(k,:)=z(k-1,:);  
        z(k,i) = z(k,i) - 1;
        t = z(k,1) + 1;
        z(k,1) = 0;
        z(k,i-1) = z(k,i-1) + t;
      elseif ( i == n )
        t = z(k-1,1);
        z(k,1) = 0;
        z(k,i-1) = t + 1;
        z(k,i) = z(k-1,i) - 1;
      end
    end
end