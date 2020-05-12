x_plot = linspace(0,20,100);
f = @(x) sin(x);

[t,y] = ode23(@vdp1,[0 20],[2; 0]);
% plot(t,y(:,1),'-o',t,y(:,2),'-o')

title('Solution of van der Pol Equation (\mu = 1) with ODE23');
xlabel('Time t');
ylabel('Solution y');
legend('y_1','y_2')

