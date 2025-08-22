%% CALCULATION of a selected time-dependent EIGEN-6S4 modell
%% OUTPUT is like a ICGEM formated file   *.gfc
clear all
close all
clc
format long

%first data-epoche in the inputfile EIGEN-6S4
t_0 = 1/365*juliandate(datetime(2002,08,16))

% ENTER epoche you want to calculate the time dependent coeffients
t_int = datetime(2024, 02, 01)
t_int_jul = 1/365*juliandate(t_int) %Interpolationszeitpunkt im julianischen Datum 

nmax = 96;
koeff_anz=(nmax+1)*(nmax+2)/2; %Anzahl unterscheidlicher Koeffizienten, Gaußsche Summenformel

%Einlesen 
[Cnm_EIGEN_param, Snm_EIGEN_param, sCnm_EIGEN_param,sSnm_EIGEN_param] = readCoefficientsEIGEN6S4('EIGEN-6S4-ohneHeader.gfc');

% Berechnung eines neuen EIGEN-Modells
%Interpolationszeitpunkt abfangen

ep_vek = [datetime(2002,08,15);     %until 01012003   ep=1
    datetime(2003,01,01);           %until 01012004   ep=2
    datetime(2004,01,01);           %until 26122004
    datetime(2004,12,26);           %until 01012006
    datetime(2006,01,01);           %until 01012007
    datetime(2007,01,01);           %until 01012008
    datetime(2008,01,01);           %until 01012009
    datetime(2009,01,01);           %until 27022010
    datetime(2010,02,27);           %until 11032011
    datetime(2011,03,11);           %until 01012012
    datetime(2012,01,01);           %until 01012013   ep=11
    datetime(2013,01,01);           %until 01012014
    datetime(2014,01,01);           %until 15062014
    datetime(2014,06,15);];         %until 2050

%SELECT reference epoche for the calculation of the time-dependent
%coefficitens
ep = 14; %CHANGE between 1 and 14
referencepoche = ep_vek(ep)
t_E0 = 1/365*juliandate(ep_vek(ep))

% Berechnung Kugelfunktionskoeffizienten + Standardabweichung
[Cnm_EIGEN,Snm_EIGEN,~,~] = neuesModell_EIGEN(t_int_jul,t_E0,koeff_anz,Cnm_EIGEN_param,Snm_EIGEN_param,ep);
[sCnm_EIGEN,sSnm_EIGEN] = neuesModell_EIGEN_genauigkeit(t_int_jul,t_E0,koeff_anz,sCnm_EIGEN_param,sSnm_EIGEN_param,ep);

%write coeff to file

fid = fopen('EIGENt4.gfc','w+');
fprintf(fid,'Exercise 1 \n\n');
fprintf(fid,'generating_institute   KIT \n');
fprintf(fid,'time_period_of_data    20240201 - 20500101   (mid: 20360601) \n');
fprintf(fid,' \n');
fprintf(fid,'begin_of_head ================================================================ \n');
fprintf(fid,'product_type                   gravity_field \n');
fprintf(fid,'modelname                      EIGEN T1 \n');
fprintf(fid,'radius                         6.3781364600e+06 \n');
fprintf(fid,'earth_gravity_constant         3.9860044150e+14 \n');
fprintf(fid,'max_degree                     96 \n');
fprintf(fid,'norm                           fully_normalized \n');
fprintf(fid,'tide_system                    tide-free \n');
fprintf(fid,'errors                         formal \n');
fprintf(fid,' \n');
fprintf(fid,'key     L    M          C                   S            sigma C     sigma S   \n');
fprintf(fid,'end_of_head ================================================================== \n');

for n = 1:nmax+1
 for m = 1:n
  fprintf(fid,'%4s%5.0f%5.0f%20.12E%20.12E%12.4E%12.4E\n', 'gfc ',n-1,m-1,Cnm_EIGEN(n,m),Snm_EIGEN(n,m),sCnm_EIGEN(n,m),sSnm_EIGEN(n,m));
 end
end

fclose(fid);


