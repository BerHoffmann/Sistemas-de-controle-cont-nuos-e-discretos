function simulacao = simularMulticoptero(controlador, planta, tf, xr, zr,...
    carga, ventoX)
% simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, carga, 
% ventoX) simula um voo do multicoptero.
% A entrada controlador eh dada por:
% controlador.theta.Kp: ganho proporcional do controlador horizontal.
% controlador.theta.Kv: ganho integrativo do controlador horizontal.
% controlador.x.Kp: ganho proporcional do controlador horizontal.
% controlador.x.Ki: ganho integrativo do controlador horizontal.
% controlador.x.Kd: ganho derivativo do controlador horizontal.
% controlador.z.Kp: ganho proporcional do controlador vertical.
% controlador.z.Ki: ganho integrativo do controlador vertical.
% controlador.z.Kd: ganho derivativo do controlador vertical.
% A entrada planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% tf eh o tempo final da simulacao.
% xr eh a referencia de posicao x (usada num bloco From Workspace).
% zr eh a referencia de posicao z (usada num From Workspace).
% carga  eh uma carga adicionado ao multicoptero em t = 3 s.
% A saida eh a struct simulacao com as trajetorias geradas pela simulacao.
% A saida eh a struct simulacao com as trajetorias geradas pela simulacao.

controlador.m = planta.m;
controlador.g = planta.g;

% Configurando as variaveis usadas no Simulink
assignin('base', 'xr', xr);
assignin('base', 'zr', zr);
assignin('base', 'x0', 0);
assignin('base', 'z0', 0);
assignin('base', 'theta0', 0);
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
assignin('base', 'carga', carga);
assignin('base', 'ventoX', ventoX);

% Carregando o Simulink
load_system('multicoptero');

% Configurando o tempo final de simulacao
set_param('multicoptero', 'StopTime', sprintf('%g', tf));

% Rodando a simulacao
simulacao = sim('multicoptero');

end
