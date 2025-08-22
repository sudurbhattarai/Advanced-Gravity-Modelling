function [] = plot_undulation(lambda,phi,T,nmax,name)
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
ZAfe = griddata(lambda(:)./pi*180, phi(:)./pi*180, T*1000, X, Y, 'cubic');

% Erzeuge Kontur-Plots
f = figure;
set(f, 'position', [0,0,2000,1000]);
contourf(x,y,ZAfe, steps);

%title({['Gravitationspotential in einer Höhe von ',num2str(h/1000),' [km] '];...
%       ['Gitterweite: ','\Delta\phi',' = ', num2str(Dlat), '°  ','\Delta\lambda',' = ' ,num2str(Dlon), '°'];...
%       ['Epochen: ',num2str(time_period_mid2), ' - ',num2str(time_period_mid1) ];...
%       ['Institution: ',sprintf('%s',institution)];
%       ['']} ,'FontSize',14);

% title({['Geoidundulation'];...
%        ['Gitterweite: Lon: ' num2str(lon) '°, Lat: ' num2str(lat) '°'];...
%        ['Maximaler Entwicklungsgrad n_{max} = ' num2str(nmax)];...
%        ['Zeitraum: ' month ' ' year]})

xlabel('Longitude [°]','FontSize',14);
ylabel('Latitude [°]','FontSize',14);

set(gca,'XTick',[-180:60:180])
%set(gca,'XTicklabel',round(lambda_grad(1:720:Jact)))
set(gca,'YTick',[-90:30:90])
%set(gca,'YTicklabel',[-90:30:90])
axis([-180 180 -90 90])
set(gca, 'FontSize', 14)
cptcmap('GMT_wysiwygcont.cpt','mapping', 'scaled','ncol', 5000);
cb=colorbar('Location', 'eastoutside');
%set(get(cb, 'xlabel'),'String','m^2 * s^{-2}');                 % potential
%set(gca, 'Clim', [-0.20 0.20]) 
%set(gca, 'CLim', [-0.20 0.20]) 
set(get(cb, 'xlabel'),'String','Undulation [mm]');                         % undulation
set(gca, 'Clim', [-5 5])
set(cb,'xtick',-5:5)
%set(gca, 'CLim', [-400.00 400.00]) 
set(gca, 'FontSize', 14)
% Anzeigen von Küstenlinien
load coastlines
geoshow(coastlat, coastlon, 'Color','k','LineWidth',1)

eval ( [ 'print -dpng ' [name] ] )

end
