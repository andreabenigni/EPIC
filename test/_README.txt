README for test directory of the EPIC(2) toolbox.

March 16, 2020

See testPCEType.m for how to use the newer version of the EPIC toolbox and its pce data type. This script compares the older pct type, 
which only supports Legendre polynomials, with the newer pce type that supports arbitrary orthogonal polynomials.

In general, the newest version of EPIC, v2, centers around the new pce data type which supports arbitrary orthogonal polynomials. The
vector space expressed by the polynomials are defined by PolynomialChaosSpace objects which stores the number of uncertain variables
are in the space, the number of polynomial terms per expansion, and the inner products of the polynomials for the space.  Each polynomial
chaos expansion (pce) object is constructed with handle to a PolynomialChaosSpace object that defines the pce object's space.  All algebra
on the pce object will use the space information to perform the math operations.  The pce objects must be in the same space for algebra
to be compatible between them.
