function Result=MDOF_simulation(M,C,K,f,fs)
% Inputs
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
if size(f,1)>size(f,2)
    f=f';
end

n=size(f,1);
dt=1/fs; %sampling rate
[Vectors Values]=eig(K,M);
Freq=sqrt(diag(Values))/(2*pi); % undamped natural frequency
steps=size(f,2);

Mn=diag(Vectors'*M*Vectors); % uncoupled mass
Cn=diag(Vectors'*C*Vectors); % uncoupled damping
Kn=diag(Vectors'*K*Vectors); % uncoupled stifness
wn=sqrt(diag(Values));
zeta=Cn./(sqrt(2.*Mn.*Kn));  % damping ratio
wd=wn.*sqrt(1-zeta.^2);

fn=Vectors'*f; % generalized input force matrix

t=[0:dt:dt*steps-dt];

%forced vibration

for i=1:1:n
    
    h(i,:)=(1/(Mn(i)*wd(i))).*exp(-zeta(i)*wn(i)*t).*sin(wd(i)*t); %transfer function of displacement
    hd(i,:)=(1/(Mn(i)*wd(i))).*(-zeta(i).*wn(i).*exp(-zeta(i)*wn(i)*t).*sin(wd(i)*t)+wd(i).*exp(-zeta(i)*wn(i)*t).*cos(wd(i)*t)); %transfer function of velocity
    hdd(i,:)=(1/(Mn(i)*wd(i))).*((zeta(i).*wn(i))^2.*exp(-zeta(i)*wn(i)*t).*sin(wd(i)*t)-zeta(i).*wn(i).*wd(i).*exp(-zeta(i)*wn(i)*t).*cos(wd(i)*t)-wd(i).*((zeta(i).*wn(i)).*exp(-zeta(i)*wn(i)*t).*cos(wd(i)*t))-wd(i)^2.*exp(-zeta(i)*wn(i)*t).*sin(wd(i)*t)); %transfer function of acceleration
    
    qq=conv(fn(i,:),h(i,:))*dt;
    qqd=conv(fn(i,:),hd(i,:))*dt;
    qqdd=conv(fn(i,:),hdd(i,:))*dt;
    
    q(i,:)=qq(1:steps); % modal displacement
    qd(i,:)=qqd(1:steps); % modal velocity
    qdd(i,:)=qqdd(1:steps); % modal acceleration
    
    
end

x=Vectors*q; %displacement
v=Vectors*qd; %vecloity
a=Vectors*qdd; %vecloity


% Free vibration

xi=zeros(n,1);  % displacement initial condition
vi=zeros(n,1);  % velocity initial condition

xno=Vectors'*M*xi./Mn;
vno=Vectors'*M*vi./Mn;

for i=1:1:n

AA=(vno(i)+xno(i).*zeta(i).*wn(i))./wd(i);
BB=xno(i);

qf(i,:)=exp(-zeta(i)*wn(i)*t).*(AA.*sin(wd(i)*t)+BB.*cos(wd(i)*t));
qdf(i,:)=wd(i)*exp(-zeta(i)*wn(i)*t).*(AA.*cos(wd(i)*t)-BB.*sin(wd(i)*t))-zeta(i).*wn(i).*exp(-zeta(i)*wn(i)*t).*(AA.*sin(wd(i)*t)+BB.*cos(wd(i)*t));
qddf(i,:)=wd(i)^2*exp(-zeta(i)*wn(i)*t).*(-AA.*sin(wd(i)*t)-BB.*cos(wd(i)*t))-2*zeta(i).*wn(i).*wd(i).*exp(-zeta(i)*wn(i)*t).*(AA.*cos(wd(i)*t)-BB.*sin(wd(i)*t))+zeta(i)^2.*wn(i)^2*exp(-zeta(i)*wn(i)*t).*(-AA.*sin(wd(i)*t)-BB.*cos(wd(i)*t));


end

x=x+Vectors*qf;
v=v+Vectors*qdf;
a=a+Vectors*qddf;

Result.Displacement=x;
Result.Velocity=v;
Result.Acceleration=a;
Result.Parameters.Freq=Freq;
Result.Parameters.DampRatio=zeta*100;
Result.Parameters.ModeShape=Vectors;
end



