# Weber's Law in Python (script)
# Written by Jesse Jurman (jrj2703)

# using the pylab library
import matplotlib.pyplot as plt
import numpy

# weber function
def weber(intensity, slope):
    return intensity*slope

# values to be evaluated, with a color for the graph
kMap = [
    {'value':0.03, 'color':'g'},
    {'value':0.05, 'color':'m'},
    {'value':0.02703, 'color':'b'},
]

# Set up figure for the plots
figure = plt.figure()
plt.title('Weber\'s Law: Delta-I = I*k || Jesse Jurman (jrj2703)')
plt.xlabel('Stimulus Intensity (I)');
plt.ylabel('Threshold Change (Delta-I)');

# Iterate through the values, and plot the graphs
intensity = numpy.arange(0, 50, 2.5)
for k in kMap:
    di = weber(intensity, k['value'])
    plt.plot(intensity, di, k['color'])

# Show and save the graph, also hold the window open with input
figure.show()
plt.savefig("PythonResult.png")
input()
