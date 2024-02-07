n = input('Introduzca el valor de N: ');

acum = 0;

for i = 1:n
  acum = acum + 2 * i;
end


disp('El valor de la serie es: ' + num2str(acum));
