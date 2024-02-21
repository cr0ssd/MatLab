clear all;  clc;  clf;  close all;

n=100;           %Numero de pasos
val_pausa=0.06;  %valor pausa simulacion
N=20;            %Numero particulas 
g=9.8;           %Aceleracion constante g
h=10;            %Altura inicial particulas
t0=0; tf=8;      %Tiempo inicial,final 

%-----  Valores random para N particulas  -----------
%%% Random en intervalo (a,b):  r=(b-a)*rand(N,1)+a 
theta=(70)*rand(1,N);   %Angulo lanzamiento
v=(50-5)*rand(1,N)+5;   %Rapidez inicial particulas
xo=zeros(1,N);          %Todas particulas xo=0  
yo=ones(1,N)*h;         %Todas particulas altura inicial h
k=rand(1,N);            %Forma random particulas
m=(1-0.5)*rand(1,N)+0.5;   %Especificar mejor intervalo si necesario
kr=k./m;                   %Constante k reducida
%----------------------------------------------------

deltat=(tf-t0)/n;   % Se define anchura de paso en t
t=t0:deltat:tf;     % Se genera completo el vector "t" 
vox=v.*cosd(theta);
voy=v.*sind(theta);


%------  Trayectoria con Euler resistencia aire  ------
vx=vox;  vy=voy;   x=xo;  y=yo;
Gx=@(v,kr) 0-(kr)*v;   %Definimos la funcion G=F_R/m en x
Gy=@(v,kr) -g-(kr)*v;  %Definimos la funcion G=F_R/m en y


for j=1:N
    for i=1:n
        vx(i+1,j)=deltat*[Gx(vx(i,j),kr(j))]+vx(i,j);
        x(i+1,j)=deltat*vx(i+1,j)+x(i,j);

        vy(i+1,j)=deltat*[Gy(vy(i,j),kr(j))]+vy(i,j);
        y(i+1,j)=deltat*vy(i+1,j)+y(i,j); 

        if y(i,j)<=1   % Detener particula al caer
           y(i+1,j)=0;       vy(i+1,j)=0;
           x(i+1,j)=x(i,j);  vx(i+1,j)=0;
        end
    end   

    trayectoria(j)=animatedline('Color','k','Marker','o','MarkerFaceColor', ...
                   [rand rand rand],'Markersize',m(j)*10);
end
%-------------------------------------------------------



%----   Para 3D Transformar coordenadas  ---------
phi=(2*pi)*rand(1,N);
Z=y;  %Eje "y" es ahora eje Z
r=x;  X=abs(r).*cos(phi);  Y=abs(r).*sin(phi); 
%-------------------------------------------------


%-------------  Figura animada  ----------------------------------------
figure(1);  hold on;   grid on;

mx=max(x,[],'all');  my=max(y,[],'all');     %Val maximos x, y
xlim([-1.2*mx 1.2*mx]);  ylim([-1.2*mx 1.2*mx]);  zlim([0 my]);
xlabel('x');  ylabel('y');  zlabel('Altura (z)');
title('Trayectorias');   set(gca,'fontsize',19);
view([15 35]);   %Perspectiva figura

%%--  Volcan  --------
rho=linspace(1,10,50); alpha=linspace(0,2*pi,30);
[rho,alpha]=meshgrid(rho,alpha);
x_v=rho.*cos(alpha);  y_v=rho.*sin(alpha);  z_v=(1./rho); 
z_v=z_v*h;         %Reescalar tamano volcan
a=surf(x_v,y_v,z_v,'FaceColor',[0.8 0.6 0.5],'EdgeColor','none'); 
camlight left; 
a.FaceAlpha=0.4;
lighting phong; 
%%--------------------

%---  Circulo alcance maximo  -----
p=nsidedpoly(1000,'Center',[0 0],'Radius',mx); %mx=alcance max
plot(p,'FaceColor',[0.55 0.75 0.95]);
%----------------------------------

for i=1:n
    for j=1:N
       addpoints(trayectoria(j),X(i,j),Y(i,j),Z(i,j));
    end   
       drawnow  limitrate;  pause(val_pausa);

       if i<n
          for j=1:N
            clearpoints(trayectoria(j)); 
          end    
       end 
end
%----------------------------------------------------------------------

plot3(X,Y,Z);
 




