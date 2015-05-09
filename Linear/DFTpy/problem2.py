from DFTsolver import DFT
from Plotter import Plotter
import cmath

a = [ 1.0/3.0,
      1.0/3.0,
      0,
      0,
      0,
      0,
      0,
      1.0/3.0
    ]

b = [ 1.0/3.0,
      1.0/3.0,
      1.0/3.0,
      0,
      0,
      0,
      0,
      0
    ]

c = [ 1,
      1.0/(2**0.5),
      0,
      -1.0/(2**0.5),
      -1,
      -1.0/(2**0.5),
      0,
      1.0/(2**0.5)
    ]

d = [ +1,
      -1,
      +1,
      -1,
      +1,
      -1,
      +1,
      -1
    ]

e = [ +1,
      +1,
      +1,
      +1,
      -1,
      -1,
      -1,
      -1
    ]

N = 8
for i in [(a, 'a'), (b, 'b'), (c, 'c'), (d, 'd'), (e, 'e')]:
    func = i[0]
    name = i[1]
    Plotter.plotRealAndImaginary( DFT.dft(func, N), N, "problem 2: part "+name)
    Plotter.show()
