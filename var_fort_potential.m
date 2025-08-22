function vfp_potential = var_fort_potential(latitude, longitude, sCnm1, sSnm1, sCnm2, sSnm2, GM,h,a,e2, nmin,nmax)

% Varianzfortpflanzung nach Fehlerfortpflanzungsgesetz
% 
% Ausgabe:
% vfp_potential: Matrix Fehler Undulation (Potential für h =/= 0) 


I = size(latitude,1);
J = size(longitude,1);
vfp_pot = zeros(I,J);

% unkorrelierte Coeffizienten
% Genauigkeiten quadrieren, summieren, wurzel
sCnm_diff = (sCnm1.^2 + sCnm2.^2).^0.5;
sSnm_diff = (sSnm1.^2 + sSnm2.^2).^0.5;

% cos,sin matrix for all lambdas and all orders
cosm = cos([0:1:nmax]'*longitude');
sinm = sin([0:1:nmax]'*longitude');
cosmq = cosm.^2;
sinmq = sinm.^2;
for i = 1:I % loop over all parallels
  geozB = atan( (1-e2)*tan(latitude(i)) );
  theta = pi/2 - geozB;
  Pnm = Lfnm(theta, nmax);  % all Legendre Functions for one theta
  
  % degree dependent factors
  factor = zeros(1,nmax+1);
   for n = nmin:nmax
     r = a*sqrt(1-e2) / sqrt( 1-e2*(cos(geozB))^2 ) + h;
     factor(n+1) = ( (GM/r)*(a/r)^(n+1) )^2;
   end

  % compute result for all lambdas (one row) in one step (as matrix multiplications) 
  vfp_pot(i,:) = (factor * (sCnm_diff.*Pnm).^2 * cosmq) + (factor * (sSnm_diff.*Pnm).^2 * sinmq);
    
end

   vfp_potential = vfp_pot.^0.5;                      % Potential [m^2/s^2]



end
