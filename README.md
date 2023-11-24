# EPIC 2
EPIC 2 - Easy PolynomIal Chaos (v2.0.0)

Matlab and Gnu Octave toolbox for probabilistic and uncertainty algebra and modeling, using generalized polynomial chaos expansion.

Authors: Matthew Milton, Andrea Benigni, Antonello Monti          
mmilton@email.sc.edu, a.benigni@fz-juelich.de, amonti@eornerc.rwth-aachen.de

This toolbox has been tested on Matlab R2017b and Gnu Octave 5.1.0

## Notice

Currently, only scalar and per-element matrix operators are tested.  Full matrix operators are still under testing and are buggy.  Legendre polynomials have been tested but other polynomials have not.

## Changes

See test/testPCEType.m for how to use the newer version of the EPIC toolbox and its pce data type. This script compares the older pct type, which only supports Legendre polynomials, with the newer pce type that supports arbitrary orthogonal polynomials.

In general, the newest version of EPIC, v2, centers around the new pce data type which supports arbitrary orthogonal polynomials. The
vector space expressed by the polynomials are defined by PolynomialChaosSpace objects which stores the number of uncertain variables
are in the space, the number of polynomial terms per expansion in the space, and the inner products of the polynomials for the space.  Each polynomial chaos expansion (pce) object is constructed with handle to a PolynomialChaosSpace object that defines the pce object's space.  All algebra on the pce object will use the space information to perform the math operations.  The pce objects must be in the same space for algebra to be compatible between them.

The following major changes from earlier version of EPIC are:
* Support for arbitrary orthogonal polynomials
* Deprecation of pct type for favor of pce type
* Separation of vector space information from pce type through PolynomialChaosSpace type
* Removal of global and static variables in the pce types
* Addition of utility functions for initializing pce matrices/arrays of ones and zeros, and typecasting between pce and double.
* General optimizations of operations for performance (removal of globals, use of handles, initialize vector sizes to remove resizing, etc.)

