function fazerAnimacaoMulticoptero(simulacao, planta)

t = simulacao.x.time;
xr = simulacao.xr.signals.values;
zr = simulacao.zr.signals.values;
x = simulacao.x.signals.values;
z = simulacao.z.signals.values;
theta = simulacao.theta.signals.values;
f = simulacao.f.signals.values;
tau = simulacao.tau.signals.values;

l = planta.l;

% Para ajustar os eixos do grafico de modo a possibilitar
% ver toda a simulacao
minX = min(x) - l;
maxX = max(x) + l;
meioX = (minX + maxX) / 2.0;
minZ = min(z) - l;
maxZ = max(z) + l;
deltaX = maxX - minX;
deltaY = maxZ - minZ;
tamanhoEixo = max(deltaX, deltaY);

dt = 1 / 60;
tempoVideo = t(1):dt:t(end);
% Interpolando para que o video fique numa taxa de quadros adequada
xr = interp1(t, xr, tempoVideo);
zr = interp1(t, zr, tempoVideo);
x = interp1(t, x, tempoVideo);
z = interp1(t, z, tempoVideo);
theta = interp1(t, theta, tempoVideo);
f = interp1(t, f, tempoVideo);
tau = interp1(t, tau, tempoVideo);
f1 = f / 2.0 - tau / l;
f2 = f / 2.0 + tau / l;
f1 = 0.1 * f1;
f2 = 0.1 * f2;

% Criando um azul que nao machuca os olhos...
% O azul puro 'b' fica terrivel num fundo preto puro 'k'...
azulBacana = [0, 0.4470, 0.7410];

close all;
figure;
hold on;
[r1, r2] = computarPontosMulticoptero(x(1), z(1), theta(1), l);
% Desenho inicial do multicoptero
handleReferencia = plot(xr(1), zr(1), 'r.', 'MarkerSize', 20);
handleChassis = plot([r1(1), r2(1)], [r1(2), r2(2)], 'k', 'LineWidth', 3);
handlef1 = quiver(r1(1), r1(2), f1(1) * sin(theta(1)), f1(1) * cos(theta(1)));
handlef2 = quiver(r2(1), r2(2), f2(1) * sin(theta(1)), f2(1) * cos(theta(1)));
axis([meioX - tamanhoEixo / 2.0, meioX + tamanhoEixo / 2.0, 0.0, tamanhoEixo]);
axis square;
set(gca, 'nextplot', 'replacechildren');
xlabel('X (m)', 'FontSize', 14);
ylabel('Z (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;

% Para salvar video (exibe animacao em tempo real)
video = VideoWriter(sprintf('multicoptero_%c.avi', simulacao.experimento));
video.FrameRate = 60;
video.Quality = 100;
open(video);
drawnow;
f = gcf;
f.Position = [100 100 1024 768];
frame = getframe(gcf);
writeVideo(video, frame);
% Aqui comeca-se de 2 porque o frame 1 ja foi desenhado antes
for i=2:length(tempoVideo)
    [r1, r2] = computarPontosMulticoptero(x(i), z(i), theta(i), l);
    set(handleReferencia, 'XData', xr(i), 'YData', zr(i));
    set(handleChassis, 'XData', [r1(1), r2(1)],...
        'YData', [r1(2), r2(2)]);
    set(handlef1, 'XData', r1(1), 'YData', r1(2),...
        'UData', f1(i) * sin(theta(i)), 'VData', f1(i) * cos(theta(i)));
    set(handlef2, 'XData', r2(1), 'YData', r2(2),...
        'UData', f2(i) * sin(theta(i)), 'VData', f2(i) * cos(theta(i)));
    drawnow;
    pause(dt);
    frame = getframe(gcf);
    writeVideo(video, frame);
end
close(video);

end

function [r1, r2] = computarPontosMulticoptero(x, z, theta, l)

[dr1x, dr1z] = rotacionar(l / 2.0, 0, -theta);
[dr2x, dr2z] = rotacionar(-l / 2.0, 0, -theta);

r1 = [x + dr1x, z + dr1z];
r2 = [x + dr2x, z + dr2z];

end

function [xRotacionado, yRotacionado] = rotacionar(x, z, theta)
% Rotaciona as coordenadas x e y usando o angulo psi e retorna as 
% coordenadas rotacionadas como xRotacionado e yRotacionado, 
% respectivamente.

xRotacionado = x * cos(theta) - z * sin(theta);
yRotacionado = x * sin(theta) + z * cos(theta);

end