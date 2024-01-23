n = 20; 
x = zeros(n,1); 
y = zeros(n,1); 

fid = fopen("coordenadas.txt");
for i = 1:n
  x(i) = fscanf(fid, "%f", 1);
end
fclose(fid);

fid = fopen("incidencias.txt");
for i = 1:n
  y(i) = fscanf(fid, "%f", 1);
end
fclose(fid);

disp("Coordenadas x:");
disp(x);
disp("Coordenadas y:");
disp(y);

plot(x,y,'o');
xlabel("x");
ylabel("y");
