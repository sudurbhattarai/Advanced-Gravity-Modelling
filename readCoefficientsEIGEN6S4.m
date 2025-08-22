function [neu_Cnm,neu_Snm,neu_sCnm,neu_sSnm] = readCoefficientsEIGEN6S4(input_txt)

% Einlesen von EIGEN 6S4: OHNE HEADER

[key,L,M,C,S,sC,sS,t0,t1,period] = textread(input_txt,'%s%u%u%f%f%f%f%f%f%f');
zeile = length(L);
period = [period; 0];
t0=[t0;0];
t1=[t1;0];
%% Matrix 1 erstellen
key_mat=zeros(zeile,1);

for i = 1:zeile

    if(strcmp(key{i},'gfc')) 
        
        key_mat(i)=1;
    else if(strcmp(key{i},'gfct')) 
        
        key_mat(i)=1;
    else if (strcmp(key{i},'trnd'))
            
            key_mat(i)=2;
        else if (strcmp(key{i},'acos'))
                
                key_mat(i)=3;
            else if (strcmp(key{i},'asin'))
                    
                    key_mat(i)=4;
                else
                    key_mat(i)=0;
                end
            end
        end
        end
    end
end

matrix_ausgang = [key_mat L M C S sC sS t0 t1 period]; %ausgangsmatrix

%% für Cnm
%alle Koeffizienten G/O größer 80
matrix_gr80 = zeros(zeile,10);
for i = 1:zeile

    if(matrix_ausgang(i,2)>80)
        matrix_gr80(i,:)=matrix_ausgang(i,:);
    else
        matrix_gr80(i)=0;
    end
end
matrix_klgl80 = matrix_ausgang-matrix_gr80; %matrix ohne koeff gr. 80
ind = find(sum(matrix_gr80,2)==0) ; 
matrix_gr80(ind,:) = [] ; 


%sortieren nach Grad und Ordnung

matrix_gr80 = sortrows(matrix_gr80,[2 3]); %Fertig, enthält alle Koeffizienten gr. 80, noch inrichtige form bringen, ist spaltenvektor

% alle Koeffizienten kl.gl. 80

ind = find(sum(matrix_klgl80,2)==0);
matrix_klgl80(ind,:)=[];
matrix_klgl80 = sortrows(matrix_klgl80,[8 2 3]); %Fertig, enthält alle Koeffizienten gr. 80, noch inrichtige form bringen, ist spaltenvektor
matrix_klgl80(matrix_klgl80(:,8) < 20020101, :) = [];
for i=1:length(matrix_klgl80)
    
if(matrix_klgl80(i,8)== 20020101)
    matrix_klgl80(i,8)= 2.002081508170000e+07;

end

end

matrix_klgl80 = sortrows(matrix_klgl80,[8 2 3]);

for i=1:length(matrix_klgl80)
    
if(matrix_klgl80(i,10)~=0)
    matrix_klgl80(i,1)=matrix_klgl80(i,1)/matrix_klgl80(i,10);
end
if(matrix_klgl80(i,1)==6)
    
    matrix_klgl80(i,1)=5;
end
end

for i = 1:length(matrix_klgl80)

if(matrix_klgl80(i,1)==8)
    
    matrix_klgl80(i,1)=6;
end
    
end
% 
% %15 Vektoren für 15 Epochen, schmeiße alle epochen raus, die nicht im
% %zeitraum 2002 - 2014 liegen
% 
B = unique(matrix_klgl80(:,8));
%Koeffizientenanzahl
n=81;
l=301;
gauss_80 = (n^2+n)/2;
gauss_300 = (l^2+l)/2;
%pack es in neuen scheiß
 neu_Cnm = zeros(6,gauss_300,14);
 counter1=1;
 counter2=1;
 for i=1:length(matrix_klgl80)
     
     if(matrix_klgl80(i,1) == 1)
        counter1 = counter1+1;
     end
     neu_Cnm(matrix_klgl80(i,1),counter1,counter2)= matrix_klgl80(i,4);
     
     if(i<length(matrix_klgl80))
         if(matrix_klgl80(i,8)<matrix_klgl80(i+1,8))
             counter2 = counter2+1;
             counter1=1;
         end
     end
  
   
 end
 
for i=1:14
     neu_Cnm(1,1,i)=1; %erste Spalte für Cnm 00 = 1, alle epochen
end
    
% hänge die anderen gr. 80 hintendran als konstanten offset
counter=1;
for i=(gauss_80+1):gauss_300
    for j =1:14
    neu_Cnm(1,i,j) = matrix_gr80(counter,4);
    end
    counter = counter+1;
end

%% für Snm

 neu_Snm = zeros(6,gauss_300,14);
 counter1=1;
 counter2=1;
 for i=1:length(matrix_klgl80)
     
     if(matrix_klgl80(i,1) == 1)
        counter1 = counter1+1;
     end
     neu_Snm(matrix_klgl80(i,1),counter1,counter2)= matrix_klgl80(i,5);
     
     if(i<length(matrix_klgl80))
         if(matrix_klgl80(i,8)<matrix_klgl80(i+1,8))
             counter2 = counter2+1;
             counter1=1;
         end
     end
  
   
 end
 
    
% hänge die anderen gr. 80 hintendran als konstanten offset
counter=1;
for i=(gauss_80+1):gauss_300
    for j =1:14
    neu_Snm(1,i,j) = matrix_gr80(counter,5);
    end
    counter = counter+1;
end


%% für sCnm

 neu_sCnm = zeros(6,gauss_300,14);
 counter1=1;
 counter2=1;
 for i=1:length(matrix_klgl80)
     
     if(matrix_klgl80(i,1) == 1)
        counter1 = counter1+1;
     end
     neu_sCnm(matrix_klgl80(i,1),counter1,counter2)= matrix_klgl80(i,6);
     
     if(i<length(matrix_klgl80))
         if(matrix_klgl80(i,8)<matrix_klgl80(i+1,8))
             counter2 = counter2+1;
             counter1=1;
         end
     end
  
   
 end
 
    
% hänge die anderen gr. 80 hintendran als konstanten offset
counter=1;
for i=(gauss_80+1):gauss_300
    for j =1:14
    neu_sCnm(1,i,j) = matrix_gr80(counter,6);
    end
    counter = counter+1;
end


%% für sSnm

 neu_sSnm = zeros(6,gauss_300,14);
 counter1=1;
 counter2=1;
 for i=1:length(matrix_klgl80)
     
     if(matrix_klgl80(i,1) == 1)
        counter1 = counter1+1;
     end
     neu_sSnm(matrix_klgl80(i,1),counter1,counter2)= matrix_klgl80(i,7);
     
     if(i<length(matrix_klgl80))
         if(matrix_klgl80(i,8)<matrix_klgl80(i+1,8))
             counter2 = counter2+1;
             counter1=1;
         end
     end
  
   
 end
 
    
% hänge die anderen gr. 80 hintendran als konstanten offset
counter=1;
for i=(gauss_80+1):gauss_300
    for j =1:14
    neu_sSnm(1,i,j) = matrix_gr80(counter,7);
    end
    counter = counter+1;

end

end