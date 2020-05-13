%% Equazione di van der pol
%% x'' - mu * (1 - x^2) * x' + x = 0
%%
%% forzante
%% f(t) = y''(1,t) - mu * (1 - y(1, t) ^ 2) + y(1, t) = 0
%%
%% le pongo uguali visto che sono entrambe uguali a zero
%% x'' - mu * (1 - x^2) * x' + x = y''(1,t) - mu * (1 - y(1, t) ^ 2) + y(1, t)
%%
%% le riscrivo come segue
%% x'' - mu * (1 - x^2) * x' + x = f(t)
%%
%% porto al secono membro
%% x'' = f(t) - mu * (1 - x^2) * x' + x
%%
%% sistema di equazioni
%% equazione del secondo ordine
%% y'' = mu * (1 - y^2) * y' - y + f
%%
%% sistema del primo ordine
%% d y(1)  / dt = y(2)
%% d y(2)  / dt = mu * (1 - y(1)^2) * y(2) - y(1) + f
%%
%% soluzione esatta (scelta arbitrariamente)
%%
%% y (t, 1)  = sin (t) .^ 4
%% y (t, 2)  = y' (t, 1) = 4 * sin (t) .^ 3 .* cos (t)
%% y'(t, 2)  = y''(t, 1) = 4 * (3 * sin (t) ^ 2 * cos (t) ^2 - sin (t) ^ 4)

clc
clear all
close all
figure

tspan = [0,pi];
passi = 100;

x   = @(t) sin (t) .^ 4;
xp  = @(t) 4 * sin (t) .^ 3 .* cos (t);
xpp = @(t) 4 * (3 * sin (t) .^ 2 .* cos (t) .^2 - sin (t) .^ 4);
mu  = 1;
f   = @(t) xpp(t) - mu * (1 - x(t).^2) .* xp(t) + x(t);
vdp = @(t, y) [y(2); mu*(1-y(1)^2)*y(2)-y(1)+f(t)];

[t, y] = feuler (vdp, tspan, [x(0); xp(0)],passi);

subplot(2,2,[1,2])
plot (t, x(t),'g', t, xp(t),'r', t, y(:, 1), 'xb', t, y(:, 2), 'or')
title (['Soluzione Eulero con n = ',int2str(passi)])
xlabel('Time t');
ylabel('Solution y');
% legend('x(t)','dx(t)/dt')
axis([tspan(1) tspan(2) -inf inf])

subplot(2,2,3)
plot (t, x(t) - y(:, 1))
title ('errore prima componente')
xlabel('Time t');
axis([tspan(1) tspan(2) -inf inf])

subplot(2,2,4)
plot (t, xp(t) - y(:, 2))
title ('errore seconda componente')
xlabel('Time t');
axis([tspan(1) tspan(2) -inf inf])
%{
subplot(2,2,3)
semilogy (t(2:end), diff (t))
title ('passo adattivo')
xlabel('Time t');
axis([tspan(1) tspan(2) tspan(2)/passi-0.01 tspan(2)/passi+0.01])
%}