%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modélisation du problème d'EDT (contraintes du sujet)
%
% Le problème est modélisé sous la forme :
%       min f' * x      (avec f un vecteur colonne)
%       A * x <= b
%       Aeq * x = beq
%       lowerBound <= x <= upperBound
%
% Pour plus de précisions sur les contraintes, voir le rapport.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Ceci est une classe de test
% Elle possède :
%   - 2 promos
%   - 4 crénaux par jour
%   - 5 jours dans la semaine 
%   - 11 professeurs

%% Définition des dimensions :
%   - t = Nombre de créneaux par jour
%   - d = Nombre de jours dans la semaine
%   - tau = Nombre de créneaux total dans la semaine
%   - c = Nombre de promo
%   - m = Nombre de professeurs
t = 4;
d = 5;
tau = d*t;
c = 2;
m = 11;


%% Définition du vecteur f :
% Sélections des créneaux aux extrémités des journées
e1 = ones(c*m, 1);
e2 = zeros((t-2)*c*m, 1);

% Construction du vecteur F pour tous les jours de la semaine
f_1jour = [e1; e2; e1];
f = f_1jour;
for i=1:d-1
    f = [f; f_1jour];
end


%% Traduction de la contrainte de définition :
% lowerBound <= x <= upperBound
lowerBound = zeros(m*c*tau, 1);
upperBound = ones(m*c*tau, 1);


%% Traduction des contraintes d'inégalités :
% Ax <= b

% Traduction de la contrainte 13 :
% Chaque promo ne doit pas avoir plus d'un cours d'une même matière dans la
% même journée...
A13 = zeros(d*c*m, m*c*tau);
b13 = ones(d*c*m, 1);
for journee=1:d
    for creneauJournee=1:t
        ligs = ((journee-1)*m*c + 1) : (journee*m*c);
        cols = ((creneauJournee-1)*m*c + (journee-1)*m*c*t + 1) : ...
            (creneauJournee*m*c + (journee-1)*m*c*t);
        A13(ligs, cols) = eye(m*c);
    end
end
% ... à l'exception des cours d'informatique où le nombre de cours dans une
% même journée ne doit pas dépasser deux.
it = 5;
while it < d*c*m
    b13(it) = 2;    % M. Pascal
    b13(it+1) = 2;  % M. Ada
    
    it = it + m;
end

% Traduction de la contrainte 14 :
% Une promo ne peut pas suivre plus d'un cours à la fois
A14 = zeros(c*tau, m*c*tau);
b14 = ones(c*tau,1);
for i=1:c*tau
    I = (i-1)*m+1 : i*m;
    A14(i,I) = 1;
end

% Traduction de la contrainte 15 :
% Un prof ne peut donner plus d'un cours à la fois
A15 = zeros(m*tau, m*c*tau);
b15 = ones(m*tau, 1);
for i=1:m*tau
    for j=1:c
        A15(i, (j-1)*m+i) = 1;
    end
end

% Combinaison des contraintes d'inégalités
A = [A13; A14; A15];
b = [b13; b14; b15];


%% Traduction des contraintes d'égalités :
% Définition du nombre de cours de chaque prof
NbCours = [
    2 2 ;
    3 2 ;
    5 0 ;
    0 4 ;
    4 0 ;
    0 4 ;
    1 0 ;
    0 1 ;
    2 2 ;
    2 0 ;
    0 2 ;
];

% Calcul du nombre de lignes de Aeq :
%   nombre de contraintes de cours par prof (m*c égalités)
%       + nombre d'égalités pour la contrainte 9 (2 égalités)
%       + nombre d'égalités pour la contrainte 10 (m*c égalités)
%       + nombre d'égalités pour la contrainte 11 (c*2 égalités)
%       + nombre d'égalités pour la contrainte 12 (c*4 égalités)
nbLignesAeq = m*c + 2 + m*c + c*2 + c*4;

% Construction de Aeq vide
Aeq = zeros(nbLignesAeq, m*c*tau);

% Enregistrement de l'indice de ligne courant
ligne_cour = 0;

% Contraintes 1 à 8 (16 premières lignes) :
% Nombre de cours dispensés par chaque prof)
for i=1:m*c
    for j=1:tau
        Aeq(i, (j-1)*m*c + i) = 1;
    end
    ligne_cour = i;
end

% Contrainte 9 (2 lignes) :
% Les cours de sport ont lieu le jeudi après-midi de 14 à 16h
ligne_cour = ligne_cour + 1;
Aeq(ligne_cour, ind_mat2vec(7,1,15,m,c)) = 1;

ligne_cour = ligne_cour + 1;
Aeq(ligne_cour, ind_mat2vec(8,2,15,m,c)) = 1;

% Contrainte 10 (16 lignes) :
% Le premier créneau du lundi matin est réservé au partiel
for i=1:m*c
    Aeq(ligne_cour + i, i) = 1;
end
ligne_cour = ligne_cour + m*c;

% Contrainte 11 (4 lignes) :
% M. Ellips est indisponible le lundi matin
for i=1:(c*2)
    Aeq(ligne_cour + i, (c*2) + (i-1)*m) = 1;
end
ligne_cour = ligne_cour + c*2;

% Contrainte 12 (8 lignes) :
% Mme Proton ne peut pas travailler le mercredi
for j=9:12
    for i=1:2
        ligne_cour = ligne_cour + 1;
        Aeq(ligne_cour, ind_mat2vec(2,i,j,m,c)) = 1;
    end
end

% Construction de beq :
%   - Contraintes 1 à 8, lignes 1 à m*c : NbCours
%   - Contrainte 9, ligne m*c+1 et m*c+2 (17 et 18)
%   - Les autres contraintes d'égalité indiquent une égalité à 0
beq = zeros(nbLignesAeq, 1);
beq(1:m*c) = NbCours(:);
beq(m*c+1) = 1;
beq(m*c+2) = 1;
