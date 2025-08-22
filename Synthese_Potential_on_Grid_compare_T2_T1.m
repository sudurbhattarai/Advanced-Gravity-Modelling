%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% comares to monthly solutions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% User Input

% Workspace Reset
clc;
clear all;
close all;
format long;

addpath('./cptcmap')

% Defining some constants/parameters GRS80
deg2rad	= pi/180;       % [rad/deg] Umrechnungsfaktor
h_V     = 500e+3;       % [m] Height of the Potentialgrid above the Ellipsoid
nmin    = 2;            % minimaler Grad der Kugelfunktionsentwicklung
R       = 6378136.3;
GM      = 0.3986004415e+15;
a       = 6378137;
e2      = 0.00669438002290;
abbruch =0;
nmax_break =25;
institution = 'KIT'

% Grid is center of cell
% spaceing of the grid [°]
DlatitudeDEG  = 1.0;
DlongitudeDEG = 1.0;
latitude_V_max  = +90;
latitude_V_min  = -90;
longitude_V_min = -180;
longitude_V_max = 180;
latitude_V_max  = latitude_V_max - DlatitudeDEG/2;
latitude_V_min  = latitude_V_min + DlatitudeDEG/2;
longitude_V_min = longitude_V_min + DlongitudeDEG/2;
longitude_V_max = longitude_V_max - DlongitudeDEG/2;

longitudeDEG_V(:,1) = (longitude_V_min:+DlongitudeDEG:longitude_V_max);
latitudeDEG_V(:,1)  = (latitude_V_max :-DlatitudeDEG : latitude_V_min);

% convert degree to rad
latitude_V_max  = latitude_V_max  *deg2rad;
latitude_V_min  = latitude_V_min  *deg2rad;
longitude_V_min = longitude_V_min *deg2rad;
longitude_V_max = longitude_V_max *deg2rad;
Dlatitude       = DlatitudeDEG    *deg2rad;
Dlongitude      = DlongitudeDEG   *deg2rad;

longitude_V(:,1) = (longitude_V_min:+Dlongitude:longitude_V_max);
latitude_V(:,1)  = (latitude_V_max: -Dlatitude: latitude_V_min);
[anzLON_V, temp]  = size(longitude_V);
[anzLAT_V, temp]  = size(latitude_V);
clear temp

gamma_ell = normalschwere_ell(a, anzLAT_V, anzLON_V, latitude_V); % Normalschwere GRS80

%% Computations and Plots

filename1 = 'EIGENt3.gfc';
filename2 = 'EIGENt4.gfc';
tic

% read sperical harmonic coefficients
[Cnm1,Snm1,sCnm1,sSnm1,GM1,R1,nmax1,time_period_mid1,time_period_start1,time_period_stop1] = ReadCoefficientsICGEM(filename1,abbruch,nmax_break);
[Cnm2,Snm2,sCnm2,sSnm2,GM2,R2,nmax2,time_period_mid2,time_period_start2,time_period_stop2] = ReadCoefficientsICGEM(filename2,abbruch,nmax_break);
nmax = min(nmax1,nmax2);

% rescale the coefficients to defined R and GM
[Cnm1r,Snm1r] = rescaleCnm(Cnm1,Snm1,GM,R,GM1,R1,nmax);
[Cnm2r,Snm2r] = rescaleCnm(Cnm2,Snm2,GM,R,GM2,R2,nmax);
clear Cnm1 Snm1 Cnm2 Snm2

Cnm = Cnm2r - Cnm1r;
Snm = Snm2r - Snm1r;
clear Cnm1r Snm1r Cnm2r Snm2r


% BERECHNUNGEN
% Berechnung Synthese auf Ellipsoid
potential = SHS_grid_ell(latitude_V, longitude_V, Cnm, Snm, GM,h_V,a,e2, nmin,nmax);
undulation = potential./gamma_ell;

minV=min(min(potential))
maxV=max(max(potential))

minV=min(min(undulation))
maxV=max(max(undulation))

% Berechnung Varianzfortpflanzung auf Ellipsoid
vfp_potential = var_fort_potential(latitude_V, longitude_V, sCnm1, sSnm1, sCnm2, sSnm2, GM,h_V,a,e2, nmin,nmax);
vfp_undulation = vfp_potential./gamma_ell;

% Degree-variance
[gv, degree] = GradVarianzen(Cnm, Snm, GM, R, nmax);

% Error-Degree-Variance
[Fgv, degree] = FehlerGradVarianzen(sCnm1,sSnm1,sCnm2,sSnm2, GM, R, nmax);
% clear sCnm1 sSnm1 sCnm2 sSnm2


% PLOTS
folder1 = exist(['results1'],'dir');
if folder1 == 0
    mkdir(['results1'])
end

% Plot der Varianzen für Potential und Undulation für alle Meridiane
plotname = [institution '_'  'vfp_potential.png'];
plot_vfp_pot(vfp_potential,latitudeDEG_V,nmax,plotname);
plotname = [institution '_'  'vfp_undulation.png'];
plot_vfp_undu(vfp_undulation,latitudeDEG_V,nmax,plotname);

% Plot Varianzfortpflanzung
plotname = [institution '_' 'vfp_pot.png'];
plot_vfp_potential_grid(longitude_V,latitude_V,vfp_potential,nmax,plotname);
plotname = [institution '_' 'vfp_undu.png'];
plot_vfp_undulation_grid(longitude_V,latitude_V,vfp_undulation,nmax,plotname);


% Plot Potential
plotname = [institution '_' 'pot.png'];
plot_potential(longitude_V,latitude_V,potential,nmax,plotname);

% Plot Undulation
plotname = [institution '_' 'undu.png'];
plot_undulation(longitude_V,latitude_V,undulation,nmax,plotname);


% Plot GradVarianzen und FehlerGradVarianzen
plotname = [institution '_' 'gv_Fgv.png'];
plot_gv_Fgv(degree,gv,Fgv,nmax,plotname);


close all
toc


disp('End of run');
