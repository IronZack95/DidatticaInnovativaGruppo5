clc;                                               % Clears the screen
clear all;
close all;

tspan = [0,pi];
h=0.01*tspan(2);        % frazione decimale di pi-->100 passi 
t = tspan(1):h:tspan(2);                                        
i = zeros(1,length(t)); 
y1(1) = 0;     
y2(1) = 0;% initial condition
mu = 1;
% Termini forzanti già presenti nel file del De Falco
x   = @(t) sin (t) .^ 4;
xp  = @(t) 4 * sin (t) .^ 3 .* cos (t);
xpp = @(t) 4 * (3 * sin (t) .^ 2 .* cos (t) .^2 - sin (t) .^ 4);
mu  = 1;
f   = @(t) xpp(t) - mu * (1 - x(t).^2) .* xp(t) + x(t);
% Sistema differenziale
y1_dot = @(t, y2) y2;
y2_dot = @(t, y1, y2) mu*(1-y1^2)*y2-y1+f(t);  

for i=1:(length(t)-1)                              % calculation loop
    k1_1 = y1_dot(t(i), y2(i));
    k1_2 = y2_dot(t(i), y1(i), y2(i));
    k2_1 = y1_dot(t(i)+.5*h, y2(i)+.5*k1_2*h);
    k2_2 = y2_dot(t(i)+.5*h, y1(i)+.5*k1_1*h, y2(i)+.5*k1_2*h);
    k3_1 = y1_dot(t(i)+.5*h, y2(i)+.5*k2_2+h);
    k3_2 = y2_dot(t(i)+.5*h, y1(i)+.5*k2_1*h, y2(i)+.5*k2_2+h);
    k4_1 = y1_dot(t(i)+h, y2(i)+k3_2*h);
    k4_2 = y2_dot(t(i)+h, y1(i)+k3_1*h, y2(i)+k3_2*h);

    y1(i+1) = y1(i) + (1/6)*(k1_1+2*k2_1+2*k3_1+k4_1)*h;
    y2(i+1) = y2(i) + (1/6)*(k1_2+2*k2_2+2*k3_2+k4_2)*h;
    
end


% Linea continua soluzione esatta, x e o soluzione numerica

subplot(2,2,1)
plot (t, x(t),'g', t, xp(t),'r', t, y1, 'xb', t, y2, 'or')
title (['Soluzione RUNGE-KUTTA con n = ',int2str(length(t))])
xlabel('Time t');
ylabel('Solution y');
% legend('x(t)','dx(t)/dt')
axis([tspan(1) tspan(2) -inf inf])

subplot(2,2,2)
plot (t, x(t) - y1)
title ('errore prima componente')
xlabel('Time t');
axis([tspan(1) tspan(2) -inf inf])

subplot(2,2,4)
plot (t, xp(t) - y2)
title ('errore seconda componente')
xlabel('Time t');
axis([tspan(1) tspan(2) -inf inf])

subplot(2,2,3)
plot (t(2:end), diff (t))
title ('passo adattivo')
xlabel('Time t');
axis([tspan(1) tspan(2) h-0.01 h+0.01])