% Montecarlo4
% Gui�n para mostrar el m�todo de Montecarlo en un ejemplo cl�sico:
% la aguja de Buffon, utilizada para evaluar $\pi$.
% Referencia 1: tutorial "Montecarlo Methods" de Jonathan Pengelly (2002)
% Implementa la t�cnica denominada "Aceptaci�n-Rechazo", que resulta
% la apropiada para este ejemplo.
np = 7; errel = []; elapstime = [];

fprintf('Estimaci�n de pi usando la aguja de Buffon\n')
fprintf('==========================================\n')
for in = 1:np
    % Datos:
    N = 50; % Tama�o de la muestra
    L = 0.80; % Longitud de la aguja
    t = 1; % Separaci�n de la malla (vertical)
    if L > t
        fprintf('En este programa la aguja no debe medir m�s de t = %3.2f\n',t)
        return
    end
    fc = 0.017453292519943; % Factor de conversi�n a radianes
    %diary montecarlo.txt
    
    % Sea T un entablado formado por tablas verticales contiguas.
    % Sean T0, T1, T2 tres "tablas" contiguas de T, de igual anchura = t.
    % Pongamos el origen de coordenadas en alg�n punto del borde izquierdo de T1.
    % Entonces, la abscisa izquierda de T1 = t1 = 0,y las abscisas izquierdas
    % de T0 y T2 son, respectivamente, t0 = -t y t2 = t, mientras el borde
    % derecho de T2 tiene abscisa t3 = 2t.      
    % Se generar� aleatoriamente un extremo de la aguja, de abscisa Px, tal que
    % 0 <= Px <= t3. Luego se generar� igualmente el �ngulo theta entre la aguja
    % y el eje horizontal x, tal que 0 <= theta <= 360.
    % Con esto se puede calcular la abscisa Rx del otro extremo de la aguja.
    % Sea Z1 la tabla en que qued� Px y Z2 aqu�lla en la que est� Rx.
    % Entonces, la aguja habr� cruzado un borde si y s�lo si Z1 y Z2 son diferentes.
    
    % Seg�n la referencia 2, $\pi$ es aproximadamente 2L.N/(t.h).
    
    % T�cnica de Aceptaci�n-Rechazo:
    
    tic
    h = 0;
    for i = 1:N
        % Genera la abscisa de un extremo de la aguja:
        % Es mucho m�s r�pido que usar random('unif',0,2*t):
        Px = rand*2*t;
        % Genera el �ngulo entre la direcci�n de la aguja y la horizontal
        theta = fc*rand*360;
        %fprintf('Abscisa extrema: %6.4f, Angle = %7.4f\n',Px,theta)
        % Calcula el otro extremo de la aguja:
        Rx = Px+L*cos(theta);
        % Encuentra las zonas (-1,0 o 1) de ambos extremos:
        Z1 = floor(Px/t); Z2 = floor(Rx/t);
        % Chequea si cruza o no una vertical de la malla:
        if Z1 ~= Z2 % S� la cruza:
            h = h+1;
        end
    end
    % Estimaci�n de pi:
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
title('Tiempo de ejecuci�n (sec)')
grid on
xlabel('log_{10}N')
suptitle([{'C�lculo de pi usando la aguja de Buffon:'},...
    {['\pi =',strepi]}])