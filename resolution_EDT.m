%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Résolution d'un problème d'EDT avec intlinprog et affichage de l'EDT
% généré.
%
% Le problème est modélisé sous la forme :
%       min f' * x      (avec f un vecteur colonne)
%       A * x <= b
%       Aeq * x = beq
%       lowerBound <= x <= upperBound
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Définition du problème :
% Problème du sujet :
modelisation_EDT_sujet;


%% Résolution du problème :
% Indication que toutes les variables doivent être entières
intcon = ones(size(f));
% Résolution avec intlinprog
X = intlinprog(f, intcon, A, b, Aeq, beq, lowerBound, upperBound);
% Redimensionnement de la solution en matrice
X = reshape(X, [m,c,tau]);


%% Construction de la solution exploitable pour affichage :
%  1. Extraction du n° du prof pour chaque créneau et pour chaque promo
Promos = zeros(tau, c);
for k=1:tau
    for j=1:c
        % Trouver le numéro du prof du cours
        numProf = find(X(:,j,k) == 1);
        % S'il y a un cours, l'enregistrer
        if size(numProf, 1) == 1
            Promos(k,j) = numProf;
        end
    end
end
%  2. Construction d'un EDT compréhensible pour chaque promo
EDT = zeros(t, d, c);
for j=1:c
    EDT(:, :, j) = reshape(Promos(:, j), [t, d]);
end


%% Affichage du problème résolu :
% Création d'une figure
figure;

% Affichage de la promo 1 sur la figure 1
subplot(2,1,1);
Promo1 = reshape(EDT(:, :, 1), [t, d]);
AffichagePromo1;

% Affichage de la promo 2 sur la figure 2
subplot(2,1,2);
Promo2 = reshape(EDT(:, :, 2), [t, d]);
AffichagePromo2;

