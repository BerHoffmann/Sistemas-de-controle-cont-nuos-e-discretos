% Avalia o controlador P + feedforward.

%% Configurando parametros da simulacao

tempoSimulacao = 0.2;
requisitos.tau = 0.01;
referencia.amplitude = 50;
referencia.instante = 0;
disturbio.amplitude = 0.2;
disturbio.instante = 0.1;
planta = obterPlantaServo();
controlador = projetarControladorPFeedforward(planta, requisitos);

%% Realizando a simulacao

out = sim('servomotor_p_feedforward');

%% Tracando graficos

figure;
plot(out.wMotor.time, out.wMotor.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade do Motor (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 w_motor_pfeedforward.png % para usuarios de Word
% print -depsc2 w_motor_pfeedforward.eps % para usuarios de LaTeX

figure;
plot(out.wRoda.time, out.wRoda.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 w_roda_pfeedforward.png % para usuarios de Word
% print -depsc2 w_roda_pfeedforward.eps % para usuarios de LaTeX

figure;
plot(out.V.time, out.V.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando (V)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
print -dpng -r400 comando_pfeedforward.png % para usuarios de Word
% print -depsc2 comando_pfeedforward.eps % para usuarios de LaTeX