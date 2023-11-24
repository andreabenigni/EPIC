function c=rdivide(a,b)

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
            %in this case just devide the two scalar
            c = mdiv(a,b);
        else
            %c as the same size of b
            %c(i,j) = b/c(i,j)
            c = b;
            for i1 = 1:size(b,1)
                for j1 = 1:size(b,2)
                c(i1,j1) =  mdiv(a, b(i1,j1));   
                end
            end
        end
   
    else
        %check if only b is a scalar
        if size(b,1)==1 && size(b,2)==1
            c = a;
            for i1 = 1:size(a,1)
                for j1 = 1:size(a,2)
                    c(i1,j1) = mdiv(a(i1,j1),b);
                end
            end 
        else
                
        
        %Check if dimensions are the same
        if size(a,1)~=size(b,1) || size(a,2)~=size(b,2)
            error('Matrix dimensions must agree. (pct_rdivide)')
        end    
            
        c = a;
        for i1 = 1:size(a,1)
           for j1 = 1:size(a,2)
              c(i1,j1) = mdiv(a(i1,j1),b(i1,j1));
           end
        end 
            
    
        end
    end
    
        
        
    %function to perform division of two scalar
    
    function c = mdiv(a,b)
    
    global C;
    global nvar;
    global ord;
    global P;
    
    %check if one of the two is a double
    if strcmp(class(a),'double')

        a = pct(a,0,0);
        c = mdivpct(a,b);

    else
        if strcmp(class(b),'double')
            c = pct(nvar,ord);
            c.val = (a.val)/b;
        else

        c = mdivpct(a,b);
        
        end
    end
    end

    
    function c = mdivpct(a,b)

    %if both are PCT variable perform multiplication accordingly element by element    
    c = pct(nvar,ord);
        for k=1:P
            
            for i=1:P
                ins=0;
                for j=1:P
                     ins = ins + C(i,j,k)*b.val(j);
                end
                        coeff (k,i)=ins;
            end
        end
        
        
         c.val = coeff\a.val';    
         c.val = c.val';
    end
end
 