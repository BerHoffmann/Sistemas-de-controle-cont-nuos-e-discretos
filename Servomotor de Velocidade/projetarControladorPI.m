function controlador = projetarControladorPI(planta, requisitos)
% controlador = projetarControladorPI(planta, requisitos) projeta
% um controlador PI com pre-filtro para um servomotor de velocidade. O 
% projeto assume como aproximacao que a dinamica da corrente pode ser
% negligenciada. As entradas da funcao as structs planta, que contem os
% parametros da planta, e requisitos, que contem os requisitos. A planta
% eh dada por:
% planta.R: resistencia.
% planta.Jeq: inercia equivalente vista pelo motor.
% planta.Beq: coeficiente de atrito viscoso equivalente visto pelo motor.
% planta.Kt: constante de torque.
% Os requisitos sao:
% requisitos.tr: tempo de subida de 0 a 100%.
% requisitos.Mp: sobressinal.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.

xi = log(requisitos.Mp) / sqrt(pi^2 + (log(requisitos.Mp))^2 );
wn = pi - acos(xi) / (requisitos.tr*sqrt(1-xi^2));

controlador.Kp = (2*xi*planta.R*planta.Jeq*wn - planta.R*planta.Beq - planta.Kt^2)/planta.Kt;
controlador.Ki = wn^2*planta.R*planta.Jeq / planta.Kt;

end
