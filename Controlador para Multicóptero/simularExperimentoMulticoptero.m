function simulacao = simularExperimentoMulticoptero(controlador, planta, experimento)
% simulacao = simularExperimentoMulticoptero(controlador, planta,
% experimento) simula um experimento do multicoptero. As entradas da funcao
% controlador, planta e experimento. As structs controlador e planta contem
% os ganhos do controlador e os parametros da planta, respectivamente. O
% caractere experimento indica qual experimento deve ser executado.
% A struct controlador eh dada por:
% controlador.theta.Kp: ganho proporcional do controlador horizontal.
% controlador.theta.Kv: ganho integrativo do controlador horizontal.
% controlador.x.Kp: ganho proporcional do controlador horizontal.
% controlador.x.Ki: ganho integrativo do controlador horizontal.
% controlador.x.Kd: ganho derivativo do controlador horizontal.
% controlador.z.Kp: ganho proporcional do controlador vertical.
% controlador.z.Ki: ganho integrativo do controlador vertical.
% controlador.z.Kd: ganho derivativo do controlador vertical.
% A struct planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida eh a struct simulacao com as trajetorias geradas pela simulacao.

tf = 10;
xr.signals.dimensions = 1;
zr.signals.dimensions = 1;
dt = 1e-3;

if experimento == 'a'
    xr.time = [0; tf];
    xr.signals.values = [0; 0];
    zr.time = [0; tf];
    zr.signals.values = [1; 1];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, 0);
elseif experimento == 'b'
    xr.time = [0; 1 - dt; 1; tf];
    xr.signals.values = [0; 0; 1; 1];
    zr.time = [0; tf];
    zr.signals.values = [1; 1];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, 0);
elseif experimento == 'c'
    xr.time = [0; 1 - dt; tf];
    xr.signals.values = [0; 0; 4];
    zr.time = [0; tf];
    zr.signals.values = [1; 1];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, 0);
elseif experimento == 'd'
    xr.time = [0; tf];
    xr.signals.values = [0; 0];
    zr.time = [0; tf];
    zr.signals.values = [1; 1];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0.2, 0);
elseif experimento == 'e'
    xr.time = [0; 1 - dt; tf];
    xr.signals.values = [0; 0; 4];
    zr.time = [0; tf];
    zr.signals.values = [1; 1];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, -2);
elseif experimento == 'f'
    tf = 10;
    t = (1+dt:dt:(tf-1))';
    xr.time = [0; 1; t; tf];
    xr.signals.values = [0; 0; cos(3 * 2 * pi * (t - 1) / (tf - 2) + pi / 2); 0];
    zr.time = [0; 1; t; tf];
    zr.signals.values = [2; 2; sin(2 * 2 * pi * (t - 1) / (tf - 2)) + 2; 2];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, 0);
elseif experimento == 'g'
    tf = 20;
    t = (1+dt:dt:(tf-1))';
    xr.time = [0; 1; t; tf];
    xr.signals.values = [0; 0; cos(3 * 2 * pi * (t - 1) / (tf - 2) + pi / 2); 0];
    zr.time = [0; 1; t; tf];
    zr.signals.values = [2; 2; sin(2 * 2 * pi * (t - 1) / (tf - 2)) + 2; 2];
    simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, 0, 0);
end

% Armazenando qual experimento foi executado
simulacao.experimento = experimento;
end
