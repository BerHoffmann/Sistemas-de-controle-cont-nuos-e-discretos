% Avalia o controlador PI discreto para diferentes taxas de amostragem.

%% Configurando parametros das simulacoes

tempoSimulacao = 0.1;
requisitos.tr = 0.02;
requisitos.Mp = 0.046;
referencia.amplitude = 50;
referencia.instante = 0;
disturbio.amplitude = 0;
disturbio.instante = 0;
planta = obterPlantaServo();
controlador = projetarControladorPI(planta, requisitos);

%% Realizando simulacoes

fs = [1000, 500, 200, 100];
Ts = 1 ./ fs;
outs = cell(size(Ts));
for i=1:length(Ts)
    controlador.T = Ts(i);
    controlador.Vmax = inf;
    planta.Vmax = inf;
    outs{i} = sim('servomotor_pi_discreto');
end

%% Tracando graficos

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(Ts));
for i=1:length(Ts)
    plot(outs{i}.wRoda.time, outs{i}.wRoda.signals.values, 'LineWidth', 2);
    legs{i} = sprintf('f_s=%d Hz', fs(i));
end
legend(legs, 'FontSize', 14, 'Location', 'Southeast');
print -dpng -r400 w_roda_discreto.png % para usuarios de Word
% print -depsc2 w_roda_discreto.eps % para usuarios de LaTeX

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando (V)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(Ts));
for i=1:length(Ts)
    plot(outs{i}.V.time, outs{i}.V.signals.values, 'LineWidth', 2);
    legs{i} = sprintf('f_s=%d Hz', fs(i));
end
legend(legs, 'FontSize', 14, 'Location', 'Southeast');
print -dpng -r400 comando_discreto.png % para usuarios de Word
% print -depsc2 comando_discreto.eps % para usuarios de LaTeX