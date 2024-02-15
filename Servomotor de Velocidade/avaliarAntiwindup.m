% Avalia a a estrategia de anti-windup.

%% Configurando parametros das simulacoes

tempoSimulacao = 0.1;
requisitos.tr = 0.02;
requisitos.Mp = 0.046;
referencia.amplitude = 100;
referencia.instante = 0;
disturbio.amplitude = 0;
disturbio.instante = 0;
planta = obterPlantaServo();
controlador = projetarControladorPI(planta, requisitos);
controlador.T = 1 / 1000;

%% Realizando as simulacoes

controlador.Vmax = inf;
outSem = sim('servomotor_pi_discreto'); % sem anti-windup
controlador.Vmax = 12;
outCom = sim('servomotor_pi_discreto'); % com anti-windup

%% Tracando graficos

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
plot(outSem.wRoda.time, outSem.wRoda.signals.values, 'LineWidth', 2);
plot(outCom.wRoda.time, outCom.wRoda.signals.values, 'LineWidth', 2);
legend({'Sem anti-windup', 'Com anti-windup'}, 'FontSize', 14, 'Location', 'Southeast');
print -dpng -r400 w_roda_windup.png % para usarios de Word
% print -depsc2 w_roda_windup.eps % para usuarios de LaTeX

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando (V)', 'FontSize', 14);
set(gca, 'FontSize', 14);
plot(outSem.V.time, outSem.V.signals.values, 'LineWidth', 2);
plot(outCom.V.time, outCom.V.signals.values, 'LineWidth', 2);
legend({'Sem anti-windup', 'Com anti-windup'}, 'FontSize', 14, 'Location', 'Southeast');
print -dpng -r400 comando_windup.png % para usuarios de Word
% print -depsc2 comando_windup.eps % para usuarios de LaTeX
