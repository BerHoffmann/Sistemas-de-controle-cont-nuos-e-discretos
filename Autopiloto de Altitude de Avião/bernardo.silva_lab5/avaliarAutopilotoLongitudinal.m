function avaliarAutopilotoLongitudinal()
% avaliarAutopilotoLongitudinal() avalia o autopiloto longitudinal
% projetado considerando diferentes valores do ruido de medida de altitude.

hr = 100;
tf = 30;

controlador = obterControladorLongitudinal();

planta = obterPlantaLongitudinal();

varhs = [0, 10, 100, 1000];

assignin('base', 'hr', hr);
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);

h = cell(3, 1);
hm = cell(3, 1);
deltae = cell(3, 1);
for i=1:length(varhs)
    varh = varhs(i);
    
    assignin('base', 'varh', varh);
    
    % Carregando o Simulink
    load_system('boeing747_longitudinal');

    % Configurando o tempo final de simulacao
    set_param('boeing747_longitudinal', 'StopTime', sprintf('%g', tf));

    % Rodando a simulacao
    simulacao = sim('boeing747_longitudinal');
    
    h{i} = simulacao.h;
    hm{i} = simulacao.hm;
    deltae{i} = simulacao.deltae;
end

colors = get(0, 'DefaultAxesColorOrder');

legs = {};
for i=1:length(varhs)
    legs{i} = sprintf('\\sigma_h^2 = %g ft^2', varhs(i));
end

figure;
hold on;
grid on;
for i=1:length(varhs)
    plot(h{i}.time, h{i}.signals.values, 'Color', colors(i, :));
end
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Altura (ft)', 'FontSize', 14);
legend(legs, 'FontSize', 12, 'Location', 'Southeast');
set(gca, 'FontSize', 14);

figure;
hold on;
grid on;
handles = [];
for i=length(varhs):-1:1
    handles(i) = plot(hm{i}.time, hm{i}.signals.values, 'Color', colors(i, :));
end
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Altura Medida (ft)', 'FontSize', 14);
legend(handles, legs, 'FontSize', 12, 'Location', 'Southeast');
set(gca, 'FontSize', 14);

figure;
hold on;
grid on;
handles = [];
for i=length(varhs):-1:1
    handles(i) = plot(deltae{i}.time, deltae{i}.signals.values, 'Color', colors(i, :));
end
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Comando de Profundor {\delta}e (crad)', 'FontSize', 14);
legend(handles, legs, 'FontSize', 12, 'Location', 'Southeast');
set(gca, 'FontSize', 14);

end