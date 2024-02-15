function dinamica = obterMalhaArfagem(controlador, planta)
% dinamica = obterMalhaArfagem(controlador, planta) obtem a dinamica da 
% malha de arfagem. As struct controlador tem a seguinte estrutura:
% controlador.Kp: ganho proporcional.
% controlador.Kv: ganho de velocidade.
% A struct planta tem os seguintes parametros:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida dinamica eh a dinamica da malha horizontal na forma de funcao de
% transferencia.

s = tf('s');
dinamica = (controlador.Kp * controlador.Kv)/(planta.J*s^2+s*controlador.Kv+controlador.Kp*controlador.Kv);

end