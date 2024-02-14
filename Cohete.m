clear all;  clc;  clf;  close all;

n=100;           %Numero de pasos
val_pausa=0.06;  %valor pausa simulacion
theta=82;        %Angulo de tiro en grados  
v=17.122;            %Velocidad inicial
g=9.8;           %Aceleracion constante g
xo=0; yo=0.15;     %Posicion inicial x,y
t0=0; tf=13.8;      %Tiempo inicial,final 
k=0.005;  m=1;    %Parametros resistencia
c=0.475;                  %


deltat=(tf-t0)/n;   % Se define anchura de paso en t
t=t0:deltat:tf;     % Se genera completo el vector "t"  
vox=v*cosd(theta);
voy=v*sind(theta)-2*(exp^2(1-(c*deltat)/m));


%------  Trayectoria con Euler resistencia aire  ------
vx=vox;  vy=voy;   x=xo;  y=yo;
Gx=@(v) 0-(k/m)*v;   %Definimos la funcion G=F_R/m en x
Gy=@(v) -g-(k/m)*v;  %Definimos la funcion G=F_R/m en y

for i=1:n
    vx(i+1)=deltat*[Gx(vx(i))]+vx(i);
    x(i+1)=deltat*vx(i+1)+x(i);

    vy(i+1)=deltat*[Gy(vy(i))]+vy(i);
    y(i+1)=deltat*vy(i+1)+y(i); 

    if y(i)<=0   % Detener particula al caer
       y(i+1)=0;     vy(i+1)=0;
       x(i+1)=x(i);  vx(i+1)=0;
    end   
end
%-------------------------------------------------------


% %-----------  Figura estatica  -------------------------
% figure(1)          
% plot(x,y,'k-o','MarkerFaceColor','r'); hold on; 
% yline(0,'--k');   % Nivel suelo
% axis('auto');     % Escala de ejes automatico
% %xlim([-5 280]);  ylim([-20 80]);  %En caso de elegir max ejes
% xlabel('Distancia alcance (x) ');  ylabel('Altura (y) '); 
% title('Trayectoria');
% set(gca,'fontsize',19);
% legend('Trayectoria Euler','Location','Southwest');
% %-------------------------------------------------------


%-------------  Figura animada  ---------------------------
figure(2);  hold on;    grid on;

xlim([-1 8]);  ylim([0 15]);
xlabel('Distancia alcance (x) ');  ylabel('Altura (y) '); 
title('Trayectoria');  set(gca,'fontsize',19);

plot(x,y,'k--');     %Trayectoria Euler
yline(0);            %Nivel suelo  

curve=animatedline('Color','k','Marker','o','MarkerFaceColor','r','Markersize',10);

for i=1:n
     addpoints(curve,x(i),y(i));
     drawnow  limitrate;  pause(val_pausa);

     if i<n
          clearpoints(curve); 
     end    
end
%-------------------------------------------------------