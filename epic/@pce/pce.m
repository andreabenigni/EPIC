classdef pce

% \brief encapsulates a polynomial chaos expansion (PCE) of a random/uncertain process/variable

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                  EPIC: Easy Polynomial Chaos                       %%%
%%%   Authors: Matthew Milton, Andrea Benigni, Antonello Monti         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of EPIC (Easy PolynomIal Chaos) Toolbox.             %
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

%===================================================================================================

    properties
        space % polynomial chaos vector space definition used by the PCE objects
        val   % polynomial projection coefficients of PCE objects
	end
	
%===================================================================================================
	
    methods
		
        function obj = pce(pc_space, expected_value, range, var_index)
			
			% \brief constructor for pce type
			%
			% possible signatures for the constructor are:\n
			% pce -- default constructor for pce object with empty space and coefficients\n
			% pce(pc_space) -- for zeroed pce object within a defined pce vector space\n
			% pce(pc_space, expected_value) -- for deterministic pce object within a defined pce
			% space\n
			% pce(pc_space, expected value, range, var_index) -- for uncertain pce object within a
			% defined pce space\n
			%			
			% \param pc_space the PolynomialChaosSpace that the pce type occupies
			% \param expected_value the expected value for the pce variable
			% \param range maximum distance from expected value in variable's probability density function
			% \param var_index the index that the pce variable holds to be marked as probabilisitc; set to 0 for a determinsitic variable
			% \return obj constructed pce object
			
% 			if(~isa(pc_space,'PolynomialChaosSpace'))
%                 error('pce::constructor(pc_space, expected_value, range, var_index) -- poly_chaos_def must be a PolynomialSpace');
%           end %if 
 
            %obj.space = pc_space;
            %obj.val = zeros(1,pc_space.num_coefficients);
			
			if (nargin == 0)
				
				obj.space = [];
				obj.val = [];
				
			elseif (nargin == 1)
				
				if(~isa(pc_space,'PolynomialChaosSpace'))
					error('pce::constructor(pc_space, expected_value, range, var_index) -- poly_chaos_def must be a PolynomialSpace');
				end
				
				obj.space = pc_space;
				obj.val = zeros(1,pc_space.num_coefficients);
				
            elseif (nargin == 2)
				
				if(~isa(pc_space,'PolynomialChaosSpace'))
					error('pce::constructor(pc_space, expected_value, range, var_index) -- poly_chaos_def must be a PolynomialSpace');
				end
				
				obj.space = pc_space;
				obj.val = zeros(1,pc_space.num_coefficients);
				obj.val(1) = expected_value;
				
            elseif(nargin == 4)
				
				if(~isa(pc_space,'PolynomialChaosSpace'))
					error('pce::constructor(pc_space, expected_value, range, var_index) -- poly_chaos_def must be a PolynomialSpace');
				end
				
				obj.space = pc_space;
				obj.val = zeros(1,pc_space.num_coefficients);
				obj.val(1) = expected_value;
                
				if var_index > 0
                    pos = var_index+1;
                    obj.val(pos) = range;
				end
				
			else
				
				error('pce::constructor(pc_space, expected_value, range, var_index) -- wrong number of arguments given; must be 1, 2, or 4');
				
			end
			
        end %function constructor pct
		
		function expected_value = getExpectedValue(obj)
			% \return expected value (approximately the mean) moment of the pce object
			
			expected_value = obj.val(1);
		end
		
		function variance = getVariance(obj)
			% \return variance moment of the pce object; 0.0 if deterministic
			
			variance = 0.0;
			for i = 2:1:(obj.space.num_coefficients)
				variance = variance + obj.val(i)*obj.val(i);
			end
		end
		
		function std = getStandardDeviation(obj)
			% \return standard deviation moment of the pce object; 0.0 if deterministic
			
			std = sqrt( obj.getVariance() ); 
		end
		
		function mad = getMeanAbsoluteDeviation(obj)
			% \return mean absolute deviation (MAD) moment of the pce object; 0.0 if deterministic
			
			mad = 0.0;
			for i = 2:1:(obj.space.num_coefficients)
				mad = mad + abs(obj.val(i));
			end
		end
		
		function ret = eq(a,b)
			% \brief overloads the equality (eq, ==) operator for pce objects
			
			if(size(a) == size(b))
				
				for i = 1:1:numel(a)
					if( isequal(a(i).space,b(i).space) && isequal(a(i).val,b(i).val) )
						continue;
					else
						ret = false;
						return;
					end
				end
				
				ret = true;
				return;
				
			else
				ret = false;
				return;
			end
		end
		
		function ret = ne(a,b)
			% \brief overloads the non-equality (ne, ~=) operator for pce objects
			
			if(size(a) == size(b))
				
				for i = 1:1:numel(a)
					if( isequal(a(i).space,b(i).space) && isequal(a(i).val,b(i).val) )
						continue;
					else
						ret = true;
						return;
					end
				end
				
				ret = false;
				return;
				
			else
				ret = true;
				return;
			end
		end
	
    end %methods 

%===================================================================================================
	
end %classdef

%===================================================================================================
%===================================================================================================