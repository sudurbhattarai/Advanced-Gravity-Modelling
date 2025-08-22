% Calculation of all Legendre Functions (4pi-normalized)
% up to given degree and order at a specific co-latitude.
%
% Input:
% theta: co-latitude in radian.
% nmax: maximum degree and order to compute.
%
% Output:
% Pnm: matrix containing the 4pi-normalized Legendre functions.
% The dimension is (n + 1) x (n + 1) with n = nmax.
% The lower triangular matrix element Pnm(n + 1, m + 1)
% contains the Legendre function of degree n and order m.

function Pnm = Lfnm(theta, nmax)

global legendreFactor1;
global legendreFactor2;

% init legendre factors at the first time
if (size(legendreFactor1,1) < nmax+1)
  legendreFactor1 = zeros(nmax+1, nmax+1);
  legendreFactor2 = zeros(nmax+1, nmax+1);
  legendreFactor1(2,2) = sqrt(3);
  for n=2:nmax
    legendreFactor1(n+1,n+1) = sqrt((2*n+1)/(2*n));
  end
  for m=0:nmax-1
    for n=m+1:nmax
      f=(2*n+1)/((n+m)*(n-m));
      legendreFactor1(n+1,m+1) = sqrt(f*(2*n-1));
      legendreFactor2(n+1,m+1) = sqrt(f*(n-m-1)*(n+m-1)/(2*n-3));
    end
  end
end

cosTheta = cos(theta);
sinTheta = sin(theta);

% init output matrix
Pnm = zeros(nmax+1, nmax+1);
Pnm(1,1)=1;
% 1st recursion
for n=1:nmax
  Pnm(n+1,n+1) = legendreFactor1(n+1,n+1)*sinTheta*Pnm(n,n);
end
% 2nd recursion
for m=0:nmax-1
  Pnm(m+2,m+1) = legendreFactor1(m+2,m+1)*cosTheta*Pnm(m+1,m+1);
end
% 3nd recursion
for m=0:nmax-1
  for n=m+2:nmax
    Pnm(n+1,m+1) = legendreFactor1(n+1,m+1)*cosTheta*Pnm(n,m+1)-legendreFactor2(n+1,m+1)*Pnm(n-1,m+1);
  end
end
