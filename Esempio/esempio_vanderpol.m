%% sistema di equazioni
%% equazione del secondo ordine
%% y'' = mu * (1 - y^2) * y' - y + f
%% sistema del primo ordine
%% d y(1)  / dt = y(2)
%% d y(2)  / dt = mu * (1 - y(1)^2) * y(2) - y(1) + f
%%
%% soluzione esatta (scelta arbitrariamente)
%%
%% y (t, 1)  = sin (t) .^ 4
%% y (t, 2)  = y' (t, 1) = 4 * sin (t) .^ 3 .* cos (t)
%% y'(t, 2)  = y''(t, 1) = 4 * (3 * sin (t) ^ 2 * cos (t) ^2 - sin (t) ^ 4)
%%
%% forzante
%%
%% f(t) = y''(1,t) - mu * (1 - y(1, t) ^ 2) - y(1, t) 

clear all
close all


x   = @(t) sin (t) .^ 4;
xp  = @(t) 4 * sin (t) .^ 3 .* cos (t);
xpp = @(t) 4 * (3 * sin (t) .^ 2 .* cos (t) .^2 - sin (t) .^ 4);
mu  = 1;
f   = @(t) xpp(t) - mu * (1 - x(t).^2) .* xp(t) + x(t);
vdp = @(t, y) [y(2); mu*(1-y(1)^2)*y(2)-y(1)+f(t)];

[t, y] = ode23 (vdp, [0; pi], [x(0); xp(0)], odeset ('AbsTol', 1e-4));

plot (t, x(t), t, xp(t), t, y(:, 1), 'x', t, y(:, 2), 'o')

figure
plot (t, x(t) - y(:, 1))
title ('errore prima componente')

figure
plot (t, xp(t) - y(:, 2))
title ('errore seconda componente')

figure
semilogy (t(2:end), diff (t))
title ('passo adattivo')
