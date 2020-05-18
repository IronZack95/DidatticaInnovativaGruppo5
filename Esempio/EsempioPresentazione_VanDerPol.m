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

x   = @(t) sin (t) .^ 4;
xp  = @(t) 4 * sin (t) .^ 3 .* cos (t);
xpp = @(t) 4 * (3 * sin (t) .^ 2 .* cos (t) .^2 - sin (t) .^ 4);
mu  = 1;
f   = @(t) xpp(t) - mu * (1 - x(t).^2) .* xp(t) + x(t);
vdp = @(t, y) [y(2); mu*(1-y(1)^2)*y(2)-y(1)+f(t)];

t = tspan(1):0.01:tspan(2)
plot (t, x(t),'g', t, xp(t),'r','LineWidth',1.5)
title ('Soluzione Oscillatore di Van Der Pol')
xlabel('Time t');
ylabel('Solution y');
legend('x(t)','dx(t)/dt')
axis([tspan(1) tspan(2) -inf inf])
