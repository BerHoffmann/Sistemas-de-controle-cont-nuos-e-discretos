% Inicializa variaveis para o modelo de simulacao frontal.slx.
tau = 0.15; % constante de tempo
x0 = 0; % posicao inicial
xr = 1; % referencia
Kx = 1.0 / tau; % ganho proporcional

out = sim("frontal.slx");
plot(out.x.time, out.x.signals.values);

xlabel('tempo (s)');
ylabel('posição X (m)');
title('Simulação de controle de robô seguidor de linha com movimento apenas no eixo x');