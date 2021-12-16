function k = curvature_central(phi) 
[phix,phiy] = gradient(phi);                                  
normDu = sqrt(phix.^2+phiy.^2+1e-10);                       
                                                      
Nx = phix./normDu;                                       
Ny = phiy./normDu;
[phixx,junk] = gradient(Nx);                              
[junk,phiyy] = gradient(Ny);                              
k = phixx+phiyy;   
end

