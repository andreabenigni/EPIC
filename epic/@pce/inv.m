function b = inv(a)

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

error('pce::inv(a) -- not yet supported');

    global C;
    global nvar;
    global ord;
    global P;

    %check if (1)a is a scalar
    if size(a,1)==1 && size(a,2)==1
        b = 1/a;
    %check if (2)a is a double matrix
    elseif strcmp(class(a),'double')
       [r,c] = size(a);

        % If input matrix is not square, stop function
        if r ~= c
            disp('Only Square Matrices, please')
            b = [];
            return
        end

        % Target identity matrix to be transformed into the output matrix
        b = eye(r);

        %The following code actually performs the matrix inversion by working
        % on each element of the input 
        for j = 1 : r
            for i = j : r
                if a(i,j) ~= 0
                    for k = 1 : r
                        s = a(j,k); a(j,k) = a(i,k); a(i,k) = s;
                        s = b(j,k); b(j,k) = b(i,k); b(i,k) = s;
                    end
                    t = 1/a(j,j);
                    for k = 1 : r
                        a(j,k) = t * a(j,k);
                        b(j,k) = t * b(j,k);
                    end
                    for L = 1 : r
                        if L ~= j
                            t = -a(L,j);
                            for k = 1 : r
                                a(L,k) = a(L,k) + t * a(j,k);
                                b(L,k) = b(L,k) + t * b(j,k);
                            end
                        end
                    end            
                end
                break
            end
            % Display warning if a row full of zeros is found
            if a(i,j) == 0
                disp('Warning: Singular Matrix')
                b = 'error';
                return
            end
        end
    else
        % if (3)a is a pct matrix
        % Find dimensions of input matrix
        [r,c] = size(a);

        % If input matrix is not square, stop function
        if r ~= c
            disp('Only Square Matrices, please')
            b = [];
            return
        end

        % Target identity matrix to be transformed into the output 
        % inverse matrix
        bb = pct(1,0,1);
        b = a;
        for ii = 1:r
            for jj = 1:c
                if ii == jj
                    b(ii,jj) = bb;
                else
                    b(ii,jj) = 0;
                end
            end
        end
       
        % The following code actually performs the matrix inversion by working
        % on each element of the input 
        for j = 1 : r
            for i = j : r
                %if a(i,j) ~= 0
                    for k = 1 : r
                        s = a(j,k); a(j,k) = a(i,k); a(i,k) = s;
                        s = b(j,k); b(j,k) = b(i,k); b(i,k) = s;
                    end
                    t = 1/a(j,j);
                    for k = 1 : r
                        a(j,k) = a(j,k)*t;
                        b(j,k) = b(j,k)*t;
                    end
                    for L = 1 : r
                        if L ~= j
                            t = -a(L,j);
                            for k = 1 : r
                                a(L,k) = a(L,k) + a(j,k)*t;
                                b(L,k) = b(L,k) + b(j,k)*t;
                            end
                        end
                    end            
                %end
                break
            end
            % Display warning if a row full of zeros is found
        %     if a(i,j) == 0
        %         disp('Warning: Singular Matrix')
        %         b = 'error';
        %         return
        %     end
        end
    end
    
    
   
end