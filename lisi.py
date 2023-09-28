import numpy

def lisi(x,y):
    
    C1 = 1e-4
    C2 = 1e-4
    D = C1/2
    z = numpy.abs(x+y)/(numpy.abs(x-y)+C1)
    num = numpy.sum(z)
    den = numpy.maximum(numpy.sum(x),numpy.sum(y))+C2
    out = D*num/den
    
    return out
