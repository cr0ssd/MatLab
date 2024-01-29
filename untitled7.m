close all; clear all; clc
lista_c=importdata('coordenadas.txt')
lista_i=importdata('incidencias.txt')
[f1,c1]=size(lista_i)
[f2,c2]=size(lista_c)
for i=1:f1
    p1=lista_i(i,1)
    p2=lista_i(i,2)
    grosor_a=lista_i(i,3)
    %llamar a la función de calcular área y volumen
    [distancia]=fundistancia_puntos(lista_c,p1,p2)
    [volumen_viga]=funvolumen_viga(grosor_a,c,b,e,distancia,b)
    distancia_total=distancia+distancia_total
    volumen_total=volumen_viga+volumen_total
    x=[lista_c(p1,1), lista_c(p2,1)];
    y=[lista_c(p1,2), lista_c(p2,2)];
    plot(x,y,'m')
    hold on
end
grid on
xlabel('Longitud en metros')
ylabel('Altura en metros')
title('Armadura Warren')
xlim([-1,21])
ylim([-17,19])
fprintf('El volumen total es %f', volumen_total)
fprintf('El costo total es ton %f', volumen_total*precio_ton)

%%
function[volumen_viga]=funvolumen_viga(grosor_a,c,b,e,distancia)
area_alma=grosor_a*c
area_patin=(b*e)*2
area_seccion=area_alma+area_patin
volumen_viga=area_seccion*distancia 
end
function [distancia]=fundistancia_puntos(lista_c, p1,p2)
distancia=sqrt((lista_c(p1,1)-lista_c(p2,1))^2+((lista_c(p1,2)-lista_c(p2,2))^2))
end
