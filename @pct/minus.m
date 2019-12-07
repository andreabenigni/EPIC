function c=minus(a,b)
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


    global C;
    global nvar;
    global ord;
    global P;


    %check if a is a scalar
    if size(a,1)==1 && size(a,2)==1
        %check if also b is a scalar
        if size(b,1)==1 && size(b,2)==1
            %in this case just perfom a sum between the two scalars
            c = pscalar(a,b);
        else
        %in this case sum the scalar to each of the element of b
        c = b;
        for i1 = 1:size(b,1)
            for j1 = 1:size(b,2)
                c(i1,j1) = pscalar(a,b(i1,j1));
            end
        end
        end
    else
        %check if only b is a scalar
        if size(b,1)==1 && size(b,2)==1
            c = a;
            for i1 = 1:size(a,1)
                for j1 = 1:size(a,2)
                    c(i1,j1) = pscalar(a(i1,j1),b);
                end
            end 
        else
    
    
        %case in which both are matricies
           
        %Check if the dimensions are the same
        if size(a,1)~=size(b,1) || size(a,2)~=size(b,2)
            error('Matrix dimensions must agree. (pct_plus)')
        end

        for i1 = 1:size(a,1)
            ccol(i1,1) = pct(nvar,ord);
        end
        c = ccol;
        for j1 = 1:size(a,2)-1
            c = [c ccol];
        end


        for i1 = 1:size(a,1)
            for j1 = 1:size(b,2)
                c(i1,j1) = pscalar(a(i1,j1),b(i1,j1));
             end
        end


        end
    end
    






    function c = pscalar(a,b)
    
    %check if one of the two is a double    
        if strcmp(class(a),'double')
            c = pct(nvar,ord);
            c.val = -b.val;
            c.val(1) = a-b.val(1);
        else
        if strcmp(class(b),'double')
            c = pct(nvar,ord);
            c.val = a.val;
            c.val(1) = a.val(1)-b;
        else
            %if both are PCT variables perform multiplication accordingly element by element    
            c = pct(nvar,ord);
            c.val = a.val-b.val;
        end
        end
    end
end



