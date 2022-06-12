%Obtiene la primitiva en el instante siguiente de cualquier ecuación
%diferencial de segundo orden por el método runge kutta de cuarto orden
%para fiabilidad.
function [y] = RungeKuttaFunc(f,ti,tf,dt,ci)
    n=(tf-ti)/dt;
    y(1)=ci;
    for i=1:n
        tn=ti+i*dt;
        k1=dt*f(tn,y(i));
        k2=dt*f(tn+0.5*dt,y(i)+0.5*k1);
        k3=dt*f(tn+0.5*dt,y(i)+0.5*k2);
        k4=dt*f(tn+dt,y(i)+k3);
        y(i+1)=y(i)+(1/6)*(k1+2*k2+2*k3+k4);
    end
end