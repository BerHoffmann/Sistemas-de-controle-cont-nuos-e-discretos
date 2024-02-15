% Avalia modelo linear do controlador lateral

% Inicializando variaveis
inicializarLateral;

% Valores de y0 usados para avaliar a linearidade
y0s = [0.1, 0.3, 0.5];

for i=1:length(y0s)
    y0 = y0s(i);
    outLinear = sim('lateral_linear.slx');
    outNaoLinear = sim('lateral_naolinear.slx');
    figure;
    hold on;
    plot(outLinear.y.time, outLinear.y.signals.values, 'LineWidth', 2);
    plot(outNaoLinear.y.time, outNaoLinear.y.signals.values, 'LineWidth', 2);
    xlabel('Tempo (s)', 'FontSize', 14);
    ylabel('Y (m)', 'FontSize', 14);
    legend('Linear', 'Nao-linear');
    title(sprintf('y_0 = %g', y0));
    set(gca, 'FontSize', 14);
    grid on;
    %filename = sprintf('linearidade_lateral_y_y0=%g', y0);
    %print('-dpng', '-r400', [filename, '.png']); % for Word users
%     print('-depsc2', [filename, '.eps']); % for LaTeX users

    figure;
    hold on;
    plot(outLinear.psi.time, rad2deg(outLinear.psi.signals.values), 'LineWidth', 2);
    plot(outNaoLinear.psi.time, rad2deg(outNaoLinear.psi.signals.values), 'LineWidth', 2);
    xlabel('Tempo (s)', 'FontSize', 14);
    ylabel('\psi (°)', 'FontSize', 14);
    legend('Linear', 'Nao-linear');
    title(sprintf('y_0 = %g', y0));
    set(gca, 'FontSize', 14);
    grid on;
    %filename = sprintf('linearidade_lateral_psi_y0=%g', y0);
    %print('-dpng', '-r400', [filename, '.png']); % for Word users
%     print('-depsc2', [filename, '.eps']); % for LaTeX users
end
