import numpy

def itw(x,y,type_str):
    L = 1
    m, n = x.shape
    type_str = validate_string(type_str, ['Gau', 'tanh', 'sigm'])
    
    weix = weighting(x, type_str)
    wx = numpy.sum(weix)
    weiy = weighting(y, type_str)
    wy = numpy.sum(weiy)
    
    ave_recon = numpy.sum(x * weix / wx)
    ave_ref = numpy.sum(y * weiy / wy)
    
    var_recon = numpy.sum((weix / wx * m * n * x - ave_recon) * (weix / wx * m * n * x - ave_recon)) / (m * n - 1)
    var_ref = numpy.sum((weiy / wy * m * n * y - ave_ref) * (weiy / wy * m * n * y - ave_ref)) / (m * n - 1)
    
    cov_recon_ref = numpy.sum((weix / wx * m * n * x - ave_recon) * (weiy / wy * m * n * y - ave_ref)) / (m * n - 1)
    
    k1 = 0.01
    k2 = 0.03
    c1 = (k1 * L) ** 2
    c2 = (k2 * L) ** 2
    
    out = (2 * ave_recon * ave_ref + c1) * (2 * cov_recon_ref + c2) / (ave_recon ** 2 + ave_ref ** 2 + c1) / (var_recon + var_ref + c2)
    return out

def weighting(in_data, type_str):
    if type_str == 'Gau':
        # Gaussian
        out = 2.5066 / numpy.sqrt(2 * numpy.pi) * numpy.exp(-9/2 * (in_data - 1) ** 2)
    elif type_str == 'tanh':
        # tanh
        out = numpy.tanh(3 * in_data - 3) + 1
    elif type_str == 'sigm':
        # sigmoid
        out = 1 / (1 + numpy.exp(-7 * in_data + 7)) * 2
    return out

def validate_string(value, valid_options):
    if value not in valid_options:
        raise ValueError(f"'{value}' is not a valid option. Choose from {valid_options}")
    return value
