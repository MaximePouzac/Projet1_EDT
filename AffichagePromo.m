%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affichage d'un EDT de promo
%
% promo contient l'EDT à afficher
% numPromo est le numéro de la promo courante
% d jours par semaine et t créneaux par jour
%
% On représente un créneau par un rectangle de 1 sur 2. L'emploi du
% temps est contenu dans le rectangle ([0,0], [0,10], [4,10],[4,0])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On définit la fenêtre
%j=0:d*2;
%h=0:4;
grid('on');
axis([0 d*2 0 t]);

set(gca,'Xtick',0:2:d*2);  set(gca,'Ytick',0:1:t+1);  
title(['EDT promo ' num2str(numPromo)]);
xlabel('jour'); ylabel('heure');

% On définit les créneaux sous forme de rectangle (blanc par défaut, en
%couleur si occupé)
%creneau = zeros(5,4);
for i= 1:d
    for j= 1:t
      creneau(i,j) = rectangle ('Position',[2*(i-1) t-j 2 1]);
      creneau(i,j).FaceColor='white';
    end
end

for i=1:d
    for j=1:t
        if promo(j,i) == 1
            creneau(i,j).FaceColor='blue';
            text(2*(i-1)+0.2, t-j+0.5, 'Young Anglais');
        end
        if promo(j,i) == 2
            creneau(i,j).FaceColor='yellow';
            text(2*(i-1)+0.1, t-j+0.5, 'Proton Physique');
        end
        if promo(j,i) == 3
            creneau(i,j).FaceColor='red';
            text(2*(i-1)+0.2, t-j+0.5, 'Droite Maths');
        end
        if promo(j,i) == 4
            creneau(i,j).FaceColor='magenta';
            text(2*(i-1)+0.2, t-j+0.5, 'Ellips Maths');
        end
        if promo(j,i) == 5
            creneau(i,j).FaceColor='green';
            text(2*(i-1)+0.2, t-j+0.5, 'Pascal Info');
        end
        if promo(j,i) == 6
            creneau(i,j).FaceColor='cyan';
            text(2*(i-1)+0.2, t-j+0.5, 'Ada Info');
        end
        if promo(j,i) == 7
            creneau(i,j).FaceColor=[0.5 0.2 0.75];
            text(2*(i-1)+0.2, t-j+0.5, 'Gazelle Sport');
        end
        if promo(j,i) == 8
            creneau(i,j).FaceColor=[1 0.7 0];
            text(2*(i-1)+0.2, t-j+0.5, 'Bigceps Sport');
        end
        if promo(j,i) == 9
            creneau(i,j).FaceColor=[0 0.3 0];
            text(2*(i-1)+0.2, t-j+0.5, 'Lunette BDD');
        end
        if promo(j,i) == 10
            creneau(i,j).FaceColor=[0.8 0.5 0];
            text(2*(i-1)+0.2, t-j+0.5, 'Marco GLS');
        end
        if promo(j,i) == 11
            creneau(i,j).FaceColor=[0.5 0.5 0.5];
            text(2*(i-1)+0.2, t-j+0.5, 'Sergio EDP');
        end
    end
end
    
        
    