A = zeros(3,3);
B = zeros(3,3);

for i = 1:3
  for j = 1:3
    A(i,j) = input("Ingrese el valor de A(i,j): ");
    B(i,j) = input("Ingrese el valor de B(i,j): ");
  end
end

disp("Matriz A:");
disp(A);
disp("Matriz B:");
disp(B);
