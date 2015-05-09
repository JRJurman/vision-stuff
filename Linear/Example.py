import cmath

def fft(N, f):
    result = {}
    for k in range(0, N-1):
        sum = 0
        for n in range(0, N-1):
            phase = 2 * cmath.pi * n * ( k / N )
            sum += f(n) * complex( math.cos( phase ), math.sin( phase ) )
        result[k] = sum * ( 1 / N**(0.5) )

def f(n):
    if 
