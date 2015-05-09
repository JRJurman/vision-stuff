from DFTsolver import DFT
from Plotter import Plotter
import cmath

def a(n):
    return [5,-4,3,10][n]

N = 4
Plotter.plotRealAndImaginary( DFT.dft(a, N), N, "class problem")
Plotter.show()
