function gamma_ell = normalschwere_ell(a, reslat, reslon, lat)
% Erstellt Normalschwerewerte nach Formel von Somigliani für GRS80
% Gibt Matrix (lat x lon) zurück


% GRS80 Parameter
b = 6356752.3141;       % kleine Halbachse
g_a = 9.7803267715;     % gamma Äquator
g_b = 9.8321863685;     % gamma Pol

cosp = cos(lat).^2;
sinp = sin(lat).^2;

gamma_ell = zeros(reslat,reslon);

%%

for i = 1:reslat
    gamma_ell(i,:) = ((a*g_a*cosp(i)) + (b*g_b*sinp(i))) / (sqrt((a^2 * cosp(i) + b^2 * sinp(i))));
end
end

