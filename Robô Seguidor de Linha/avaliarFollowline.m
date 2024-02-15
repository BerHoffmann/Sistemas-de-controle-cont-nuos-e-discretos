% Avalia modelo de simulacao followline.slx

%% Inicializando variaveis
inicializarFollowline;

%% Testes com robo se movendo para frente
% Valores de yr usados na avaliacao
yrs = -0.5:0.1:0.5;
figure;
hold on;
for j=1:length(yrs)
    yr = yrs(j);
    out = sim('followline.slx');
    plot(out.x.signals.values, out.y.signals.values, 'LineWidth', 2);
end
xlabel('X (m)', 'FontSize', 14);
ylabel('Y (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid minor;
axis equal;
%print -dpng -r400 followline.png % for Word users
% print -depsc2 followline.eps % for LaTeX users

%% Testes com robo se movendo para tras
xr = -1;
figure;
hold on;
for j=1:length(yrs)
    yr = yrs(j);
    out = sim('followline.slx');
    plot(out.x.signals.values, out.y.signals.values, 'LineWidth', 2);
end
xlabel('X (m)', 'FontSize', 14);
ylabel('Y (m)', 'FontSize', 14);
set(gca, 'FontSize', 14);
grid minor;
axis equal;
% print -dpng -r400 followline.png % for Word users
% print -depsc2 followline.eps % for LaTeX users