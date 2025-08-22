function [Cnm_EIGEN,Snm_EIGEN,Cnm_EIGEN_vek,Snm_EIGEN_vek] = neuesModell_EIGEN(t,t_0,koeff_anz,Cnm_param,Snm_param,ep)

p_1 = 1;
p_2 = 1/2;

Cnm_EIGEN_vek = zeros(koeff_anz,1);
Snm_EIGEN_vek = zeros(koeff_anz,1);

  for i = 1:koeff_anz
        
     Cnm_EIGEN_vek(i)=Cnm_param(1,i,ep)+Cnm_param(2,i,ep)*(t-t_0)+Cnm_param(3,i,ep)*cospi(2*(t-t_0)/p_1)+Cnm_param(4,i,ep)*sinpi(2*(t-t_0)/p_1)+Cnm_param(5,i,ep)*cospi(2*(t-t_0)/p_2)+Cnm_param(6,i,ep)*sinpi(2*(t-t_0)/p_2);
    end
  
    
    for i = 1:koeff_anz
    
      
           
               Snm_EIGEN_vek(i)= Snm_param(1,i,ep)+Snm_param(2,i,ep)*(t-t_0)+Snm_param(3,i,ep)*cospi(2*(t-t_0)/p_1)+Snm_param(4,i,ep)*sinpi(2*(t-t_0)/p_1)+Snm_param(5,i,ep)*cospi(2*(t-t_0)/p_2)+Snm_param(6,i,ep)*sinpi(2*(t-t_0)/p_2);
  
    end
    
%Vektor in Dreiecksmatrix umstellen
Cnm_EIGEN = zeros(97);
Snm_EIGEN = zeros(97);
counter_10=1;
counter_11=1;

for i = 1:97
    for j = 1:i 
        
        Cnm_EIGEN(i,j)=Cnm_EIGEN_vek(counter_10);
        counter_10=counter_10+1;
        
    end
        
end
for i = 1:97
    for j = 1:i 
        
        Snm_EIGEN(i,j)=Snm_EIGEN_vek(counter_11);
        counter_11=counter_11+1;
        
    end
        
end
end