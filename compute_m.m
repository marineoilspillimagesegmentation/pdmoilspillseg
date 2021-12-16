function m = compute_m(Ks,Img,Ktau,KONE,sigma1,sigma2,gamma1,gamma2,dim)
[row,col,dim]=size(Img);
I=Img;
for i=1:dim;
 s1=gamma2./sigma2.*Ks-gamma1./sigma1.*Ks;  
 s2=gamma2.*log(sigma2)-gamma1.*log(sigma1); 
m1=s1.*conv2(Img,Ktau,'same').*(I);
m2=s2.*conv2(Img,Ktau,'same');
m=m1+m2;
end

