function dinamica = obterMalhaHorizontal(controladorX, controladorTheta, planta)
% dinamica = obterMalhaHorizontal(controladorX, controladorTheta, planta)
% obtem a dinamica da malha horizontal. As structs controladorX e 
% controladorTheta possuem a seguinte estrutura:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.
% A struct planta tem os seguintes parametros:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida dinamica eh a dinamica da malha horizontal na forma de funcao de
% transferencia.

s = tf('s');
F = (controladorX.Ki*controladorTheta.Kp*planta.g*controladorTheta.Kv)/((controladorX.Kd*s^2+controladorX.Kp*s+controladorX.Ki)*controladorTheta.Kp*planta.g*controladorTheta.Kv);
dinamica = F * (((controladorX.Kd*s^2+controladorX.Kp*s+controladorX.Ki)*controladorTheta.Kp*planta.g*controladorTheta.Kv)/(planta.J*s^5+s^4*controladorTheta.Kv+s^3*controladorTheta.Kp+controladorTheta.Kp*controladorTheta.Kv*planta.g*(controladorX.Kd*s^2+controladorX.Kp*s+controladorX.Ki)));

end