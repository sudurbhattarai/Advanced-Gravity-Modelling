function [] = plot_vfp_potential_grid(lambda,phi,T,nmax,name)
% Lege Aufloesung des Gitters sowie die Anzahl an Abstufungen beim
% Kontour-Plot fest
resGrid = 300;
steps = 15;

% Erzeuge Gitter
x = linspace(min(lambda(:)./pi*180), max(lambda(:)./pi*180), resGrid);
% geographische Laenge
y = linspace(min(phi(:)./pi*180), max(phi(:)./pi*180), resGrid);
% geographische Breite
[X,Y] = meshgrid(x,y);

% Berechne den Wert an jedem Punkt im Gitter mit den gegbenen Stuetzpunkten.
% Benutze kubische Interpolation.
ZAfe = griddata(lambda(:)./pi*180, phi(:)./pi*180, T, X, Y, 'cubic');

% Erzeuge Kontur-Plots
f = figure;
set(f, 'position', [0,0,2000,1000]);
contourf(x,y,ZAfe, steps);

% title({['Genauigkeit des Potential nach Varianzfortpflanzung'];...
%        ['Epochen: ',num2str(time_period_mid2), ' - ',num2str(time_period_mid1) ];...
%        ['Institution: ',sprintf('%s',institution)];
%        ['']} ,'FontSize',14);
   
% title({['Genauigkeit des Potentials nach Fehlerfortpflanzung'];...
%        ['Maximaler Entwicklungsgrad n_{max} = ' num2str(nmax)];...
%        ['Zeitraum: ' month ' ' year]})

xlabel('Longitude [°]','FontSize',14);
ylabel('Latitude [°]','FontSize',14);

set(gca,'XTick',[-180:60:180])
%set(gca,'XTicklabel',round(lambda_grad(1:720:Jact)))
set(gca,'YTick',[-90:30:90])
%set(gca,'YTicklabel',round(phi_grad(1:720:Iact)))
axis([ -180 180 -90 90])
set(gca, 'FontSize', 14)
cptcmap('GMT_wysiwygcont.cpt','mapping', 'scaled','ncol', 5000);
cb=colorbar('Location', 'eastoutside');
%set(get(cb, 'xlabel'),'String',' m^4 * m^{-2}'); % potential --> m^4 * m^{-2}
%set(get(cb, 'xlabel'),'String','N  [mm]'); % undulation


set(get(cb, 'xlabel'),'String','\sigma [m^2/s^2] (Potential)');   
%set(gca, 'Clim', [0.03 0.10]) 
%set(gca, 'CLim', [0.03 0.10]) 
%set(get(cb, 'xlabel'),'String','mm');                         % undulation
%set(gca, 'Clim', [-0.05 0.05])
%set(cb,'xtick',[-0.05:0.01:0.05])

% set(gca, 'Clim', [-0.015 0.015])
% set(cb,'xtick',[-0.015:0.015])
% 
% %set(gca, 'CLim', [0.0 0.0024])
% set(gca, 'FontSize', 14)

% Set color limits and ticks
clim_min = 0;
clim_max = 0.7;
set(gca, 'Clim', [clim_min clim_max]);
set(cb, 'Ticks', linspace(clim_min, clim_max, 6)); % Adjust number of ticks as needed



% Anzeigen von Küstenlinien
load coastlines
geoshow(coastlat, coastlon, 'Color','k','LineWidth',1)

eval ( [ 'print -dpng ' [name] ] )

end
