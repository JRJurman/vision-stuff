""" DFT, created by Jesse Jurman """
import cmath

# As a clarification, lambda n: f(n), builds a function f, with argument n.
# It is a shorthand to def, that allows me to pass functions with arguments 
#   that I might not know off the bat...

# Another clarification, I'm returning functions here, because it is not
#   important that the DFT be responsible for every value of k, just the
#   function that takes in argument k...

class DFT:
    """ class that contains functions for solving the DFT function """

    def asFunction( array ):
        """ return an array as a function (which is what everything
            in this class assumes F to be ) """

        # check if it's actually an array, otherwise just return the function
        if ( isinstance( array, list ) ):
            def F(n):
                return array[n]
        else:
            F = array
        
        # return the functionize version of array
        return F

    def summation( func, rangeN ):
        """ function that takes a function and a range of values
            and returns a summation of value in that range.
            range should be a range object, e.g. range(1, 10, 1)"""

        sum = 0
        for n in rangeN:
            sum += func( n )

        return sum

    def re( F, N, normalized=False):
        """ returns a function to solve real part of the dft for k """

        # turn F into a function if it's an array
        F = DFT.asFunction( F )

        def realPart( n, N, k ):
            """ given a value n, N, and k, return the real part of a function F """

            phase = 2 * cmath.pi * ( n * k ) / N
            return F(n)*cmath.cos(phase)

        def real( k ):
            """ given a value k, return a summation of all values of the real part """

            # n is 1/N^2 if we are normalizing, otherwise it's 1
            n = ((1*normalized)/(N)**0.5) or 1
            return n*DFT.summation( lambda n: realPart( n, N, k ), range(0, N) )

        # returns the function, so that you can just throw k at it, and run
        return real

    def im( F, N, normalized=False):
        """ returns a function to solve imaginary part of the dft for k """

        # turn F into a function if it's an array
        F = DFT.asFunction( F )

        def imagPart( n, N, k ):
            """ given a value n, N, and k, return the imaginary part of a function F """

            phase = 2 * cmath.pi * ( n * k ) / N
            return -F(n)*cmath.sin(phase)

        def imag( k ):
            """ given a value k, return a summation of all values of the imaginary part """

            # n is 1/N^2 if we are normalizing, otherwise it's 1
            n = ((1*normalized)/(N)**0.5) or 1
            return n*DFT.summation( lambda n: imagPart( n, N, k ), range(0, N) )

        # returns the function, so that you can just throw k at it, and run
        return imag

    def dft( F, N, norm=False ):
        """ returns a function to return both parts of the dft for a function
            F over N values """

        # turn F into a function if it's an array
        F = DFT.asFunction( F )

        def res( k ):
            """ given a value k, returns a complex value of both the real part
                (given a value k) and the imaginary part (given a value k) of F
                over N values. """

            return complex( DFT.re( F, N, norm )(k), DFT.im( F, N, norm )(k) )

        return res
