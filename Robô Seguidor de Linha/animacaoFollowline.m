function animacaoFollowline(out)
% Cria uma animacao de um robo seguidor de linha. A entrada out representa
% os dados de saida gerados pelo modelo de simulacao followline.slx.

t = out.x.time;
x = out.x.signals.values;
y = out.y.signals.values;
psi = out.psi.signals.values;

% Para ajustar os eixos do grafico de modo a possibilitar
% ver toda a simulacao
tamanhoRobo = 0.075;
minX = min(x) - tamanhoRobo;
maxX = max(x) + tamanhoRobo;
minY = min(y) - tamanhoRobo;
maxY = max(y) + tamanhoRobo;
deltaX = maxX - minX;
deltaY = maxY - minY;
tamanhoEixo = max(deltaX, deltaY);

dt = 1 / 60;
tempoVideo = t(1):dt:t(end);
% Interpolando para que o video fique numa taxa de quadros adequada
x = interp1(t, x, tempoVideo);
y = interp1(t, y, tempoVideo);
psi = interp1(t, psi, tempoVideo);

% Criando um azul que nao machuca os olhos...
% O azul puro 'b' fica terrivel num fundo preto puro 'k'...
azulBacana = [0, 0.4470, 0.7410];

close all;
figure;
hold on;
pontos = computarPontosRobo(x(1), y(1), psi(1));
% Desenho inicial do robo
handleChassis = fill(pontos.chassis.x, pontos.chassis.y, 'k');
handlePadraoTime = fill(pontos.padraoTime.x, pontos.padraoTime.y, 'r');
handlePadraoId = fill(pontos.padraoId.x, pontos.padraoId.y, azulBacana);
axis([minX tamanhoEixo minY tamanhoEixo]);
axis square;
set(gca, 'nextplot', 'replacechildren');
xlabel('X (m)', 'FontSize', 14);
ylabel('Y (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid on;

% Para salvar video (exibe animacao em tempo real)
video = VideoWriter('followline.avi');
video.FrameRate = 60;
open(video);
drawnow;
frame = getframe(gcf);
writeVideo(video, frame);
% Aqui comeca-se de 2 porque o frame 1 ja foi desenhado antes
for i=2:length(tempoVideo)
    pontos = computarPontosRobo(x(i), y(i), psi(i));
    % Alterando pontos do desenho do robo
    set(handleChassis, 'XData', pontos.chassis.x,...
        'YData', pontos.chassis.y);
    set(handlePadraoTime, 'XData', pontos.padraoTime.x,...
        'YData', pontos.padraoTime.y);
    set(handlePadraoId, 'XData', pontos.padraoId.x,...
        'YData', pontos.padraoId.y);
    drawnow;
    pause(dt);
    frame = getframe(gcf);
    writeVideo(video, frame);
end
close(video);

end

function pontos = computarPontosRobo(x, y, psi)
% Calcula coordenadas dos pontos do robo (padrao de cor e chassis)
% a partir da sua postura (x, y, psi). Usa o padrao antigo (2014)
% do ITAndroids VSS.

tamanhoRobo = 0.075; % regras oficiais do Very Small Size (VSS)
tamanhoPadrao = tamanhoRobo / 2.0;
% Cricao dos pontos usando o robo nao rotacionado como referencial
pontos.padraoTime.x = [-tamanhoPadrao, 0, 0, -tamanhoPadrao];
pontos.padraoTime.y = [tamanhoPadrao, tamanhoPadrao, 0, 0];
pontos.padraoId.x = [0, tamanhoPadrao, tamanhoPadrao, 0];
pontos.padraoId.y = [0, 0, -tamanhoPadrao, -tamanhoPadrao];
pontos.chassis.x = [-tamanhoRobo / 2, tamanhoRobo / 2, tamanhoRobo / 2, -tamanhoRobo / 2];
pontos.chassis.y = [tamanhoRobo / 2, tamanhoRobo / 2, -tamanhoRobo / 2, -tamanhoRobo / 2];

% Rotacao dos pontos para levar em conta psi
[pontos.padraoTime.x, pontos.padraoTime.y] =...
    rotate(pontos.padraoTime.x, pontos.padraoTime.y, psi);
[pontos.padraoId.x, pontos.padraoId.y] =...
    rotate(pontos.padraoId.x, pontos.padraoId.y, psi);
[pontos.chassis.x, pontos.chassis.y] = ...
    rotate(pontos.chassis.x, pontos.chassis.y, psi);

% Translacao dos pontos para levar em conta x e y
pontos.padraoTime.x = pontos.padraoTime.x + x;
pontos.padraoTime.y = pontos.padraoTime.y + y;
pontos.padraoId.x = pontos.padraoId.x + x;
pontos.padraoId.y = pontos.padraoId.y + y;
pontos.chassis.x = pontos.chassis.x + x;
pontos.chassis.y = pontos.chassis.y + y;

end

function [xRotacionado, yRotacionado] = rotate(x, y, psi)
% Rotaciona as coordenadas x e y usando o angulo psi e retorna as 
% coordenadas rotacionadas como xRotacionado e yRotacionado, 
% respectivamente.

xRotacionado = x * cos(psi) - y * sin(psi);
yRotacionado = x * sin(psi) + y * cos(psi);

end