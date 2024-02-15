function avaliarMalhaArfagem()
% avaliarMalhaArfagem() avalia o projeto da malha de arfagem.

requisitos.tr = 0.1;
requisitos.Mp = 0.05;

planta = obterPlantaMulticoptero();

controlador = projetarControladorArfagem(requisitos, planta);

malha = obterMalhaArfagem(controlador, planta);

t = 0:1e-3:0.5;

theta = step(malha, t);

figure;
hold on;
plot(t, theta, 'LineWidth', 2);
grid on;
xlabel('Tempo (s)', 'FontSize', 14);
ylabel('\theta (rad)', 'FontSize', 14);
set(gca, 'FontSize', 14);

end