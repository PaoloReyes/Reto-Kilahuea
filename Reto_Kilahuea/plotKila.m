function plotKila(width, height, t, a, v, x, am, c2, c1)
    %Se crea el layout de 4 gráficas
    tiledlayout(2,2);
    ax1=nexttile;
    ax2=nexttile;
    ax3=nexttile;
    ax4=nexttile;
    
    %Se crean vectores para dibujar la estructura con el pedazo de caida
    %libre, cobre 1 y cobre 2
    tol=3;
    bx=[(width/2)-tol, -(width/2)+tol];
    by1=[am, am];
    by2=[c2, c2];
    by3=[c1, c1];
    
    %Se espera 4 segundos para maximizar la pantalla
    pause(4);

    %Se define el tamaño de paso para no dibujar las 5000 iteraciones del
    % los vectores
    dt = 35;
    
    %Se ejecuta el ciclo que dibuja en cada posición del layout la gráfica
    %de aceleración, velocidad, posición y la simulación incluyendo textos
    %con los valores de cada variable actuales. Se tienen condicionales if
    %que dicen que para la ultima iteración del ciclo desplieguen la
    %información de valor como la aceleración máxima de toda la simulación,
    %la velocidad final y la posición final
    for i=1:dt:length(x)
        plot(ax1, t(1:i), a(1:i), 'b')
        ax1.Title.String = "Aceleración";
        ax1.XLabel.String = "Tiempo (Segundos)";
        ax1.YLabel.String = "Aceleración (m/s^2)";
        if i > length(x)-dt
            text(ax1, 6.5, 100, "A(max) = "+max(a)+" m/s^2", 'FontSize', 18)
        else
            text(ax1, 6.5, 100, "A(t) = "+a(i)+" m/s^2", 'FontSize', 18)
        end
        ax1.XLim = [min(t), max(t)];
        ax1.YLim = [min(a)-5, max(a)+5];
        plot(ax2, t(1:i), v(1:i), 'b')
        ax2.Title.String = "Velocidad";
        ax2.XLabel.String = "Tiempo (Segundos)";
        ax2.YLabel.String = "Velocidad (m/s)";
        if i > length(x)-dt
            text(ax2, 6.5, -20, "V(terminal) = "+v(i)+" m/s", 'FontSize', 18)
        else
            text(ax2, 6.5, -20, "V(t) = "+v(i)+" m/s", 'FontSize', 18)
        end
        ax2.XLim = [min(t), max(t)];
        ax2.YLim = [min(v)-5, max(v)+10];
        plot(ax3, t(1:i), x(1:i), 'b')
        ax3.Title.String = "Posición";
        ax3.XLabel.String = "Tiempo (Segundos)";
        ax3.YLabel.String = "Posición (m)";
        if i > length(x)-dt
            text(ax3, 6.5, 35, "X(final) = "+x(i)+" m", 'FontSize', 18)
        else
            text(ax3, 6.5, 35, "X(t) = "+x(i)+" m", 'FontSize', 18)
        end
        ax3.XLim = [min(t), max(t)];
        ax3.YLim = [min(x), max(x)+5];
        rx=[width/2,width/2,-width/2,-width/2,width/2];
        ry=[x(i),x(i)+(height),x(i)+(height),x(i),x(i)];
        area(ax4, bx, by1, 'FaceColor', [200/255 200/255 200/255]);
        hold on;
        area(ax4, bx, by2, 'FaceColor', [200/255 132/255 40/255]);
        area(ax4, bx, by3, 'FaceColor', [150/255 90/255 0/255]);
        plot(ax4, rx, ry, 'b');
        hold off;
        ax4.Title.String = "Simulación";
        ax4.YLabel.String = "Altura (m)";
        ax4.XLim = [-width/2-1,width/2+1];
        ax4.YLim = [-1, max(x)+10];
        drawnow limitrate;
    end
end