from DFTsolver import DFT
from Plotter import Plotter
import cmath

problems = {
    'a': { 
        'func': lambda n: cmath.cos(2 * cmath.pi * (n / 64) ),
        'N': 64
    },
    'b': {
        'func': lambda n: cmath.cos(2 * cmath.pi * (n / 32) ),
        'N': 32
    },
    'c': {
        'func': lambda n: cmath.cos(2 * cmath.pi * ((n*3)/64)),
        'N': 64
    },
    'd': {
        'func': lambda n: cmath.cos(2 * cmath.pi * ((n*4)/16)),
        'N': 16 
    },
    'f': {
        'func': lambda n: cmath.sin(2 * cmath.pi * ((n)/64)),
        'N': 64
    }
}

for p in sorted(list(problems.keys())):
    func = problems[p]['func']
    N = problems[p]['N']
    Plotter.plotRealAndImaginary( DFT.dft(func, N), N, "problem 3: part "+ p )
    Plotter.show()
