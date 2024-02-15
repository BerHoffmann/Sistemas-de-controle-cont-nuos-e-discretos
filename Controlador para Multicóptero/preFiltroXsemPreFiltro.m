requisitos.tr = 1;
requisitos.Mp = 0.1;

planta = obterPlantaMulticoptero();

xi = abs(log(requisitos.Mp) / sqrt(pi^2 + (log(requisitos.Mp))^2 ));
wn = (pi - acos(xi)) / (requisitos.tr*sqrt(1-xi^2));
 
controlador.Kd = 7*xi*wn*planta.m;
controlador.Kp = planta.m*(10*xi^2*wn^2+ wn^2);
controlador.Ki = planta.m*5*xi*wn^3;

s = tf('s');

PF = controlador.Ki/ (planta.m*s^3+s^2*controlador.Kd+s*controlador.Kp+controlador.Ki);
sPF = (s^2*controlador.Kd+s*controlador.Kp+controlador.Ki)/(planta.m*s^3+s^2*controlador.Kd+s*controlador.Kp+controlador.Ki);

t = 0:1e-3:8;
t2 = 0:1e-3:8;

theta = step(PF, t);
theta2 = step(sPF, t);

figure;
hold on;
plot(t, theta, 'LineWidth', 2);
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('\theta (rad)', 'FontSize', 14);
set(gca, 'FontSize', 14);
hold on;

plot(t2, theta2, 'LineWidth', 2);
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('\theta (rad)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('com pré-filtro','sem pre-filtro');

