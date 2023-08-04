close all;
clear all;

A1 = 15* 5 * 10^(-6);
A2 = 25 * 10^(-6);

l1 = 40*10^(-3);
l2 = 100*10^(-3);
lt = l1 + l2;

V1 = A1 * l1;
V2 = A2 * l2;

Vt = V1 + V2;

rho = 1040;

m1 = rho * V1;
m2 = rho* V2;

M1 = m1 * l1;
M2 = m2* l2;

E = 2.3 * 10^9;

k1 = ( E * A1 ) / l1;
k2 = ( E * A2 ) / l2;

mass = rho*Vt;
I = (5*10^(-3))^4 / 12;
% 
% MassMatrix = 1/6 * [ 2*(M1+M2) M2; M2 2*M2 ];
% StiffMatrix = [ k1+k2 -k2; -k2 k2 ];
% 
% [u,v] = eig(StiffMatrix,MassMatrix);
% w = sqrt(diag(v))/(2*pi)
% w1 = u * ( sqrt( (E*A2) / (M2*l2) ) )
% 
% w1 = 1.4029*sqrt(E*A2/M2*lt) / (2*pi)
% w1 = 3.6477*sqrt(E*A2/M2*lt) / (2*pi)
f = 1.875^2 * sqrt( E*I/(rho*A2*l2^4) ) / ( 2*pi)
f = 7.8^2 * sqrt( E*I/(rho*A2*l2^4) ) / ( 2*pi)

w = [3.52 22 61.7]*sqrt(E*I/(m2*l2^4);
f = w / (2*pi);

fe = 116.5
Er = ((fe * 2* pi))^2 / ( (I/(rho*A2*l2^4))*3.52^2)
% 
% P = [ 0 0]
% U = inv(StiffMatrix).*P
% 
% MI = inv(MassMatrix);
% 
% KM = MI*StiffMatrix
% [L, V] = eig (KM)
