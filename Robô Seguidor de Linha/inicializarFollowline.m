% Inicializa variaveis para o modelo de simulacao followline.slx.
x0 = 0; % coordenada x inicial
y0 = 0; % coordenada y inicial
psi0 = 0; % angulo inicial
xr = 1.0; % referencia de x (ponto na linha)
yr = 0.5; % referencia de posicao da linha
tau = 0.15; % constante de tempo do controlador frontal
wn = 2.0 * pi * 3.0; % frequencia natural do controlador lateral
xi = 0.7; % fator de amortecimento do controlador lateral
Kx = 1 / tau; % ganho proporcional do controlador frontal
KyPrime = wn / (2 * xi); % parte constante do ganho de posicao do controlador lateral
Kpsi = 2 * xi * wn; % ganho de velocidade (angulo) do controlador lateral
vMin = 0.1; % velocidade minima usada na adaptacao de Ky
vMax = 0.8; % velocidade maxima comandada para o robo
psirMax = 80 * pi / 180; % referencia de angulo maxima (saturacao)
maxWheelSpeed = 37; % velocidade angular maxima da roda
r = 0.03; % raio da roda
l = 2.0 * 0.0331; % distancia entre as rodas


out = sim('followline.slx');
animacaoFollowline(out);