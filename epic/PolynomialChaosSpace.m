classdef PolynomialChaosSpace < handle
    
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
    
% \brief stores information of a vector space of orthogonal polynomials applied in a system using
% polynomial chaos expansion (PCE).
% 
% This is a handle class where copies of a variable will reference same object (pass by reference).
%
% Objects of this class store information regarding orthogonal polynomials to be used in PCE of
% random processes/variables.  This information includes the number of random variables in a system
% expressed in PCE, the highest order of the orthgonal polys used in PCEs, the number of
% coefficients (aka projection weights) per PCE (function of num vars and order), and the inner
% products of the orthogonal polynomials stored within a 3D tensor.
% 
    
properties

    num_variables      % number of random variables in a system defined under polynomial chaos
    order              % highest order or degree of applied orthogonal polynomials
    num_coefficients   % number of coefficients of polynomial chaos expansions, computed from num_variables and order
    inner_products     % 3D tensor storing inner products between orthogonal polynomials
    dist_type          % distribution type
    
end %properties

methods
  
    function obj = PolynomialChaosSpace(num_variables, order, dist_type)
        
        % \brief constructor
        % \param num_variables the number of random variables in a system defined under polynomial chaos
        % \param order highest order or degree of applied orthogonal polynomials
        % \return obj handle to the created object           
        obj.num_variables = num_variables;
        obj.order = order;
        obj.num_coefficients = factorial(num_variables+order)/(factorial(num_variables)*factorial(order));
        obj.inner_products = [];
        if (nargin < 3)
            obj.dist_type = "uniform";
        else
            obj.dist_type = dist_type;
        end
        
        return;
        
    end %function
    
    function setInnerProducts(obj, C)
        
        % \brief sets the inner product tensor of the space
        % \param obj PolynomialSpace object whose inner product is being set
        % \param C the inner product 3D tensor of dimension PxPxP where P = num_coefficients of space.
        %
        % the inner product tensor can be computed by the functions found in the util folder of EPIC library

        if(size(C,1) ~= obj.num_coefficients || size(C,2) ~= obj.num_coefficients || size(C,3) ~= obj.num_coefficients )
            error('PolynomialChaosSpace::setInnerProducts(obj,C) -- C must be a 3D tensor where each dimension is equal to num_coefficients of the space');
        end %if
        
        obj.inner_products = C;
    
    end %function

    function computeInnerProducts(obj, inner_product_compute_func)
        
        % \brief computes the inner product tensor of the space using a given function 
        % \param obj PolynomialSpace object whose inner product is being set
        % \param inner_product_compute_func handle to function with signature inner_products=func(num_variables, order)
        %  that computes the inner product tensor for a specific orthogonal polynomial.
        %
        % the inner product tensor can be computed by the compute*InnerProducts functions.
        
        if(~isa(inner_product_compute_func,'function_handle'))
            error('PolynomialChaosSpace::computeInnerProducts(obj,inner_product_compute_func) -- inner_product_compute_func must be a function handle');
        end %if

        obj.inner_products = inner_product_compute_func(obj.num_variables, obj.order);
        
    end %function
    
    function computeInnerProductsForHermitePolynomials(obj)
        
        % \brief computes the inner product tensor of the space of Hermite Polynomials
        
        obj.inner_products = computeInnerProductTensorHermite(obj.num_variables, obj.order);
        
        
    end %function
    
    function computeInnerProductsForLegendrePolynomials(obj)
        
        % \brief computes the inner product tensor of the space of Legendre Polynomials
        
        obj.inner_products = computeInnerProductTensorLegendre(obj.num_variables, obj.order);
        
        
    end %function
	
	function computeInnerProductsForLaguerrePolynomials(obj)
		
		% \brief computes the inner proudct tensor of the space of Laguerre Polynomials
		
		obj.inner_products = computeLaguerreInnerProductTensor(obj.num_variables, obj.order);
	end %function
  
end % methods
    
end %classdef
