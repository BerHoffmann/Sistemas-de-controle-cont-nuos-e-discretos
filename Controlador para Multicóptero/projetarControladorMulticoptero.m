function controlador = projetarControladorMulticoptero(requisitos, planta)
% controlador = projetarControladorMulticoptero(requisitos, planta) projeta
% controladores para todas as malhas do multicoptero. As entradas da funcao
% sao as structs requisitos e planta com os requisitos do sistema e os
% parametros da planta, respectivamente.
% A struct requisitos tem a seguinte estrutura:
% requisitos.x.tr: tempo de subida de 0 a 100% da malha horizontal.
% requisitos.x.Mp = sobressinal da malha horizontal.
% requisitos.z.tr = tempo de subida de 0 a 100% da malha vertical;
% requisitos.z.Mp = sobressinal da malha horizontal.
% requisitos.theta.tr = tempo de subida de 0 a 100% da malha de arfagem.
% requisitos.theta.Mp = sobressinal da malha de arfagem.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com os ganhos de todos os
% controladores do multicoptero:
% controlador.theta.Kp: ganho proporcional do controlador horizontal.
% controlador.theta.Kv: ganho integrativo do controlador horizontal.
% controlador.x.Kp: ganho proporcional do controlador horizontal.
% controlador.x.Ki: ganho integrativo do controlador horizontal.
% controlador.x.Kd: ganho derivativo do controlador horizontal.
% controlador.z.Kp: ganho proporcional do controlador vertical.
% controlador.z.Ki: ganho integrativo do controlador vertical.
% controlador.z.Kd: ganho derivativo do controlador vertical.

controlador.theta = projetarControladorArfagem(requisitos.theta, planta);
controlador.x = projetarControladorHorizontalBusca(requisitos.x, requisitos.theta, planta);
controlador.z = projetarControladorVerticalBusca(requisitos.z, planta);

end