import numpy

def tlisi(x,y,snap,maxx):
    
    C = 1e-6
    z = numpy.abs(x-y)
    num = numpy.mean(z)*numpy.max(z)
    den = numpy.maximum(maxx,C)*numpy.maximum(maxx,C)
    snap[snap==0] = C
    r = z/snap
    r[r>1] = 1
    ratio = numpy.mean(r)
    
    out = 1-num/den*ratio
    
    return out
