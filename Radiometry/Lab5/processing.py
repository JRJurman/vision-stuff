# Lab5 Radiometry Code (Python Variant)
# Created By Jesse Jurman
import numpy as np
import matplotlib.pyplot as plt
import math

fileNames = ["sample", "reference", "dark", "JESSE_cal_coef_cc_resamp"]

# this program takes time, so I'm building a loading bar
def bar( prog, limit, bar_size=80 ):
    value = int((prog / limit)*bar_size) 
    svalue = bar_size - value
    print( "[" + "|"*int((prog / limit)*bar_size) + " "*svalue + "]", end="\r" )

# function to plot a given mapping of wavelengths to numbers
def plot( waveMap, title="Plot", xLabel="wavelength", yLabel="digital value" ):
    # first we need to find the lowest and highest wavelength
    wavelengths = list(waveMap.keys())
    digital_values = list(waveMap.values())
    x = np.array(wavelengths)
    y = np.array(digital_values)

    # all the matplotlib stuff...
    fig = plt.figure()
    fig.suptitle(title)
    plt.xlabel(xLabel)
    plt.ylabel(yLabel)
    plt.plot(x, y)
    plt.grid(True)

# function two plots of a given mapping of wavelengths to numbers
def twoPlot( waveMap, waveMap2, title="Plot", xLabel="wavelength", yLabel="digital value" ):
    # first we need to find the lowest and highest wavelength
    wavelengths = list(waveMap.keys())

    digital_values = list(waveMap.values())
    digital_values2 = list(waveMap2.values())
    x = np.array(wavelengths)
    y = np.array(digital_values)
    y2 = np.array(digital_values2)

    # all the matplotlib stuff...
    fig = plt.figure()
    fig.suptitle(title)
    plt.xlabel(xLabel)
    plt.ylabel(yLabel)
    plt.plot(x, y, x, y2)
    plt.grid(True)

# takes in a file name, and returns a mapping of wavelengths to digital numbers
def recordingToDict( fileName ):
    finalTable = dict()
    for line in open(fileName, 'r'):

        # for the values, we strip leading whitespace, and split by tabs
        wavelength = float(line.strip().split('\t')[0])
        digital_number = float(line.strip().split('\t')[1])

        finalTable[ wavelength ] = digital_number

    return finalTable

# quadratic mean error between two curves
# aka Root Mean Square
# function taken from lab
def RMS( curveOne, curveTwo ):
    sum = 0
    # for every value, subtract the value of x at curveTwo from curveOne
    # this assumes that curveOne has the same number of values as curveTwo
    for wavelength in curveOne:
        sum += (curveOne[ wavelength ] - curveTwo[ wavelength ])**2 

    result = sum / len(curveOne)
    result = result ** (0.5)

    return result

# plank's function
# takes in a Temp and a wavelength
def planck( w, t ):
    kb = 1.380 * 10**(-23)  # boltzmann constant [ J / K ]
    h = 6.626 * 10**(-34)   # Planck's constant [ J * s ]
    c = 2.997 * 10**(8)     # speed of light [ m / s ]
    w = w*1e-9              # turn wavelength to meters

    numer = 2 * h * (c)**2
    den1 = (w)**5
    num = numer / den1

    comp = (h * c) / ( (w) * kb * t )
    den2 = math.exp( comp ) - 1

    return (num / den2)/10**9 # turn it back to nm

# peak normalize
# returns a curve that is peak normalized
# that is to say, all the values have been divided by the
# largest value
def peakNormalize( curve ):
    values = list(curve.values())
    values.sort()
    peak = values[len(values)-1]

    peak_curve = {}
    for wavelength in curve:
        peak_curve[ wavelength ] = curve[ wavelength ] / peak

    return peak_curve


# create tables for all our recordings (and then some)
# I'm using exec to create variables... don't do this unless you have too.
# I'm doing it because it's fun...
for name in fileNames:
    exec_string = "{} = recordingToDict( '{}.txt' )".format(name, name) 
    print( exec_string ) # just show us what you're doing
    exec( exec_string )


# create our sample calibration with the data
# we use sample here, but any of the tables would have worked, we just want keys
sample_cal = dict()
for wavelength in sample:

    # subtract the dark value from the sample and references
    sampleValue = sample[ wavelength ] - dark[ wavelength ]
    referenceValue = reference[ wavelength ] - dark[ wavelength ]
    ccValue = JESSE_cal_coef_cc_resamp[ wavelength ]

    sample_cal[ wavelength ] = ( sampleValue / referenceValue ) * ccValue


# for every temperature, check with RMS
RMSresults = dict()
for t in range(300, 5800):

    bar(t, 5800)
    # build the planck plots
    planck_plot = dict()
    for wavelength in sample:
        planck_plot[ wavelength ] = planck( wavelength, t )

    # build dictionary of RMS values to temperatures
    RMSresults[ RMS( peakNormalize(sample_cal), peakNormalize(planck_plot) ) ] = t
    
# calculate the best fit by sorting the keys (which are our errors)
print("")
rmsSort = list(RMSresults.keys())
rmsSort.sort()
rmsBest = rmsSort[0]
print( "error: " + str(rmsBest) )
print( "temperature: " + str(RMSresults[rmsBest]) )

planck_plot = dict()
for wavelength in sample:
    planck_plot[ wavelength ] = planck( wavelength, RMSresults[rmsBest] )

twoPlot( peakNormalize(planck_plot) , peakNormalize(sample_cal), "Peak Normalized Planckian Function and Sample Calibration" )
plt.show()

# get the error found with RMS
error = dict()
for wavelength in sample:
    error[ wavelength ] = abs( peakNormalize(planck_plot)[ wavelength ] - peakNormalize(sample_cal)[ wavelength ] )

plot( error, "Error" )
plt.show()
