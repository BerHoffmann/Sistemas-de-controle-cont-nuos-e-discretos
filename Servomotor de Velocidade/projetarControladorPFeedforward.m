function controlador = projetarControladorPFeedforward(planta, requisitos)
% controlador = projetarControladorFeedforward(planta, requisitos) projeta
% um controlador P + feedforward para um servomotor de velocidade. O 
% projeto assume como aproximacao que a dinamica da corrente pode ser
% negligenciada. As entradas da funcao as structs planta, que contem os
% parametros da planta, e requisitos, que contem os requisitos. A planta
% eh dada por:
% planta.R: resistencia.
% planta.Jeq: inercia equivalente vista pelo motor.
% planta.Beq: coeficiente de atrito viscoso equivalente visto pelo motor.
% planta.Kt: constante de torque.
% Os requisitos sao:
% requisitos.tau: constante de tempo desejada.
% Alem disso, assume-se erro nulo em regime para entrada degrau como
% requisito.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Kf: ganho de feedforward.

controlador.Kp = ((planta.R * (planta.Jeq /requisitos.tau) -(planta.Kt)^2 - planta.R * planta.Beq) / planta.Kt);

controlador.Kf = (planta.Beq * planta.R + planta.Kt^2)/ planta.Kt;


end
