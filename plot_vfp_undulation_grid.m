function [] = plot_vfp_undulation_grid(lambda, phi, T, nmax, name)
    % Lege Aufloesung des Gitters sowie die Anzahl an Abstufungen beim
    % Kontour-Plot fest
    resGrid = 300;
    steps = 15;

    % Erzeuge Gitter
    x = linspace(min(lambda(:)./pi*180), max(lambda(:)./pi*180), resGrid);
    % geographische Laenge
    y = linspace(min(phi(:)./pi*180), max(phi(:)./pi*180), resGrid);
    % geographische Breite
    [X, Y] = meshgrid(x, y);

    % Berechne den Wert an jedem Punkt im Gitter mit den gegebenen Stuetzpunkten.
    % Benutze kubische Interpolation.
    ZAfe = griddata(lambda(:)./pi*180, phi(:)./pi*180, T*1000, X, Y, 'cubic');

    % Erzeuge Kontur-Plots
    f = figure;
    set(f, 'position', [0, 0, 2000, 1000]);
    contourf(x, y, ZAfe, steps);

    xlabel('Longitude [°]', 'FontSize', 14);
    ylabel('Latitude [°]', 'FontSize', 14);

    set(gca, 'XTick', -180:60:180);
    set(gca, 'YTick', -90:30:90);
    axis([-180 180 -90 90]);
    set(gca, 'FontSize', 14);

    % Use appropriate colormap
    cptcmap('GMT_wysiwygcont.cpt', 'mapping', 'scaled', 'ncol', 5000);
    cb = colorbar('Location', 'eastoutside');
    
    % Label the colorbar correctly
    ylabel(cb, '\sigma [mm] (Undulation)', 'FontSize', 14);
    
    % Set color limits and ticks
    clim_min = 0;
    clim_max = 70;
    set(gca, 'Clim', [clim_min clim_max]);
    set(cb, 'Ticks', linspace(clim_min, clim_max, 6)); % Adjust number of ticks as needed

    % Anzeigen von Küstenlinien
    load coastlines;
    geoshow(coastlat, coastlon, 'Color', 'k', 'LineWidth', 1);

    % Save the plot
    print('-dpng', name);
end
