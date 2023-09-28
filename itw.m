function [out] = itw(recon,ref,varargin)
    L = 1;
    [m n] = size(recon);
    type = varargin{1};
    type = validatestring(type,{'Gau','tanh','sigm'});
    
    ave_recon = 0;
    ave_ref = 0;
    
    wx = 0;
    for i = 1:m
        for j = 1:n
            wx = wx + weighting(recon(i,j),type);
        end
    end
    
    wy = 0;
    for i = 1:m
        for j = 1:n
            wy = wy + weighting(ref(i,j),type);
        end
    end
    
    for i = 1:m
        for j = 1:n
            ave_recon = ave_recon + recon(i,j)*weighting(recon(i,j),type)/wx;
            ave_ref = ave_ref + ref(i,j)*weighting(ref(i,j),type)/wy;
        end
    end
    
%     wmean_recon = weighting(ave_recon,type)/wx;
%     wmean_ref = weighting(ave_ref,type)/wy;
    
    var_recon = 0;
    var_ref = 0;
    for i = 1:m
        for j = 1:n
            var_recon = var_recon + (weighting(recon(i,j),type)/wx*m*n*recon(i,j)-ave_recon)^2;
            var_ref = var_ref + (weighting(ref(i,j),type)/wy*m*n*ref(i,j)-ave_ref)^2;
        end
    end
    var_recon = var_recon/(m*n-1);
    var_ref = var_ref/(m*n-1);
    
    cov_recon_ref = 0;
    for i = 1:m
        for j = 1:n
            cov_recon_ref = cov_recon_ref + (weighting(recon(i,j),type)/wx*m*n*recon(i,j)-ave_recon)*(weighting(ref(i,j),type)/wy*m*n*ref(i,j)-ave_ref);
        end
    end
    cov_recon_ref = cov_recon_ref/(m*n-1);
    
    k1 = 0.01;
    k2 = 0.03;
    c1 = (k1*L)^2;
    c2 = (k2*L)^2;
    c3 = c2/2;
    
    out = (2*ave_recon*ave_ref+c1)*(2*cov_recon_ref+c2)/(ave_recon^2+ave_ref^2+c1)/(var_recon+var_ref+c2);
end

function [out] = weighting(in,type)
    switch type
        case 'Gau'
            % Gaussian
            out = 2.5066/sqrt(2*pi)*exp(-9/2*(in-1)^2);
        case 'tanh'
            % tanh
            out = tanh(3*in-3)+1;
        case 'sigm'
            % sigmoid
            out = 1/(1+exp(-7*in+7))*2;
    end
end
