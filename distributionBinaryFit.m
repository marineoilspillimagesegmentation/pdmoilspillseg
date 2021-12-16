function [sigma1,sigma2] = distributionBinaryFit(Img,phi,KI,KONE,Ktau,Ks,epsilon)
% compute sigma1 and sigma2 that correspond to the distribution
Hphi=Heaviside(phi,epsilon);                     

I=Img.*Hphi;
c1=conv2(Hphi,Ktau,'same');                             
c2=conv2(I,Ktau,'same');                              
sigma1=c2./(c1).*Ks;                                            
sigma2=(KI-c2)./(KONE-c1).*Ks;                                   
                                                        
end

