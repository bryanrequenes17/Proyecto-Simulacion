% Montecarlo4
% Guión para mostrar el método de Montecarlo en un ejemplo clásico:
% la aguja de Buffon, utilizada para evaluar $\pi$.
% Referencia 1: tutorial "Montecarlo Methods" de Jonathan Pengelly (2002)
% Implementa la técnica denominada "Aceptación-Rechazo", que resulta
% la apropiada para este ejemplo.
np = 7; errel = []; elapstime = [];

fprintf('Estimación de pi usando la aguja de Buffon\n')
fprintf('==========================================\n')
for in = 1:np
    % Datos:
    N = 50; % Tamaño de la muestra
    L = 0.80; % Longitud de la aguja
    t = 1; % Separación de la malla (vertical)
    if L > t
        fprintf('En este programa la aguja no debe medir más de t = %3.2f\n',t)
        return
    end
    fc = 0.017453292519943; % Factor de conversión a radianes
    %diary montecarlo.txt
    
    % Sea T un entablado formado por tablas verticales contiguas.
    % Sean T0, T1, T2 tres "tablas" contiguas de T, de igual anchura = t.
    % Pongamos el origen de coordenadas en algún punto del borde izquierdo de T1.
    % Entonces, la abscisa izquierda de T1 = t1 = 0,y las abscisas izquierdas
    % de T0 y T2 son, respectivamente, t0 = -t y t2 = t, mientras el borde
    % derecho de T2 tiene abscisa t3 = 2t.      
    % Se generará aleatoriamente un extremo de la aguja, de abscisa Px, tal que
    % 0 <= Px <= t3. Luego se generará igualmente el ángulo theta entre la aguja
    % y el eje horizontal x, tal que 0 <= theta <= 360.
    % Con esto se puede calcular la abscisa Rx del otro extremo de la aguja.
    % Sea Z1 la tabla en que quedó Px y Z2 aquélla en la que está Rx.
    % Entonces, la aguja habrá cruzado un borde si y sólo si Z1 y Z2 son diferentes.
    
    % Según la referencia 2, $\pi$ es aproximadamente 2L.N/(t.h).
    
    % Técnica de Aceptación-Rechazo:
    
    tic
    h = 0;
    for i = 1:N
        % Genera la abscisa de un extremo de la aguja:
        % Es mucho más rápido que usar random('unif',0,2*t):
        Px = rand*2*t;
        % Genera el ángulo entre la dirección de la aguja y la horizontal
        theta = fc*rand*360;
        %fprintf('Abscisa extrema: %6.4f, Angle = %7.4f\n',Px,theta)
        % Calcula el otro extremo de la aguja:
        Rx = Px+L*cos(theta);
        % Encuentra las zonas (-1,0 o 1) de ambos extremos:
        Z1 = floor(Px/t); Z2 = floor(Rx/t);
        % Chequea si cruza o no una vertical de la malla:
        if Z1 ~= Z2 % Sí la cruza:
            h = h+1;
        end
    end
    % Estimación de pi:
    epi = 2*L*N/(t*h);
    toc
    errel(in)=(epi-pi)/pi;
    elapstime(in)=toc;
end

subplot(211), plot(1:np,abs(errel))
title('Error relativo')
grid on
subplot(212), plot(1:np,elapstime)
strepi = sprintf('%10.8f',epi);
title('Tiempo de ejecución (sec)')
grid on
xlabel('log_{10}N')
suptitle([{'Cálculo de pi usando la aguja de Buffon:'},...
    {['\pi =',strepi]}])