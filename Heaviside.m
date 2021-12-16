function Hphi = Heaviside(phi,epsilon)
Hphi = 0.5*(1+2/pi*atan(phi./epsilon));
end

