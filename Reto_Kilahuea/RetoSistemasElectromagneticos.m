clear all;
close all;

%Datos Iniciales
t0 = 0;             %Tiempo Incial
tf = 15;            %Tiempo Final
n = 5000;           %Número de datos entre tf y t0
dt = (tf-t0)/n;     %Diferencia de tiempo
t = t0:dt:tf;       %Vector con todos los datos de tiempo
m = 2000;           %Masa del sistema
k2 = 13000;         %Constante producida por corrientes Parásitas en el conductor 1
k3 = 100000;        %Constante producida por corrientes Parásitas en el conductor 2
%Funciones
f1 = @(t, v) -9.81;             %Función de Caída Libre
f2 = @(t, v) -9.81-(k2*v)/m;    %Función de Caída en Conductor 1
f3 = @(t, v) -9.81-(k3*v)/m;    %Función de Caída en Conductor 2

%Altura del juego
AlturaMax = 75;                 %Altura total del juego
AlturaCobre2 = 13;              %Altura del primer conductor
AlturaCobre1 = 2;               %Altura del segundo conductor

%Cálculos de Velocidad y Posición
%Se obtiene la velocidad integrando numericamente la función de
%aceleración 1  con la condición inicial que la velocidad en el tiempo 0 
%es 0
vel(1) = 0;
vel = RungeKuttaFunc(f1, t0, tf, dt, vel(1));
x = zeros(1,n);
x(1)=AlturaMax;
%Se obtiene la posición integrando por el método de euler la velocidad y de
%esta forma tenemos la posición para cualquier instante de tiempo del
%objeto en caida libre
for i=1:length(vel)
    x(i+1)=x(i)+vel(i)*dt;
end

%Iteramos por todo el vector de posición para encontrar cuando es que
%nuestro objeto de caida llega a tocar el primer pedazo del material
%conductor (cobre)
posCobre2 = 0;
for i=1:length(x)
    if (x(i) <= AlturaCobre2)
        posCobre2 = i;
        break
    end
end
t0 = posCobre2*dt;

%Se obtiene la velocidad para la función 2 que explica la aceleración del
%objeto en cualquier instante de tiempo cuando está en contacto con el
%material conductor 1, donde el tiempo inicial es el tiempo en el que se
%tocaron desde que inició la simulación y la condición incial es la
%velocidad que el carrito llevaba al llegar a esa altura con el vector de
%velocidad para caida libre
vel1 = RungeKuttaFunc(f2, t0, tf, dt, vel(posCobre2));
x1 = zeros(1,length(vel1));
x1(1)=AlturaCobre2;
%Integración Numérica para la posición
for i=1:length(vel1)
    x1(i+1)=x1(i)+vel1(i)*dt;
end
%Se itera por el nuevo vector de posición y se busca cuando se llega al
%segundo pedazo de cobre
posCobre1 = 0;
for i=1:length(x1)
    if (x1(i) <= AlturaCobre1)
        posCobre1 = i;
        break
    end
end
t0 = (posCobre2+posCobre1)*dt;

%Se integra numericamente para obtener la velocidad con la ecuación 3 donde
%el tiempo inicial es el tiempo donde se contactó el segundo conductor y la
%condición inicial la velocidad que llevaba el carrito al contactar
vel2 = RungeKuttaFunc(f3, t0, tf, dt, vel1(posCobre1));

%Se hace un vector final para la velocidad que contiene la parte
%representativa de cada vector de velocidad con ecuaciones diferentes
velf = [vel(1:posCobre2),vel1(2:posCobre1),vel2(2:end)];

%Se integra con el método de Euler este vector para obtener la posición con
%la velocidad final
xf = zeros(1,length(velf));
xf(1) = AlturaMax;
for i=1:length(velf)-1
    xf(i+1)=xf(i)+velf(i)*dt;
end
t = t(1:length(velf));

%Se deriva numericamnete para obtener la aceleración en todo momento a
%partir de la velocidad final
accel = zeros(1, length(velf));
for i=1:length(velf)-1
    accel(i) = (velf(i+1)-velf(i))/dt;
end
figure;
%Se dibuja la simulación en pantalla
plotKila(10, 3, t, accel, velf, xf, AlturaMax, AlturaCobre2, AlturaCobre1);