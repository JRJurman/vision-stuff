# Lab6 Radiometry Code (Python Variant)
# Created By Jesse Jurman
import numpy as np
import matplotlib.pyplot as plt
import math
from collections import OrderedDict

files = {
    'DSC8364': {
        'dist': 22.0,
        'f#': 8,
        'px/cm': 145.0
    },
    'DSC8365': {
        'dist': 35.5,
        'f#': 8,
        'px/cm': 150.0
    },
    'DSC8368': {
        'dist': 50.0,
        'f#': 5.8,
        'px/cm': 129.0
    }
}

# this program takes time, so I'm building a loading bar
def bar( prog, limit, bar_size=80 ):
    value = int((prog / limit)*bar_size) 
    svalue = bar_size - value
    print( "[" + "|"*int((prog / limit)*bar_size) + " "*svalue + "]", end="\r" )

# function to plot 
def simPlot( plotDict, title="Plot", xLabel="x", yLabel="y" ):
    # first we need to find the lowest and highest wavelength
    angle = list(plotDict.keys())
    counts = list(plotDict.values())

    x = np.array(angle)
    y = np.array(counts)

    # all the matplotlib stuff...
    fig = plt.figure()
    fig.suptitle(title)
    plt.xlabel(xLabel)
    plt.ylabel(yLabel)
    plt.plot(x, y)
    plt.grid(True)

# function to plot a given mapping of theta to digital counts 
def dictPlot( plotDict, refDict, title="Plot", xLabel="angle (in degrees)", yLabel="digital counts (peak normalize)" ):
    # first we need to find the lowest and highest wavelength
    angle = list(plotDict.keys())
    counts = list(plotDict.values())
    ref_counts = list(refDict.values())

    x = np.array(angle)
    y = np.array(counts)
    ref_y = np.array(ref_counts)

    # all the matplotlib stuff...
    fig = plt.figure()
    fig.suptitle(title)
    plt.xlabel(xLabel)
    plt.ylabel(yLabel)
    if (title.index('vs')):
        label1 = title.split('vs')[0]
        label2 = title.split('vs')[1]
    else:
        label1 = "measured data"
        label2 = "cos(theta)"
    plt.plot(x, y, label=label1)
    plt.plot(x, ref_y, label=label2, linestyle='--')
    plt.ylim((0.85,1.15))
    plt.xlim((-20,20))
    plt.grid(True)
    plt.legend(loc="best", framealpha=0.5)

# takes in a file name, and returns a mapping of pixels to digital counts
def recordingToDict( fileName ):
    finalTable = dict()
    for line in open(fileName, 'r'):

        # for the values, we strip leading whitespace, and split by tabs
        pixels = float(line.strip().split('\t')[0])
        counts = float(line.strip().split('\t')[1])

        finalTable[ pixels ] = counts

    return finalTable

# quadratic mean error between two curves
# aka Root Mean Square
# function taken from lab
def RMS( curveOne, curveTwo ):
    sum = 0
    # for every value, subtract the value of x at curveTwo from curveOne
    # this assumes that curveOne has the same number of values as curveTwo
    for x in curveOne:
        sum += (curveOne[ x ] - curveTwo[ x ])**2

    result = sum / len(curveOne)
    result = result ** (0.5)

    return result

# peak normalize
# returns a curve that is peak normalized
# that is to say, all the values have been divided by the
# largest value
def peakNormalize( curve ):
    values = list(curve.values())
    values.sort()
    peak = values[len(values)-1]

    peak_curve = {}
    for pixels in curve:
        peak_curve[ pixels ] = curve[ pixels ] / peak

    return peak_curve

# anglize
# returns a curve where the keys are the angles off of the peak
# this depends on a curve, a pixel to cm ratio, and a distance
# if it's not obvious, this is very specialized to the Lab6 analysis
def anglize( curve, pixelToCm, distance ):
    values = list(curve.values())
    values.sort()
    # we're treating the peak value as the center where theta=0
    peakDC = values[len(values)-1]

    # flip the curve, so we can get the corresponding theta..
    # taken from StackOverflow
    dcToDist = dict(zip(curve.values(), curve.keys()))
    peakDist = dcToDist[ peakDC ]

    angle_curve = dict()
    for pixels in curve:
        # figure out how many centimeters we are from the center
        cmsOff = (pixels - peakDist)/pixelToCm
        # get theta
        thetaRAD = math.atan( cmsOff / distance )
        # turn it into degrees
        theta = math.degrees( thetaRAD )
        
        angle_curve[ theta ] = curve[ pixels ]

    # we need to order the theta values if we want the plot to look nice (and not bounce from the ends back-and-forth
    ordered_angle_curve = OrderedDict(sorted(angle_curve.items()))

    return ordered_angle_curve

# build reference curve
# takes in a list of thetas, and the n value
def buildRef( thetas, n ):
    reference = dict()
    for t in thetas:
        peak = 1 # because it's normalized!
        reference[ t ] = peak * math.cos( math.radians(t) )**n

    ordered_reference = OrderedDict(sorted(reference.items()))

    return ordered_reference
        
# create tables for all our recordings
for fileName in files:
    files[fileName]['pixel-count'] = recordingToDict( fileName+'.txt' )

# do other things with the recordings now
for fileName in files:
    curve = files[fileName]['pixel-count']
    pixelCm = files[fileName]['px/cm']
    distance = files[fileName]['dist']

    # create peak-normalized plots
    peakCurve = peakNormalize( curve ) 
    files[fileName]['peak-pixel-count'] = peakCurve

    # create angle curves off the center
    angleCurve = anglize( peakCurve, pixelCm, distance )
    files[fileName]['peak-angle-count'] = angleCurve

# finally, find the lowest RMS error
for fileName in files:
    print( "processing for " + fileName )
    curve = files[fileName]['peak-angle-count']

    RMSresults = dict()
    for n100 in range(100, 900, 10):
        n = n100/100.0
        bar( n-1, 8 )
        ref = buildRef( list(curve.keys()), n )
        error = RMS( ref, curve )
        RMSresults[ error ] = n

    ordered_results = OrderedDict(sorted(RMSresults.items(), key=lambda i: i[1]))
    simPlot(ordered_results, "Error vs Exponent ({})".format(fileName), "error", "n")
    plt.show()
    
    # calculate the best fit by sorting the keys (which are our errors)
    print("")
    rmsSort = list(RMSresults.keys())
    rmsSort.sort()

    rmsBest = rmsSort[0]
    print( "RMS Error:\t" + str(rmsBest) )
    print( "n value:\t" + str(RMSresults[rmsBest]) )

    bestRefCurve = buildRef( list(curve.keys()), RMSresults[rmsBest] )
    testRefCurve = buildRef( list(curve.keys()), 9 )
    dictPlot( curve, bestRefCurve, fileName + " vs cos(theta)^" + str(RMSresults[rmsBest]) ) 
    plt.show()

