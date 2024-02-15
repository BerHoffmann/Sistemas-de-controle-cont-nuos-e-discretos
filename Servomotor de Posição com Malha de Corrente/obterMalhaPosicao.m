function [Ga, Gf] = obterMalhaPosicao(controladorPosicao, controladorCorrente, planta)
% [Ga, Gf] = obterMalhaPosicao(controladorPosicao, controladorCorrente,
% planta) obtem as malhas aberta Ga e fechada Gf do servomotor de posicao.
% A struct controladorPosicao eh dada por:
% controladorPosicao.Kp: ganho proporcional do controlador de posicao.
% controladorPosicao.Kd: ganho derivativo do controlador de posicao.
% controladorPosicao.a: frequencia de corte do filtro do termo derivativo.
% controladorPosicao.T: periodo de amostragem do controlador de posicao.
% A struct controladorCorrente eh dada por:
% controlador.K: ganho proporcional do controlador de corrente.
% controlador.alpha: parametro alpha da compensacao lead.
% controlador.Tl: parametro Tl da compensacao lead.
% controlador.T: tempo de amostragem do controlador de corrente.
% A struct planta contem os parametros da planta e pode ser obtida atraves
% de planta = obterPlantaServoPosicao().

s = tf('s');

Kp = controladorPosicao.Kp;
Kd = controladorPosicao.Kd;
a = controladorPosicao.a;
Tp = controladorPosicao.T;

K = controladorCorrente.K;
alpha = controladorCorrente.alpha;
Tl = controladorCorrente.Tl;
Tc = controladorCorrente.T;

Kt = planta.Kt;
Jeq = planta.Jeq;
Beq = planta.Beq;
L = planta.L;
R = planta.R;
N = planta.N;
eta = planta.eta;

[numAc,denAc] = pade(Tc/2,2);
[numAp,denAp] = pade(Tp/2,2);

numAc = tf(numAc,1);
numAp = tf(numAp,1);
denAc = tf(denAc,1);
denAp = tf(denAp,1);

Gc = 1/(L*s+R);
Cc = K*(Tl*s+1)/(alpha*Tl*s+1)*(1/s);

Gp = 1/(Jeq*s+Beq);
Cp = Kp + Kd*s*(a/(s+a));

Ga = ( Cp*(numAp)/(denAp)*(Cc)*(numAc)/(denAc)*(N*eta*Kt)) / (N^2*Kt^2*eta*s + s*Cc*(numAc)/(denAc)*(Jeq*s+Beq) + s*(Jeq*s+Beq)*(L*s+R));
%Gf = (Cc*numAc*Cp*numAp*N*eta*Kt*Gp)/(s*((denAc*denAp)/(Gc) + N^2*Kt^2*eta*Gp*denAp*denAc +Cc*numAc*denAp) + Cc*numAc*Cp*numAp*N*eta*Kt*Gp);
Ga = minreal(Ga);
Gf = minreal(feedback(Ga,1));





end