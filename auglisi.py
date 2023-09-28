import numpy

def auglisi(x,y):
    
    C = 1e-4
    z = numpy.abs(x+y)*numpy.abs(x-y)
    num = numpy.sum(z)
    den = numpy.sum(x)+numpy.sum(y)
    den = den+C
    out = 1-num/den
    
    return out
