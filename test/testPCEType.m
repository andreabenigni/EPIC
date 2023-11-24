%===================================================================================================
%
%	tests out the new Polynomial Chaos Expansion (pce) data type and corresponding functions/classes
%
%	Matthew Milton
%	Jan 2020
%
%===================================================================================================

% clean up environment

close all;
clear all;
clc;

%===================================================================================================

% setup paths

addpath('../epic');

%===================================================================================================

% display title card

fprintf('Tests out pce type and corresponding functions/methods/operators.\nMatthew Milton\nJan 2020\n\n');

%===================================================================================================
%###################################################################################################
%===================================================================================================

fprintf('!!! Computing with PCE type first.\n\n');

%===================================================================================================

% define the vector space for the PCEs

NUM_UNCERTAIN_VARIABLES = 2 % number of uncertain/stochastic variables in system expressed with pce
ORDER = 2                   % maximum order for orthogonal polynomials used in pce

PC_SPACE = PolynomialChaosSpace(NUM_UNCERTAIN_VARIABLES, ORDER); % vector space definition of the pce

P_TERMS = PC_SPACE.num_coefficients % number of coefficients per pce of a variable/process

fprintf('computing PCE space inner products...\n');

PC_SPACE.computeInnerProductsForLegendrePolynomials(); % setup PCE space for uniformly distributed uncertain/random variables using Legendre polynomials

fprintf('DONE.\n\n');

%===================================================================================================

% define the variables in PCE form

	% var = pce(pc_vector_space, expected_value, range, uncertain_var_id)

a = pce(PC_SPACE, 5.0, 2, 1); % uncertain pce variable 1 of 2
b = pce(PC_SPACE, 7.0, 4, 2); % uncertain pce variable 2 of 2
c = pce(PC_SPACE, 2.0);       % deterministic pce variable (range = 0.0, id = 0)
d = 6.0;                      % deterministic double scalar variable (space = R, exp = 6.0, range = 0.0, id = 0)

%===================================================================================================

% perform basic operations

if 1
fprintf('performing basic math operations between scalar pce variables...\n');

a_plus_b = a+b;
a_plus_c = a+c;
c_plus_b = c+b;
a_plus_d = a+d;
d_plus_a = d+a;

a_minus_b = a-b;
a_minus_c = a-c;
c_minus_b = c-b;
a_minus_d = a-d;
d_minus_a = d-a;

minus_a = -a;
minus_b = -b;
minus_c = -c;

plus_a = +a;
plus_b = +b;
plus_c = +c;

a_times_b = a*b;
a_times_c = a*c;
c_times_b = c*b;
b_times_a = b*a;
c_times_a = c*a;
a_times_d = a*d;
d_times_a = d*a;

a_over_b = a/b;
a_over_c = a/c;
c_over_b = c/b;
b_over_a = b/a;
c_over_a = c/a;
a_over_d = a/d;
d_over_a = d/a;

fprintf('DONE.\n\n');
end %if

%===================================================================================================

% perform matrix/array per-element operations

if 1
fprintf('performing matrix per-element math operations between pce arrays and scalars...\n');

A = [ a, a; a, a;];
B = [ b, b; b, b;];
C = [ c, c; c, c;];
D = [ d, d; d, d;];

A_plus_B = A+B;
A_plus_C = A+C;
C_plus_B = C+B;
A_plus_D = A+D;
D_plus_A = D+A;

A_plus_b = A+b;
A_plus_c = A+c;
A_plus_d = A+d;

A_minus_B = A-B;
A_minus_C = A-C;
C_minus_B = C-B;
A_minus_D = A-D;
D_minus_A = D-A;

A_minus_b = A-b;
A_minus_c = A-c;
A_minus_d = A-d;

A_times_B = A.*B;
A_times_C = A.*C;
C_times_B = C.*B;
A_times_D = A.*D;
D_times_A = D.*A;

A_times_b = A.*b;
A_times_c = A.*c;
C_times_b = C.*b;
A_times_d = A.*d;
d_times_A = d.*A;

fprintf('DONE.\n\n');
end %if

%===================================================================================================

% perform matrix/array operations

if 1
fprintf('performing matrix math operations between pce arrays and scalars...\n');

A_mtimes_B = A*B;
A_mtimes_C = A*C;
C_mtimes_B = C*B;
A_mtimes_D = A*D;
D_mtimes_A = D*A;

A_mtimes_b = A*b;
A_mtimes_c = A*c;
C_mtimes_b = C*b;
A_mtimes_d = A*d;
d_mtimes_A = d*A;


%fprintf('SKIPPED.\n\n');
fprintf('DONE.\n\n');
end %if


%===================================================================================================

% save workspace to file for pce results

fprintf('Writing PCE results workspace to file...\n');
save('pce_results.mat');
fprintf('DONE.\n\n');

%===================================================================================================
%###################################################################################################
%===================================================================================================

% recompute everything using the older pct type to compare against pce

if 1 % !!!
fprintf('!!! Computing with PCE type finished.  Now Computing with older PCT type.\n\n');

clear all;
	
%===================================================================================================

% define the vector space for the PCT objects

NUM_UNCERTAIN_VARIABLES = 2 % number of uncertain/stochastic variables in system expressed with pct
ORDER = 2                   % maximum order for orthogonal polynomials used in pct

fprintf('Initializing PCT vector space...\n');

[nvar_,ord_,P_,C_,D_,doublek_] = initPCT(NUM_UNCERTAIN_VARIABLES, ORDER); % initialize vector space for all pct objects

fprintf('DONE.\n\n');

P_TERMS = P_

%===================================================================================================

% define the variables in PCT form

	% var = pce(pc_vector_space, expected_value, range, uncertain_var_id)

a = pct(5.0, 2, 1); % uncertain pce variable 1 of 2
b = pct(7.0, 4, 2); % uncertain pce variable 2 of 2
c = pct(2.0);       % deterministic pce variable (range = 0.0, id = 0)
d = 6.0;            % deterministic double scalar variable (space = R, exp = 6.0, range = 0.0, id = 0)

%===================================================================================================

% perform basic operations

if 1
fprintf('performing basic math operations between scalar pct variables...\n');

a_plus_b = a+b;
a_plus_c = a+c;
c_plus_b = c+b;
a_plus_d = a+d;
d_plus_a = d+a;

a_minus_b = a-b;
a_minus_c = a-c;
c_minus_b = c-b;
a_minus_d = a-d;
d_minus_a = d-a;

minus_a = -a;
minus_b = -b;
minus_c = -c;

plus_a = +a;
plus_b = +b;
plus_c = +c;

a_times_b = a*b;
a_times_c = a*c;
c_times_b = c*b;
b_times_a = b*a;
c_times_a = c*a;
a_times_d = a*pct(d);
d_times_a = d*a;

a_over_b = a/b;
a_over_c = a/c;
c_over_b = c/b;
b_over_a = b/a;
c_over_a = c/a;
a_over_d = a/d;
d_over_a = d/a;

fprintf('DONE.\n\n');
end %if

%===================================================================================================

% perform matrix/array per-element operations

if 1
fprintf('performing matrix per-element math operations between pct arrays and scalars...\n');

A = [ a, a; a, a;];
B = [ b, b; b, b;];
C = [ c, c; c, c;];
D = [ d, d; d, d;];

A_plus_B = A+B;
A_plus_C = A+C;
C_plus_B = C+B;
A_plus_D = A+D;
D_plus_A = D+A;

A_plus_b = A+b;
A_plus_c = A+c;
A_plus_d = A+d;

A_minus_B = A-B;
A_minus_C = A-C;
C_minus_B = C-B;
A_minus_D = A-D;
D_minus_A = D-A;

A_minus_b = A-b;
A_minus_c = A-c;
A_minus_d = A-d;

A_times_B = A.*B;
A_times_C = A.*C;
C_times_B = C.*B;
A_times_D = A.*D;
D_times_A = D.*A;

A_times_b = A.*b;
A_times_c = A.*c;
C_times_b = C.*b;
A_times_d = A.*d;
d_times_A = d.*A;

fprintf('DONE.\n\n');
end %if

%===================================================================================================

% perform matrix/array operations

if 1
fprintf('performing matrix math operations between pct arrays and scalars...\n');

A_mtimes_B = A*B;
A_mtimes_C = A*C;
C_mtimes_B = C*B;
A_mtimes_D = A*D;
D_mtimes_A = D*A;

A_mtimes_b = A*b;
A_mtimes_c = A*c;
C_mtimes_b = C*b;
A_mtimes_d = A*d;
d_mtimes_A = d*A;


%fprintf('SKIPPED.\n\n');
fprintf('DONE.\n\n');
end %if

%===================================================================================================

% save workspace to file for pce results

fprintf('Writing PCT results workspace to file...\n');
save('pct_results.mat');
fprintf('DONE.\n\n');

end % !!! end pct part of the script

%===================================================================================================
%###################################################################################################
%===================================================================================================

if 1
	
%===================================================================================================
	
fprintf('!!! Clearing Workspace and Loading PCE and PCT Results From File to Structures...\n');

% clear workspace and reload pce and pct workspaces from file into structures for easy comparsion

clear all;

PCE_RESULTS = load('pce_results.mat');
PCT_RESULTS = load('pct_results.mat');

fprintf('DONE.\n\n');

%===================================================================================================

% compare results for PCE and PCT types to ensure they match within margin of error

% !!! FINISH ME !!! 01.23.2020 MM

%PCE_PCT_DIFFERENCES.

% compare results by taking the difference between the coefficients of PCE results and the PCT results

fprintf('Computing differences between PCE and PCT results...\n');

PCE_PCT_DIFFERENCES.a_plus_b = PCE_RESULTS.a_plus_b.val - PCT_RESULTS.a_plus_b.val;
PCE_PCT_DIFFERENCES.a_plus_c = PCE_RESULTS.a_plus_c.val - PCT_RESULTS.a_plus_c.val;
PCE_PCT_DIFFERENCES.c_plus_b = PCE_RESULTS.c_plus_b.val - PCT_RESULTS.c_plus_b.val;
PCE_PCT_DIFFERENCES.a_plus_d = PCE_RESULTS.a_plus_d.val - PCT_RESULTS.a_plus_d.val;
PCE_PCT_DIFFERENCES.d_plus_a = PCE_RESULTS.d_plus_a.val - PCT_RESULTS.d_plus_a.val;

PCE_PCT_DIFFERENCES.a_minus_b = PCE_RESULTS.a_minus_b.val - PCT_RESULTS.a_minus_b.val;
PCE_PCT_DIFFERENCES.a_minus_c = PCE_RESULTS.a_minus_c.val - PCT_RESULTS.a_minus_c.val;
PCE_PCT_DIFFERENCES.c_minus_b = PCE_RESULTS.c_minus_b.val - PCT_RESULTS.c_minus_b.val;
PCE_PCT_DIFFERENCES.a_minus_d = PCE_RESULTS.a_minus_d.val - PCT_RESULTS.a_minus_d.val;
PCE_PCT_DIFFERENCES.d_minus_a = PCE_RESULTS.d_minus_a.val - PCT_RESULTS.d_minus_a.val;

PCE_PCT_DIFFERENCES.minus_a = PCE_RESULTS.minus_a.val - PCT_RESULTS.minus_a.val;
PCE_PCT_DIFFERENCES.minus_b = PCE_RESULTS.minus_b.val - PCT_RESULTS.minus_b.val;
PCE_PCT_DIFFERENCES.minus_c = PCE_RESULTS.minus_c.val - PCT_RESULTS.minus_c.val;

PCE_PCT_DIFFERENCES.plus_a = PCE_RESULTS.plus_a.val - PCT_RESULTS.plus_a.val;
PCE_PCT_DIFFERENCES.plus_b = PCE_RESULTS.plus_b.val - PCT_RESULTS.plus_b.val;
PCE_PCT_DIFFERENCES.plus_c = PCE_RESULTS.plus_c.val - PCT_RESULTS.plus_c.val;

PCE_PCT_DIFFERENCES.a_times_b = PCE_RESULTS.a_times_b.val - PCT_RESULTS.a_times_b.val;
PCE_PCT_DIFFERENCES.a_times_c = PCE_RESULTS.a_times_c.val - PCT_RESULTS.a_times_c.val;
PCE_PCT_DIFFERENCES.c_times_b = PCE_RESULTS.c_times_b.val - PCT_RESULTS.c_times_b.val;
PCE_PCT_DIFFERENCES.b_times_a = PCE_RESULTS.b_times_a.val - PCT_RESULTS.b_times_a.val;
PCE_PCT_DIFFERENCES.c_times_a = PCE_RESULTS.c_times_a.val - PCT_RESULTS.c_times_a.val;
PCE_PCT_DIFFERENCES.a_times_d = PCE_RESULTS.a_times_d.val - PCT_RESULTS.a_times_d.val;
PCE_PCT_DIFFERENCES.d_times_a = PCE_RESULTS.d_times_a.val - PCT_RESULTS.d_times_a.val;

PCE_PCT_DIFFERENCES.a_over_b = PCE_RESULTS.a_over_b.val - PCT_RESULTS.a_over_b.val;
PCE_PCT_DIFFERENCES.a_over_c = PCE_RESULTS.a_over_c.val - PCT_RESULTS.a_over_c.val;
PCE_PCT_DIFFERENCES.c_over_b = PCE_RESULTS.c_over_b.val - PCT_RESULTS.c_over_b.val;
PCE_PCT_DIFFERENCES.b_over_a = PCE_RESULTS.b_over_a.val - PCT_RESULTS.b_over_a.val;
PCE_PCT_DIFFERENCES.c_over_a = PCE_RESULTS.c_over_a.val - PCT_RESULTS.c_over_a.val;
PCE_PCT_DIFFERENCES.a_over_d = PCE_RESULTS.a_over_d.val - PCT_RESULTS.a_over_d.val;
PCE_PCT_DIFFERENCES.d_over_a = PCE_RESULTS.d_over_a.val - PCT_RESULTS.d_over_a.val;

%------------------------------

PCE_PCT_DIFFERENCES.A_plus_B  = zeros(4,6);
PCE_PCT_DIFFERENCES.A_plus_C  = zeros(4,6);
PCE_PCT_DIFFERENCES.C_plus_B  = zeros(4,6);
PCE_PCT_DIFFERENCES.A_plus_D  = zeros(4,6);
PCE_PCT_DIFFERENCES.D_plus_A  = zeros(4,6);

PCE_PCT_DIFFERENCES.A_plus_b  = zeros(4,6);
PCE_PCT_DIFFERENCES.A_plus_c  = zeros(4,6);
PCE_PCT_DIFFERENCES.A_plus_d  = zeros(4,6);

PCE_PCT_DIFFERENCES.A_minus_B = zeros(4,6);
PCE_PCT_DIFFERENCES.A_minus_C = zeros(4,6);
PCE_PCT_DIFFERENCES.C_minus_B = zeros(4,6);
PCE_PCT_DIFFERENCES.A_minus_D = zeros(4,6);
PCE_PCT_DIFFERENCES.D_minus_A = zeros(4,6);

PCE_PCT_DIFFERENCES.A_minus_b = zeros(4,6);
PCE_PCT_DIFFERENCES.A_minus_c = zeros(4,6);
PCE_PCT_DIFFERENCES.A_minus_d = zeros(4,6);

PCE_PCT_DIFFERENCES.A_times_B = zeros(4,6);
PCE_PCT_DIFFERENCES.A_times_C = zeros(4,6);
PCE_PCT_DIFFERENCES.C_times_B = zeros(4,6);
PCE_PCT_DIFFERENCES.A_times_D = zeros(4,6);
PCE_PCT_DIFFERENCES.D_times_A = zeros(4,6);

PCE_PCT_DIFFERENCES.A_times_b = zeros(4,6);
PCE_PCT_DIFFERENCES.A_times_c = zeros(4,6);
PCE_PCT_DIFFERENCES.C_times_b = zeros(4,6);
PCE_PCT_DIFFERENCES.A_times_d = zeros(4,6);
PCE_PCT_DIFFERENCES.d_times_A = zeros(4,6);

for i = 1:1:4

	PCE_PCT_DIFFERENCES.A_plus_B(i,:) = PCE_RESULTS.A_plus_B(i).val - PCT_RESULTS.A_plus_B(i).val  ;
	PCE_PCT_DIFFERENCES.A_plus_C(i,:) = PCE_RESULTS.A_plus_C(i).val - PCT_RESULTS.A_plus_C(i).val  ;
	PCE_PCT_DIFFERENCES.C_plus_B(i,:) = PCE_RESULTS.C_plus_B(i).val - PCT_RESULTS.C_plus_B(i).val  ;
	PCE_PCT_DIFFERENCES.A_plus_D(i,:) = PCE_RESULTS.A_plus_D(i).val - PCT_RESULTS.A_plus_D(i).val  ;
	PCE_PCT_DIFFERENCES.D_plus_A(i,:) = PCE_RESULTS.D_plus_A(i).val - PCT_RESULTS.D_plus_A(i).val  ;

	PCE_PCT_DIFFERENCES.A_plus_b(i,:) = PCE_RESULTS.A_plus_b(i).val - PCT_RESULTS.A_plus_b(i).val  ;
	PCE_PCT_DIFFERENCES.A_plus_c(i,:) = PCE_RESULTS.A_plus_c(i).val - PCT_RESULTS.A_plus_c(i).val  ;
	PCE_PCT_DIFFERENCES.A_plus_d(i,:) = PCE_RESULTS.A_plus_d(i).val - PCT_RESULTS.A_plus_d(i).val  ;

	PCE_PCT_DIFFERENCES.A_minus_B(i,:) = PCE_RESULTS.A_minus_B(i).val  -  PCT_RESULTS.A_minus_B(i).val;
	PCE_PCT_DIFFERENCES.A_minus_C(i,:) = PCE_RESULTS.A_minus_C(i).val  -  PCT_RESULTS.A_minus_C(i).val;
	PCE_PCT_DIFFERENCES.C_minus_B(i,:) = PCE_RESULTS.C_minus_B(i).val  -  PCT_RESULTS.C_minus_B(i).val;
	PCE_PCT_DIFFERENCES.A_minus_D(i,:) = PCE_RESULTS.A_minus_D(i).val  -  PCT_RESULTS.A_minus_D(i).val;
	PCE_PCT_DIFFERENCES.D_minus_A(i,:) = PCE_RESULTS.D_minus_A(i).val  -  PCT_RESULTS.D_minus_A(i).val;

	PCE_PCT_DIFFERENCES.A_minus_b(i,:) = PCE_RESULTS.A_minus_b(i).val  -  PCT_RESULTS.A_minus_b(i).val;
	PCE_PCT_DIFFERENCES.A_minus_c(i,:) = PCE_RESULTS.A_minus_c(i).val  -  PCT_RESULTS.A_minus_c(i).val;
	PCE_PCT_DIFFERENCES.A_minus_d(i,:) = PCE_RESULTS.A_minus_d(i).val  -  PCT_RESULTS.A_minus_d(i).val;

	PCE_PCT_DIFFERENCES.A_times_B(i,:) = PCE_RESULTS.A_times_B(i).val  -  PCT_RESULTS.A_times_B(i).val;
	PCE_PCT_DIFFERENCES.A_times_C(i,:) = PCE_RESULTS.A_times_C(i).val  -  PCT_RESULTS.A_times_C(i).val;
	PCE_PCT_DIFFERENCES.C_times_B(i,:) = PCE_RESULTS.C_times_B(i).val  -  PCT_RESULTS.C_times_B(i).val;
	PCE_PCT_DIFFERENCES.A_times_D(i,:) = PCE_RESULTS.A_times_D(i).val  -  PCT_RESULTS.A_times_D(i).val;
	PCE_PCT_DIFFERENCES.D_times_A(i,:) = PCE_RESULTS.D_times_A(i).val  -  PCT_RESULTS.D_times_A(i).val;

	PCE_PCT_DIFFERENCES.A_times_b(i,:) = PCE_RESULTS.A_times_b(i).val  -  PCT_RESULTS.A_times_b(i).val;
	PCE_PCT_DIFFERENCES.A_times_c(i,:) = PCE_RESULTS.A_times_c(i).val  -  PCT_RESULTS.A_times_c(i).val;
	PCE_PCT_DIFFERENCES.C_times_b(i,:) = PCE_RESULTS.C_times_b(i).val  -  PCT_RESULTS.C_times_b(i).val;
	PCE_PCT_DIFFERENCES.A_times_d(i,:) = PCE_RESULTS.A_times_d(i).val  -  PCT_RESULTS.A_times_d(i).val;
	PCE_PCT_DIFFERENCES.d_times_A(i,:) = PCE_RESULTS.d_times_A(i).val  -  PCT_RESULTS.d_times_A(i).val;

end %for

fprintf('DONE.\n\n');

%===================================================================================================

end

%===================================================================================================
fprintf('!!! END OF SCRIPT.\n\n');
beep;
%===================================================================================================
%###################################################################################################
%===================================================================================================