function controlador = projetarControladorArfagem(requisitos, planta)
% controlador = projetarControladorArfagem(requisitos, planta) projeta o
% controlador de arfagem. As entradas da funcao sao as structs requisitos e
% planta, que contem os requisitos e os parametros da planta,
% respectivamente. Os requisitos sao:
% requisitos.tr: tempo de subidade de 0 a 100%.
% requisitos.Mp: sobressinal.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ga
% nho proporcional.
% controlador.Kv: ganho de velocidade.

xi = abs(log(requisitos.Mp) / sqrt(pi^2 + (log(requisitos.Mp))^2 ));
wn = (pi - acos(xi)) / (requisitos.tr*sqrt(1-xi^2));

controlador.Kv = 2*xi*wn*planta.J;
controlador.Kp = wn^2*planta.J / controlador.Kv;

end