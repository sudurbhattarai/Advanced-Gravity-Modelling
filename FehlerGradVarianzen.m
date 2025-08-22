% Gradvarianzen
%
% Input:
% Cnm, Snm: matricies containing the potential coefficients
% R:   Earth reference radius.
% r:   geocentric distance of the computation point (potenital-grid)
% GM:  geocentric gravitational constant
%
% Output:
% Gradvarianzen:  n+1 x 1 Vektor [ m^4 / s^4 ]

function [Fgv, degree] = FehlerGradVarianzen(sCnm1,sSnm1,sCnm2,sSnm2, GM, R, nmax)

Fgv = zeros(nmax+1,1);
degree = zeros(nmax+1,1);
faktor = (GM/R)^2;
for n = 0:nmax
    Fgv(n+1) = 0;
    degree(n+1) = n;
    for m = 0:1:n
        Fgv(n+1) = Fgv(n+1) + sCnm1(n+1,m+1)^2 + sSnm1(n+1,m+1)^2 + sCnm2(n+1,m+1)^2 + sSnm2(n+1,m+1)^2;
    end
    Fgv(n+1) = faktor*Fgv(n+1);
end
