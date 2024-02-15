function tracarGraficosSimulacao(simulacao)
% tracarGraficosSimulacao(simulacao) traca graficos de uma simulacao de
% voo do multicoptero.

formato = 'png'; % para usuarios de Word
% formato = 'eps'; % para usuarios de LaTeX

figure;
plot(simulacao.xr.signals.values, simulacao.zr.signals.values, 'r', 'LineWidth', 2);
hold on;
plot(simulacao.x.signals.values, simulacao.z.signals.values, 'b', 'LineWidth', 2);
xlabel('X (m)', 'FontSize', 14);
ylabel('Z (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referencia', 'Executado');
grid on;
axis equal;
salvarGrafico(sprintf('x_z_%c', simulacao.experimento), formato);

figure;
plot(simulacao.xr.time, simulacao.xr.signals.values, 'r', 'LineWidth', 2);
hold on;
plot(simulacao.x.time, simulacao.x.signals.values, 'b', 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('X (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referencia', 'Executado');
grid on;
salvarGrafico(sprintf('t_x_%c', simulacao.experimento), formato);

figure;
plot(simulacao.zr.time, simulacao.zr.signals.values, 'r', 'LineWidth', 2);
hold on;
plot(simulacao.z.time, simulacao.z.signals.values, 'b', 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('Z (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referencia', 'Executado');
grid on;
salvarGrafico(sprintf('t_z_%c', simulacao.experimento), formato);

figure;
plot(simulacao.thetar.time, simulacao.thetar.signals.values, 'r', 'LineWidth', 2);
hold on;
plot(simulacao.theta.time, simulacao.theta.signals.values, 'b', 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('\theta (rad)', 'FontSize', 14);
set(gca, 'FontSize', 14);
legend('Referencia', 'Executado');
grid on;
salvarGrafico(sprintf('t_theta_%c', simulacao.experimento), formato);

figure;
plot(simulacao.f.time, simulacao.f.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('f (N)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
salvarGrafico(sprintf('t_f_%c', simulacao.experimento), formato);

figure;
plot(simulacao.tau.time, simulacao.tau.signals.values, 'LineWidth', 2);
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('\tau (N m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;
salvarGrafico(sprintf('t_tau_%c', simulacao.experimento), formato);

end

function salvarGrafico(nome, formato)
% Salva o grafico corrente.
% nome: nome do arquivo.
% formato: formato do arquivo ('png' ou 'eps').

if strcmp(formato, 'png')
    print('-dpng', '-r400', nome);
else
    print('-depsc2', nome);
end

end