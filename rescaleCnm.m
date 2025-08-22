
function [Cnm,Snm] = rescaleCnm(Cnm0, Snm0, GM,R, GM0,R0, nmax)

Cnm = zeros(nmax+1,nmax+1);
Snm = zeros(nmax+1,nmax+1);

for n = 0:1:nmax
    factor = (GM0/GM) * (R0/R)^(n+1);
    for m = 0:1:n
        Cnm(n+1,m+1) = factor*Cnm0(n+1,m+1);
        Snm(n+1,m+1) = factor*Snm0(n+1,m+1);
    end
end
