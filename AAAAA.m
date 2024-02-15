%x=linspace(1,5,20);
%y=x.^2;
%figure(1)
%plot(x,y,'p')
%figure(2)
%plot(x,y)

%x=linspace(-5,5100);
%g=exp(x).*sin(x)./(x.^3+1);
%plot(x,g)
%grid
%xlabel('Eje x')
%ylabel('Eje y')
%title('Ejemplo 1')
%legend('$\frac{e^{x}\sin(x)){x^3+1}$','Interpreter','latex')

%x=linspace(0,10,200);
%y=sin(x).*wxp(-0.4*x);
%plot(x,y)
%ezplot('sin(x)*exp(-0.4*x)',[0,10])
%fplot(@(x)sin(x).*exp(-0.4.*x))

%subplot(2,1,1);
%x=linspace(0,10,200);
%yl=sin(x);
%plot(x,y1)

%subplot(2,1,2);
%y2=sin(5*x);
%plot(x,y2)

% Definición de la función
function Vab=votaje_pw(R1, R2, R3, V)

% Cálculo de la tensión
Vab=(R1 * R3 - R2 * R4) / (R1 + R2) * V

end

% Definición de las variables
R1 =120.6
R2 =119.3
R3 =121.2
R4 =118.8
V = 14

% Cálculo de la tensión
Vab = votaje_pw(R1, R2, R3, V)

% Impresión del resultado
disp(Vab)
