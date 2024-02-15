% Avalia influencia do requisito de tempo de subida usado no projeto do 
% no comportamento do controlador PI.

%% Configurando parametros das simulacao

tempoSimulacao = 0.2;
requisitos.tr = 0.02;
requisitos.Mp = 0.046;
referencia.amplitude = 50;
referencia.instante = 0;
disturbio.amplitude = 0;
disturbio.instante = 0;
planta = obterPlantaServo();
trs = [requisitos.tr, requisitos.tr / 2, requisitos.tr / 4, requisitos.tr / 8];

%% Realizando simulacoes e tracando graficos de respostas ao degrau

figure;
hold on;
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Velocidade da Roda (rad/s)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(trs));
for i=1:length(trs)
    requisitos.tr = trs(i);
    controlador = projetarControladorPI(planta, requisitos);
    out = sim('servomotor_pi');
    plot(out.wRoda.time, out.wRoda.signals.values, 'LineWidth', 2);
    legs{i} = sprintf('t_r=%.4f s', trs(i));
end

%% Tracando graficos das posicoes dos polos

legend(legs, 'FontSize', 14, 'Location', 'Southeast');
figure;
hold on;
grid on;
xlabel('Re\{s\}', 'FontSize', 14);
ylabel('Im\{s\}', 'FontSize', 14);
set(gca, 'FontSize', 14);
legs = cell(size(trs));
for i=1:length(trs)
    requisitos.tr = trs(i);
    controlador = projetarControladorPI(planta, requisitos);
    polos = obterPolosPI(controlador, planta);
    plot(polos, 's', 'LineWidth', 2);
    legs{i} = sprintf('t_r=%.4f s', trs(i));
end
legend(legs, 'FontSize', 14, 'Location', 'Southwest');
