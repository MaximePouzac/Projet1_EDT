%Fonction intervenant dans le problème à minimiser%
%!!!!!Retourne un vecteur ligne!!!!!%

%Constantes du problemes%
d = 5;
m = 8;
c = 2;
t = 4;

%Selections des créneaux aux extrémités%
e1 = ones(1,c*m);
e2 = zeros(1,(t-2)*c*m);

%Construction du vecteur F pour tous les jours de la semaine%
F = [e1, e2, e1];
i = 1;

for i=1:d-1
    F = [ F , e1 , e2 , e1 ];
end


    
