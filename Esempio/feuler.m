function [t,u] = feuler(odefun,tspan,y0,Nh)
h = (tspan(2)-tspan(1))/Nh;
t = linspace(tspan(1),tspan(2),Nh+1)';
y0 = y0(:);
d = length(y0);
u = zeros(Nh+1,d);
u(1,:) = y0.';
for n = 1:Nh
   wn = u(n,:).';
   w = wn + h*odefun(t(n),wn);
   u(n+1,:) = w.';
end

end