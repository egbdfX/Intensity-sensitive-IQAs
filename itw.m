function [out] = itw(recon,ref,varargin)
    L = 1;
    [m n] = size(recon);
    type = varargin{1};
    type = validatestring(type,{'Gau','tanh','sigm'});
    
    maxx = max(max(max(recon)),max(max(ref)));
    
    recon = recon/maxx;
    ref = ref/maxx;
    
    weix = weighting(recon,type);
    wx = sum(weix,'all');
    weiy = weighting(ref,type);
    wy = sum(weiy,'all');
    
    ave_recon = sum(recon.*weix/wx,'all');
    ave_ref = sum(ref.*weiy/wy,'all');
    
    var_recon = sum((weix/wx*m*n.*recon-ave_recon).*(weix/wx*m*n.*recon-ave_recon),'all')/(m*n-1);
    var_ref = sum((weiy/wy*m*n.*ref-ave_ref).*(weiy/wy*m*n.*ref-ave_ref),'all')/(m*n-1);
    
    cov_recon_ref = sum((weix/wx*m*n.*recon-ave_recon).*(weiy/wy*m*n.*ref-ave_ref),'all')/(m*n-1);
    
    k1 = 0.01;
    k2 = 0.03;
    c1 = (k1*L)^2;
    c2 = (k2*L)^2;
    
    out = (2*ave_recon*ave_ref+c1)*(2*cov_recon_ref+c2)/(ave_recon^2+ave_ref^2+c1)/(var_recon+var_ref+c2);
end

function [out] = weighting(in,type)
    switch type
        case 'Gau'
            % Gaussian
            out = 2.5066/sqrt(2*pi).*exp(-9/2.*(in-1).*(in-1));
        case 'tanh'
            % tanh
            out = tanh(3*in-3)+1;
        case 'sigm'
            % sigmoid
            out = 1./(1+exp(-7*in+7))*2;
    end
end
