t = 4;
d = 5;
tau = 20;
c = 2;
m = 8;

x = randi(2,m*c*tau,1) - 1;

% Construction Aeq
Aeq = zeros(46,m*c*tau);
beq = zeros(m*c*tau);
ligne_cour = 0;

% Contraintes 1 à 8 (nb cours)
% 16 premières lignes
for i=1:m*c
    for j=1:tau
        Aeq(i,(j-1)*16+i) = 1;
    end
    ligne_cour = i;
end

% Contrainte 9
% 2 lignes
ligne_cour = ligne_cour + 1;
Aeq(ligne_cour, ind_mat2vec(7,1,15,m,c)) = 1;
ligne_cour = ligne_cour + 1;
Aeq(ligne_cour, ind_mat2vec(8,2,15,m,c)) = 1;

% Contrainte 10
% 16 lignes
for i=1:m*c
    Aeq(ligne_cour + i, i) = 1;
end
ligne_cour = ligne_cour + m*c;

% Contrainte 11
% 4 lignes
for i=1:(c*2)
    Aeq(ligne_cour + i, (c*2)+(i-1)*m) = 1;
end
ligne_cour = ligne_cour + c*2;

% Contrainte 12
% 8 lignes

for j=9:12
    for i=1:2
        ligne_cour = ligne_cour + 1;
        Aeq(ligne_cour, ind_mat2vec(2,i,j,m,c)) = 1;
    end
end

% Construction beq
beq(1) = 3;
beq(2) = 3;
beq(3) = 5;
beq(4) = 0;
beq(5) = 6;
beq(6) = 0;
beq(7) = 1;
beq(8) = 0;
beq(9) = 3;
beq(10) = 3;
beq(11) = 0;
beq(12) = 4;
beq(13) = 0;
beq(14) = 6;
beq(15) = 0;
beq(16) = 1;
beq(17) = 1;
beq(18) = 1;




    
    
    
    
    
    
    
    
    
    
    