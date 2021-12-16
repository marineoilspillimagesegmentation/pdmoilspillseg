function  phi = NeumannBoundCond(phi)
[nrow,ncol] = size(phi);
phi = phi;
phi([1 nrow],[1 ncol]) = phi([3 nrow-2],[3 ncol-2]);  
phi([1 nrow],2:end-1) = phi([3 nrow-2],2:end-1);          
phi(2:end-1,[1 ncol]) = phi(2:end-1,[3 ncol-2]); 
end

