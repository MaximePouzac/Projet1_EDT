% Définition des dimensions :
%   - t = Nombre de créneaux par jour
%   - d = Nombre de jours dans la semaine
%   - tau = Nombre de créneaux total dans la semaine
%   - c = Nombre de promo
%   - m = Nombre de professeurs
t = 4;
d = 5;
tau = d*t;
c = 2;
m = 8;

% Traduction de la contrainte de définition :
% lowerBound <= x <= upperBound
lowerBound = zeros(m*c*tau, 1);
upperBound = ones(m*c*tau, 1);

%% Traduction des contraintes d'inégalités :
% Ax <= b

% Traduction de la contrainte 13 :
% Chaque promo ne doit pas avoir plus d'un cours d'une même matière...
A13 = eye(d*c*m, m*c*tau);
b13 = ones(d*c*m, 1);

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

