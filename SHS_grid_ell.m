% Synthesis of Potential on a grid
%
% Input:
% theta:  I x 1 vector containing the co-latitudes (in radian).
% lambda: J x 1 vector containing the longitudes (in radian).
% Cnm, Snm: matricies containing the potential coefficients
% R:   Earth reference radius.
% r:   geocentric distance of the computation point (potenital-grid)
% GM:  geocentric gravitational constant
%
% Output:
% potential:  I x J matrix [ m^2 / s^2 ]


function potential = SHS_grid_ell(latitude, longitude, Cnm, Snm, GM,h,a,e2, nmin,nmax)

I = size(latitude,1);
J = size(longitude,1);
% potential grid(I x J)
pot = zeros(I,J);


% cos,sin matrix for all lambdas and all orders
cosm = cos([0:1:nmax]'*longitude');
sinm = sin([0:1:nmax]'*longitude');

for i = 1:I % loop over all parallels
  geozB = atan( (1-e2)*tan(latitude(i)) );
  theta = pi/2 - geozB;
  Pnm = Lfnm(theta, nmax);  % all Legendre Functions for one theta
                            % P_0_0 = 1 = Pnm(1,1)
  
  % degree dependent factors
  factor = zeros(1,nmax+1);
   for n = nmin:nmax
     r = a*sqrt(1-e2) / sqrt(1-e2*cos(geozB)) + h;
     factor(n+1) = (GM/r)*(a/r)^(n+1);
   end


  % compute result for all lambdas (one row) in one step (as matrix multiplications)
   pot(i,:) = ( factor * ((Cnm.*Pnm) * cosm + (Snm.*Pnm) * sinm) ) ;
     
  %waitbar(i/I)
  
end
   
   potential = pot;                              % Potential [m^2/s^2]


end



