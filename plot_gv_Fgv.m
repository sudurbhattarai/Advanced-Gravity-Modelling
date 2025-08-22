function [] = plot_gv_Fgv(degree,gv,Fgv,nmax,plotname)

f = figure;
set(f, 'position', [0,0,1000,1000]);

semilogy(degree,gv,'b-');
hold on
semilogy(degree,Fgv,'r-');

%title({['Absolute Differenz-Gradvarianzen und Fehlergradvarianzen'];...
%       ['Epochen: ',num2str(time_period_mid2), ' - ',num2str(time_period_mid1) ];...
%       ['Institution: ',sprintf('%s',institution)];
%       ['']} ,'FontSize',14);

% title({['Absolute Differenz-Gradvarianzen und Fehlergradvarianzen'];...
%        ['Maximaler Entwicklungsgrad n_{max} = ' num2str(nmax)];...
%        ['Zeitraum: ' month ' ' year]})

xlabel('Degree n','FontSize',14);
ylabel('\sigma^2 & d\sigma^2 [m^4/s^4]','FontSize',14);
if nmax == 96
legend('Degree-Variances','Error-Degree-Variances','Location','northwest')
ylim([1e-12 1e-2])
end
if nmax == 25
legend('Degree-Variances','Error-Degree-Variances','Location','northeast')
ylim([1e-8 1e-4])
end
xlim([0 ceil(nmax/10)*10])
set(gca,'XTick',[0:10:ceil(nmax/10)*10])
set(gca, 'FontSize', 14)

eval ( [ 'print -dpng ' [plotname] ] );

end
