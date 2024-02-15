% Avalia efeito do indutor.

%% Configurando parametros das simulacoes

tempoSimulacao = 0.2;
requisitos.tr = 0.02;
requisitos.Mp = 0.046;
referencia.amplitude = 50;
referencia.instante = 0;
disturbio.amplitude = 0;
disturbio.instante = 0;
planta = obterPlantaServo();
Ls = [planta.L / 2, planta.L, 2 * planta.L, 4 * planta.L, 8 * planta.L];

%% Realizando simulacoes e tracando graficos de respostas ao degrau

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(Ls));
for i=1:length(Ls)
    planta.L = Ls(i);
    controlador = projetarControladorPI(planta, requisitos);
    out = sim('servomotor_pi');
    plot(out.wRoda.time, out.wRoda.signals.values, 'LineWidth', 2);
    legs{i} = sprintf('L=%f H', Ls(i));
end
legend(legs, 'FontSize', 14, 'Location', 'Southeast');

%% Tracando graficos das posicoes dos polos

figure;
hold on;
grid on;
xlabel('Re\{s\}', 'FontSize', 14);
ylabel('Im\{s\}', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(Ls));
for i=1:length(Ls)
    planta.L = Ls(i);
    controlador = projetarControladorPI(planta, requisitos);
    polos = obterPolosPI(controlador, planta);
    plot(polos, 's', 'LineWidth', 2);
    legs{i} = sprintf('L=%f H', Ls(i));
end
legend(legs, 'FontSize', 14, 'Location', 'Southwest');
