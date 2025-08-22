function [sCnm_EIGEN,sSnm_EIGEN] = neuesModell_EIGEN_genauigkeit(t,t_0,koeff_anz,sCnm_param,sSnm_param,ep)


p_1 = 1;
p_2 = 1/2;
%Genauigkeit eines solchen Modells über FFG

sCnm_EIGEN_vek = zeros(koeff_anz,1);
sSnm_EIGEN_vek = zeros(koeff_anz,1);

mat_EIGEN = [1 (t-t_0) cospi(2*(t-t_0)/p_1) sinpi(2*(t-t_0)/p_1) cospi(2*(t-t_0)/p_2) sinpi(2*(t-t_0)/p_2) ];

for i = 1: koeff_anz

    sCnm_EIGEN_vek(i) = mat_EIGEN*diag((sCnm_param(:,i,ep)).^2)*mat_EIGEN'; 
end

for i = 1: koeff_anz
    
    sSnm_EIGEN_vek(i) = mat_EIGEN*diag((sSnm_param(:,i,ep)).^2)*mat_EIGEN';
end

%in eine Matrix zum einlesen
sCnm_EIGEN = zeros(97);
sSnm_EIGEN = zeros(97);
counter_12=1;
counter_13=1;

for i = 1:97
    for j = 1:i 
        
        sCnm_EIGEN(i,j)=sqrt(sCnm_EIGEN_vek(counter_12));
        counter_12=counter_12+1;
        
    end
        
end
for i = 1:97
    for j = 1:i 
        
        sSnm_EIGEN(i,j)=sqrt(sSnm_EIGEN_vek(counter_13));
        counter_13=counter_13+1;
        
    end
        
end

end
