function [] = plot_vfp_undu(vfp,lat,nmax,plotname)

f = figure;
set(f, 'position', [0,0,1000,1000]);

hold on
plot(-lat,vfp*1000);

%title({['Absolute Differenz-Gradvarianzen und Fehlergradvarianzen'];...
%       ['Epochen: ',num2str(time_period_mid2), ' - ',num2str(time_period_mid1) ];...
%       ['Institution: ',sprintf('%s',institution)];
%       ['']} ,'FontSize',14);
   
% title({['Fehlerfortpflanzung der Undulation über alle Meridiane'];...
%        ['Maximaler Entwicklungsgrad n_{max} = ' num2str(nmax)];...
%        ['Zeitraum: ' month ' ' year]})

xlabel('Latitude [°]','FontSize',14);
ylabel('\sigma [mm] (Undulation)','FontSize',14);


xlim([-90 90])
ylim([0 5.0])
set(gca,'XTick',[-90:30:90]);
set(gca,'XTickLabel',[-90:30:90]);
set(gca, 'FontSize', 14)
eval ( [ 'print -dpng ' [plotname] ] );

end
