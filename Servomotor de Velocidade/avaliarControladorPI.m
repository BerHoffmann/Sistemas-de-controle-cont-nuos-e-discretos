% Avalia o controlador PI com pre-filtro.

%% Configurando parametros da simulacao

tempoSimulacao = 0.2;
requisitos.tr = 0.02;
requisitos.Mp = 0.046;
referencia.amplitude = 50;
referencia.instante = 0;
disturbio.amplitude = 0.2;
disturbio.instante = 0.1;
planta = obterPlantaServo();
controlador = projetarControladorPI(planta, requisitos);

%% Realizando a simulacao

out = sim('servomotor_pi');

%% Tracando graficos

figure;
plot(out.wMotor.time, out.wMotor.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade do Motor (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 w_motor_pi.png % para usuarios de Word
% print -depsc2 w_motor_pi.eps % para usuarios de LaTeX
figure;
plot(out.wRoda.time, out.wRoda.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 w_roda_pi.png % para usuarios de Word
% print -depsc2 w_roda_pi.eps % para usuarios de LaTeX

figure;
plot(out.V.time, out.V.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando (V)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 comando_pi.png % para usuarios de Word
% print -depsc2 comando_pi.eps % para usuarios de LaTeX