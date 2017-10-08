%% Fonction ind_mat2vec
% Permet de calculer l'indice de position d'un x_i,j,k
% d'une matrice de taille I,J,K dans le vecteur colonne
% représentant cette matrice (obtenu avec A(:) en Matlab)
%
% m = nombre total de lignes
% c = nombre total de colonnes
%
% i = indice de ligne recherché
% j = indice de colonne recherché
% k = indice de profondeur recherché
function ind = ind_mat2vec(i, j, k, m, c)
    ind = i + m*(j-1) + m*c*(k-1);
end