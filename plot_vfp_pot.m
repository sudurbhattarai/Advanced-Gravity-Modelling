function [] = plot_vfp_pot(vfp,lat,nmax,plotname)

f = figure;
set(f, 'position', [0,0,1000,1000]);

hold on
plot(-lat,vfp);

%title({['Absolute Differenz-Gradvarianzen und Fehlergradvarianzen'];...
%       ['Epochen: ',num2str(time_period_mid2), ' - ',num2str(time_period_mid1) ];...
%       ['Institution: ',sprintf('%s',institution)];
%       ['']} ,'FontSize',14);

% title({['Fehlerfortpflanzung des Potentials über alle Meridiane'];...
%        ['Maximaler Entwicklungsgrad n_{max} = ' num2str(nmax)];...
%        ['Zeitraum: ' month ' ' year]})

xlabel('Latitude [°]','FontSize',14);
ylabel('\sigma [m^2/s^2] (Potential)','FontSize',14);


xlim([-90 90])
ylim([0 0.02])
set(gca,'XTick',[-90:30:90]);
set(gca,'XTickLabel',[-90:30:90]);
set(gca, 'FontSize', 14)
eval ( [ 'print -dpng ' [plotname] ] );

end
