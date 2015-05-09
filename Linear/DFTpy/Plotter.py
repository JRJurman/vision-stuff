import matplotlib.pyplot as plt
import numpy as np
import cmath

class Plotter:
    def plotRealAndImaginary( F, N, title="Plot", xLabel="k", yLabel="value" ):
        """ function to plot a given mapping of wavelengths to numbers
            first we need to find the lowest and highest wavelength """

        re_samples = dict()
        im_samples = dict()
        for k in range(0, N):
            res = F(k)
            re_samples[k] = res.real
            im_samples[k] = res.imag

        samples_x = list(re_samples.keys())
        re_samples_y = list(re_samples.values())
        im_samples_y = list(im_samples.values())

        # all the matplotlib stuff...
        fig = plt.figure()
        fig.suptitle(title)
        plt.xlabel(xLabel)
        plt.ylabel(yLabel)
        plt.plot(samples_x, re_samples_y, label="Real")
        plt.plot(samples_x, im_samples_y, label="Imaginary", linestyle='--')

        # legends
        plt.legend(loc="best", framealpha=0.5)
        plt.grid(True)
        
    def show():
        plt.show()
