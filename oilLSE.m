function phi = oilLSE(phi0,nu,timestep,mu,m,epsilon,numIter)

phi=phi0;
for k1=1:numIter
    phi=NeumannBoundCond(phi);
    K=curvature_central(phi);                             

    DrcU=Dirac(phi,epsilon);                
                                                    
    A=DrcU.*m;                                 
    P=mu*(4*del2(phi)-K);                                 
    L=nu.*DrcU.*K;                                      
    phi=phi+timestep*(L+P+A);                              
end                                
                                                         




