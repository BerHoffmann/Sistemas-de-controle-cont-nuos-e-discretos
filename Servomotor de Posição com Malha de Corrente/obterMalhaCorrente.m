function [Ga, Gf] = obterMalhaCorrente(controlador, planta)
% [Ga, Gf] = obterMalhaCorrente(controlador, planta) obtem as funcoes de 
% transferencia de malha aberta Ga e fechada Gf da malha de corrente.
% A struct controlador eh dada por:
% controlador.K: ganho proporcional do controlador de corrente.
% controlador.alpha: parametro alpha da compensacao lead.
% controlador.Tl: parametro Tl da compensacao lead.
% controlador.T: periodo de amostragem do controlador de corrente.
% A struct planta contem os parametros da planta e pode ser obtida atraves
% de planta = obterPlantaServoPosicao().
s = tf('s');

K = controlador.K;
alpha = controlador.alpha;
Tl = controlador.Tl;
T = controlador.T;

G = 1/((planta.L*s+planta.R));
[numAc,denAc] = pade(T/2,2);
Ac = tf(numAc,denAc);
C = (K/s)*((Tl*s+1)/(alpha*Tl*s+1));

Ga = G*(C*Ac);
Gf = G*C*Ac / (1+G*Ac*C);
end
