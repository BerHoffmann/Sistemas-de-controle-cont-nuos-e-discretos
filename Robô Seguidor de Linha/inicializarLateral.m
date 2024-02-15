% Inicializa variaveis para os modelos de simulacao lateral_linear.slx
% lateral_naolinear.slx.

y0 = 0.5; % desvio em relacao a linha inicial
psi0 = 0; % angulo em relacao a linha inicial
yr = 0; % referencia
v = 0.8; % velocidade constante
wn = 2.0 * pi * 3.0; % frequencia natural
xi = 0.7; % fator de amortecimento
Ky = wn / (2 * xi * v); % ganho de posicao
Kpsi = 2 * xi * wn; % ganho de velocidade (relacionado ao angulo)
psirMax = 80 * pi / 180; % referencia de angulo maxima (saturacao)

out = sim("lateral_linear.slx");
plot(out.y.time, out.y.signals.values, 'red');
hold on;
plot(out.psi.time, out.psi.signals.values, 'blue');
legend('y', 'psi')

