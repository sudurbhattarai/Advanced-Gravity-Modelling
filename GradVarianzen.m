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

function [gv, degree] = GradVarianzen(Cnm, Snm, GM, R, nmax)

gv = zeros(nmax+1,1);
degree = zeros(nmax+1,1);
faktor = (GM/R)^2;
for n = 0:nmax
    gv(n+1) = 0;
    degree(n+1) = n;
    for m = 0:1:n
        gv(n+1) = gv(n+1) + Cnm(n+1,m+1)^2 + Snm(n+1,m+1)^2;
    end
    gv(n+1) = faktor*gv(n+1);
end
