clear all;
close all;


b = 0.005;  % base da seção transversal (m)
h = 0.005;  % altura da seção transversal (m)

ro = 1040;  % densidade (kg/m3)
m = ro*b*h; % densidade linear (kg/m)
E = 2.3 * 10^9; % módulo de Young (N/m2)
I = b*(h^3)/12; % momento de inércia de área (m4)
L = 0.100;    % comprimento da viga (m)
D = zeros(3,10); % matrix com Wn's
A = b*h;  % área da seção transversal (m2)

%--- frequências naturais analiticas ---
% Ia = b*((2*h)^3)/12;
% wn_analitico_2 = [3.52 22 61.7]*sqrt(E*Ia/(m*L^4))/(2*pi);
wn_analitico = [3.52 22 61.7]*sqrt(E*I/(m*L^4))/(2*pi)

% ---------------------------- %

ne = 54;     % número de elementos
l = L/ne;   % comprimento do elemento finito (m)

ngdl = 2*(ne+1);
Mg = zeros(ngdl);
Kg = zeros(ngdl);

%--- montagem das matrizes dos elementos ---
C1 = m*l/420;
Me = C1* [ 156   22*l    54  -13*l;
          22*l  4*l*l  13*l -3*l*l;
            54   13*l   156  -22*l;
         -13*l -3*l*l -22*l  4*l*l];
     
C2 = E*I/l^3;
Ke = C2* [ 12   6*l  -12   6*l;
          6*l 4*l*l -6*l 2*l*l;
          -12  -6*l   12  -6*l;
          6*l 2*l*l -6*l 4*l*l];
      
%--- bolinhas de 5 mm de diâmetro ---

mAl = pi*(0.0025^2)*0.005*ro;
mBol = 7850*4*pi*(0.0025^3)/3;
Dm = mBol-mAl;
IAl = 0.25*mAl*(0.0025^2) + mAl*(0.005^2)/12;
IBol = 2*mBol*(0.0025^2)/5;
DI = IBol-IAl;
Mdm = [Dm 0 0 0; 0 DI 0 0; 0 0 Dm 0; 0 0 0 DI];

%--- montagem das matrizes globais ---

   for i=1:ne, 
   
    
    Mg(2*i-1:2*i+2,2*i-1:2*i+2) = Mg(2*i-1:2*i+2,2*i-1:2*i+2) + Me + Mdm;
    Kg(2*i-1:2*i+2,2*i-1:2*i+2) = Kg(2*i-1:2*i+2,2*i-1:2*i+2) + Ke;

   end

%--- condição de contorno ---

M = Mg(3:ngdl,3:ngdl);
K = Kg(3:ngdl,3:ngdl);

%--- cálculo das frequências e modos ---
   
[u,v] = eig(K,M);
     
   
%--- calculando as frequências naturais a partir da matrix V --
    
    diag_v=diag(v);
    diag_v=sqrt((diag_v))/(2*pi);
    diag_v=[diag_v(1:3,1) [wn_analitico(1); wn_analitico(2); wn_analitico(3)] ]
      
    
U1 = [0; u(1:2:108,1)];
U2 = [0; u(1:2:108,2)];
U3 = [0; u(1:2:108,3)];

plot(0:l:L,U1,0:'b-')
title (' 1º modo de vibrar ' );

% hold on
figure;
plot(0:l:L,U2,'r-')
title(' 2º modo de vibrar' );
figure;
plot(0:l:L,U3,'g-')
    title(' 3 modo de vibrar' );
% plot(0.05,U1(11),'ko',0.05,U2(11),'ko',0.05,U3(11),'ko')
% plot(0.16,U1(33),'ko',0.16,U2(33),'ko',0.16,U3(33),'ko')
% plot(0.22,U1(45),'ko',0.22,U2(45),'ko',0.22,U3(45),'ko')
% hold off
grid on
    
% --- alocar Wn em matrix D ---

%         D(1:3,ne) = D(1:3,ne) + diag_v(1:3);
%  end
% 
% %--- alocando os valores de ne=1:2 na matrix D ---
% D(1:2,1) = [184.1 ; 18141];
% D(1:3,2) = [183   ; 1158 ; 3917];
% 
% %--- plotando os gráficos de Wn ---
% x = 1:1:10;
% 
% D = (D);
% 
% wn_a_1 = wn_analitico(1);
% 
% wn_a_2 = wn_analitico(2);
% 
% wn_a_3 = wn_analitico(3);
% 
% hold on
% plot(x,D(1,:),x,D(2,:),x,D(3,:) , 'LineWidth' , 2 );
% title (' frequencias naturais Wn ' );
% ylabel (' Wn ' );
% xlabel (' Nº elementos ' );
% 
% plot (x,wn_a_1+0*x , x,wn_a_2+0*x , x,wn_a_3+0*x ,'k', 'LineWidth',1);
% title (' frequencias naturais Wn ' );
% ylabel (' Wn ' );
% xlabel (' Nº elementos ' );
% 
% hold off

%---------------------------------------------------%

% 
% 
% % --- criando as matrizes de rigidez e massa --- %
% 
% R = A*(l^2)/I;
% Ccg = E*I/(l^3);  % -- constante matrix de rigidez %
% Ccg2 = m*l/420;   % -- constante matrix de massa %
% N = 140 ;
% n_elementos = 5;
% matriz_R1_total= zeros(n_elementos*3+3); % -- para 5 elementos : matrix 18x18 ;
% matriz_M1_total= zeros(n_elementos*3+3);
% matriz_R2_total= zeros(6); % -- para 5 elementos : matrix 18x18 ;
% matriz_M2_total= zeros(6);
% matriz_R3_total= zeros(n_elementos*3+3); % -- para 5 elementos : matrix 18x18
% matriz_M3_total= zeros(n_elementos*3+3);
% 
% matriz_M_total= zeros(6*(n_elementos+1)); % -- parte 1 + parte 2 + parte 3 -- %
% matriz_R_total= zeros(6*(n_elementos+1));
%             
% matriz_rigidez = Ccg * [ R   0     0    -R   0    0 
%                          0  12    6*l   0   -12  6*l
%                          0  6*l  4*l*l  0  -6*l 2*l*l
%                         -R  0     0     R    0     0
%                          0  -12   -6*l   0   12   -6*l
%                          0   6*l  2*l*l  0  -6*l   4*l*l];
%                      
%                     
% matriz_massa = Ccg2 * [ N    0     0    N/2  0    0
%                         0   156   22*l   0   54  -13*l
%                         0   22*l 4*l*l   0   13*l -3*l*l
%                         N/2  0     0     N    0   0
%                         0    54   13*l   0   156 -22*l
%                         0   -13*l -3*l*l 0  -22*l 4*l*l];
%                     
%                     
%                   
% theta= 0;
% 
% 
%     
% matriz_transformacao = [ cos(theta) sin(theta) 0    0          0        0
%                         -sin(theta) cos(theta) 0    0          0        0
%                            0           0       1    0          0        0
%                            0           0       0 cos(theta) sin(theta)  0
%                            0           0       0 -sin(theta) cos(theta) 0
%                            0           0       0    0          0        1];
%        
% matriz_transformacaot =  matriz_transformacao';
% 
% % -- aplicando a transformação à matriz de rigidez :
%                        
% matriz_rigidez_1 =matriz_transformacaot * matriz_rigidez * matriz_transformacao ; 
% 
% % -- somando as matrizes de rigidez dos 5 elemntos em 1 matriz de rigidez
% % total;
% for i=1:5 ,  % -- considerando 1 elemento.
%     
% matriz_R1_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_R1_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_rigidez_1;
% 
% end
% 
% % -- aplicando as condições de contorno v1=u1=theta1 -- %
% 
% 
% % -- aplicando a transformção à matriz de massa :
% 
% matriz_massa_1 = matriz_transformacaot * matriz_massa * matriz_transformacao ;
% 
% % -- somando as matrizes de massa dos 5 elementos em 1 matriz de massa
% % total;
% 
% for i=1:5 ,  % -- considerando 5 elementos.
%     
% matriz_M1_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_M1_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_massa_1;
% 
% end
% 
% % -- aplicando condições de contorno : v1=u1=theta1=0 -- %
% 
% 
% % matriz_M1_total(:, [1,2,3]) = [];
% % matriz_M1_total( [1,2,3] ,:) = [];
% 
% 
% % -- %
% 
% 
% 
% theta = -pi/2;
% I_v = b*(h^3)/12; % momento de inércia de área (m4)
% l_v= 0.01;
% R_v = A*(l_v^2)/I_v;
% Ccg_v = E*I_v/(l_v^3);  % -- constante matrix de rigidez %
% Ccg2_v = m*l_v/420;   % -- constante matrix de massa %
% 
% matriz_rigidez_v = Ccg_v * [ R_v   0       0      -R_v   0            0 
%                          0     12    6*l_v     0   -12         6*l_v
%                          0   6*l_v  4*l_v*l_v  0  -6*l_v      2*l_v*l_v
%                         -R     0       0       R    0           0
%                          0    -12   -6*l_v     0     12       -6*l_v
%                          0   6*l_v  2*l_v*l_v  0  -6*l_v   4*l_v*l_v];
%                      
%  matriz_massa_v = Ccg2_v * [ N      0        0    N/2  0          0
%                         0      156     22*l_v   0   54     -13*l_v
%                         0     22*l_v  4*l*l_v   0   13*l_v -3*l_v*l_v
%                         N/2      0       0      N    0         0
%                         0       54    13*l_v    0   156     -22*l_v
%                         0   -13*l_v -3*l_v*l_v 0  -22*l_v  4*l_v*l_v];
%     
% matriz_transformacao = [ cos(theta) sin(theta) 0    0          0        0
%                         -sin(theta) cos(theta) 0    0          0        0
%                            0           0       1    0          0        0
%                            0           0       0 cos(theta) sin(theta)  0
%                            0           0       0 -sin(theta) cos(theta) 0
%                            0           0       0    0          0        1];
%        
% matriz_transformacaot =  matriz_transformacao';
% 
% % -- aplicando a transformação à matriz de rigidez :
%                        
% matriz_rigidez_v =matriz_transformacaot * matriz_rigidez_v * matriz_transformacao ; 
% 
% % -- somando as matrizes de rigidez dos 5 elemntos em 1 matriz de rigidez
% % total;
% for i=1 ,  % -- considerando 1 elementos.
%     
% matriz_R2_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_R2_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_rigidez_v;
% 
% end
% 
% %-- aplicando a transformção à matriz de massa :
% 
% matriz_massa_v = matriz_transformacaot * matriz_massa_v * matriz_transformacao ;
% 
% %-- somando as matrizes de massa dos 5 elementos em 1 matriz de massa
% %total;
% 
% for i=1 ,  % -- considerando 5 elementos.
%     
% matriz_M2_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_M2_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_massa_v;
% 
% end
% 
% 
% 
% theta = -pi;
%     
% matriz_transformacao = [ cos(theta) sin(theta) 0    0          0        0
%                         -sin(theta) cos(theta) 0    0          0        0
%                            0           0       1    0          0        0
%                            0           0       0 cos(theta) sin(theta)  0
%                            0           0       0 -sin(theta) cos(theta) 0
%                            0           0       0    0          0        1];
%        
% matriz_transformacaot =  matriz_transformacao';
% 
% % -- aplicando a transformação à matriz de rigidez :
%                        
% matriz_rigidez_3 =matriz_transformacaot * matriz_rigidez * matriz_transformacao ; 
% 
% % -- somando as matrizes de rigidez dos 5 elemntos em 1 matriz de rigidez
% % total;
% for i=1:5 ,  % -- considerando 5 elementos.
%     
% matriz_R3_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_R3_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_rigidez_3;
% 
% end
% 
% 
% 
% % -- aplicando a transformção à matriz de massa :
% 
% matriz_massa_3 = matriz_transformacaot * matriz_massa * matriz_transformacao ;
% 
% % -- somando as matrizes de massa dos 5 elementos em 1 matriz de massa
% % total;
% 
% for i=1:5 ,  % -- considerando 5 elementos.
%     
% matriz_M3_total(3*i-2:3*i+3,3*i-2:3*i+3) = matriz_M3_total(3*i-2:3*i+3,3*i-2:3*i+3) + matriz_massa_3;
% 
% end
% % matriz_M3_total(:, [16,17,18]) = [];
% % matriz_M3_total( [16,17,18] ,:) = [];
% 
% % --  acoplando as matrizes R1, R2, R3; --%
% 
% 
%     
%    matriz_R_total(1:18 , 1:18) = matriz_R_total(1:18, 1:18) + matriz_R1_total;
%    matriz_R_total(16:21 , 16:21) = matriz_R_total(16:21 , 16:21) + matriz_R2_total;
%    matriz_R_total(19:36 , 19:36) = matriz_R_total(19:36 , 19:36) + matriz_R3_total;
%    
%    
% % -- acoplando as matrizes M1, M2, M3; --%
% 
% matriz_M_total(1:18 , 1:18) = matriz_M_total(1:18, 1:18) + matriz_M1_total;
%    matriz_M_total(16:21 , 16:21) = matriz_M_total(16:21 , 16:21) + matriz_M2_total;
%    matriz_M_total(19:36 , 19:36) = matriz_M_total(19:36 , 19:36) + matriz_M3_total;
% 
% %    matriz_M_total(1:15 , 1:15) = matriz_M_total(1:15 , 1:15) + matriz_M1_total(1:15 , 1:15);
% %    matriz_M_total(13:18 , 13:18) = matriz_M_total(13:18 , 13:18) + matriz_M2_total(1:6 , 1:6);
% %    matriz_M_total(16:30 , 16:30) = matriz_M_total(16:30 , 16:30) + matriz_M3_total(1:15, 1:15);
% %    
% % -- impondo as condições de contorno -- %
% 
% matriz_k = matriz_R_total(4:6*(n_elementos+1)-3 , 4:6*(n_elementos+1)-3);
% matriz_m = matriz_M_total(4:6*(n_elementos+1)-3 , 4:6*(n_elementos+1)-3);
% 
% [modos,frequencia] = eig(matriz_k , matriz_m);
% 
% diag_freq = diag(frequencia);
% diag_frequencia = sqrt(diag_freq)/(2*pi);
% % -- %
% 
% % 
% %    [U,V] = eig ( matriz_R_total , matriz_M_total) ;
% %    
% %    diag_V = diag(V);
% %    diag_V = sqrt((diag_V))/(2*pi);
% %    
% %    % -- conferir resultados -- %
% %    
% %    
% %    diag_V(1:6)
% %    
% %    [shape,freq]= eig (matriz_R1_total , matriz_M1_total);
% %    diag_freq = diag(freq);
% %    freq = (sqrt(diag_freq))/2*pi;
%    
% %    [shape3,freq3]= eig (matriz_R3_total , matriz_M3_total);
% %    diag_freq3 = diag(freq3);
% %    freq3 = (sqrt(diag_freq3))/2*pi