from DFTsolver import DFT
from Plotter import Plotter
import cmath

def a(n):
    return {
        0: 1,
        1: -1,
        2: 2,
        3: 3,
    }[n]

N = 4
Plotter.plotRealAndImaginary( DFT.dft(a, N), N, "class problem")
Plotter.show()
