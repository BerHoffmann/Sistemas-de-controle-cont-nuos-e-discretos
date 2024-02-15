function polos = obterPolosPI(controlador, planta)
% polos = obterPolosPI(controlador, planta)
% Obtem os polos da funcao de transferencia de malha fechada do
% servomotor de velocidade usando controlador PI com pre-filtro. 
% As entradas da funcao as structs controlador, que contem os parametros
% do controlador, e planta, que contem os parametros da planta. 
% O controlador eh dado por:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% A planta eh dada por:
% planta.L: indutancia.
% planta.R: resistencia.
% planta.Jeq: inercia equivalente vista pelo motor.
% planta.Beq: coeficiente de atrito viscoso equivalente visto pelo motor.
% planta.Kt: constante de torque.
% A saida da funcao eh um vetor contendo os polos do sistema.

s = tf('s'); % Para facilitar a definicao de GR

% Facilita a escrita de GR
Kp = controlador.Kp;
Ki = controlador.Ki;
L = planta.L;
R = planta.R;
Jeq = planta.Jeq;
Beq = planta.Beq;
Kt = planta.Kt;

GR = controlador.Ki*planta.Kt / (s^3*planta.L*planta.Jeq+s^2*(planta.L*planta.Beq ...
    + planta.R*planta.Jeq)+s*(planta.R*planta.Beq+planta.Kt^2+planta.Kt*controlador.Kp)+planta.Kt*controlador.Ki); % Alterar para expressao correta de GR
polos = pole(GR);

end
