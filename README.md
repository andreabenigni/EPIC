# EPIC2
EPIC2 - Easy Polynomial Chaos (v.2.1.0)

Matlab toolbox for probabilistic and uncertainty algebra and modeling, using generalized polynomial chaos expansion.

Authors: Matthew Milton, Andrea Benigni, Sebastian Schwarz, Antonello Monti          
mmilton@email.sc.edu, a.benigni@fz-juelich.de, sschwarz@eonerc.rwth-aachen.de, amonti@eornerc.rwth-aachen.de

This toolbox has been tested on Matlab R2019a - Matlab R2022b

## Notice

Currently, only scalar and per-element matrix operators are tested.
Full matrix operators are still under testing.
Legendre and Hermite polynomials (for uniform and Gaussian distributions) have been tested.
The integration of other polynomial types is readily possible but linked to future work.

In general, the newest version of EPIC 2 centers around the pce data type which supports arbitrary orthogonal polynomials.
The vector space expressed by the polynomials are defined by PolynomialChaosSpace objects which stores the number of uncertain variables
in the space, the number of polynomial terms per expansion in the space, and the inner products of the polynomials for the space.
Each polynomial chaos expansion (pce) object is constructed with handle to a PolynomialChaosSpace object that defines the pce object's space.
All algebra on the pce object will use the space information to perform the math operations.
The pce objects must be in the same space for algebra to be compatible between them.
