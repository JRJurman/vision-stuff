import cmath

for i in range(0, 16):
    for j in range(0, 16):
        divider = 1
        for k in range(1, i*j+1):
            if (16 // k == 16 / k) and (i*j // k == i*j / k):
                divider = k 
        #input( "{}/16 : {}/{}".format(i, i*j // divider, 16 // divider) )

for i in range(0, 16):
    for j in range(0, 16):
        p = complex(0, -1)*2*cmath.pi
        comp = cmath.exp( p*( i*j/16 ) ) 
        if (comp.real < 0.00001 and comp.real > -0.00001):
            comp = complex(0, comp.imag)
        if (comp.imag < 0.00001 and comp.imag > -0.00001):
            comp = complex(comp.real, 0)
        first = ""
        second = "plus"
        if (comp.real < 0):
            first = "negative"
        if (comp.imag < 0):
            second = "minus"
        #input( "{}/16 : {} {} {} {}i".format(i, first, abs(round(comp.real, 3)), second, abs(round(comp.imag, 3))) )

for i in range(0, 3):
    for j in range(0, 3):
        p = complex(0, -1)*2*cmath.pi
        comp = cmath.exp( p*( i*j/3 ) ) 
        if (comp.real < 0.00001 and comp.real > -0.00001):
            comp = complex(0, comp.imag)
        if (comp.imag < 0.00001 and comp.imag > -0.00001):
            comp = complex(comp.real, 0)
        input( "{}/16 : {} {}i".format(i, round(comp.real, 3), round(comp.imag, 3)) )
