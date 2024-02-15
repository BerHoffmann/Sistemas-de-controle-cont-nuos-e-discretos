function controlador = projetarControladorPosicaoOtimizacao(requisitos, controladorCorrente, planta)
% controlador = projetarControladorPosicaoAnalitico(requisitos, planta)
% projeta o controlador de posicao atraves de otimizacao. A
% struct requisitos eh:
% requisitos.wb: requisito de banda passante.
% requisitos.GM: requisito de margem de ganho.
% requisitos.PM: requisito de margem de fase.
% requisitos.fs: requisito de taxa de amostragem.
% A struct controladorCorrente eh dada por:
% controlador.K: ganho proporcional do controlador de corrente.
% controlador.alpha: parametro alpha da compensacao lead.
% controlador.Tl: parametro Tl da compensacao lead.
% controlador.T: periodo de amostragem do controlador de corrente.
% A struct planta contem os parametros da planta e pode ser obtida atraves
% de planta = obterPlantaServoPosicao().
% A saida da funcao eh a struct controlador:
% controlador.Kp: ganho proporcional do controlador de posicao.
% controlador.Kd: ganho derivativo do controlador de posicao.
% controlador.a: frequencia de corte do filtro do termo derivativo.
% controlador.T: periodo de amostragem do controlador de posicao.

controlador = projetarControladorPosicaoAnalitico(requisitos, planta);
parametros(1) = controlador.Kp;
parametros(2) = controlador.Kd;

J = custoControladorPosicao(requisitos,controladorCorrente,planta,parametros);
newpar = fminsearch(J, parametros);

controlador.Kp = newpar(1);
controlador.Kd = newpar(2);

end

function J = custoControladorPosicao(requisitos, controladorCorrente, planta, parametros)

controladorPosicao.Kp = parametros(1);
controladorPosicao.Kd = parametros(2);
controladorPosicao.a =  requisitos.wb * 10.0;
controladorPosicao.T = 1.0 / requisitos.fs;

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

Cc = K*(Tl*s+1)/(alpha*Tl*s+1)*(1/s);

%Ga = ((parametros(1) + parametros(2)*s*(a/(s+a)))*(numAp)/(denAp)*(Cc)*(numAc)/(denAc)*(N*eta*Kt)*Gp) / (1/Gc + N^2*Kt^2*eta*Gp+Cc*(numAc)/(denAc));
%Gf = (Cc*numAc*(parametros(1) + parametros(2)*s*(a/(s+a)))*numAp*N*eta*Kt*Gp)/(s*((denAc*denAp)/(Gc) + N^2*Kt^2*eta*Gp*denAp*denAc +Cc*numAc*denAp) + Cc*numAc*(parametros(1) + parametros(2)*s*(a/(s+a)))*numAp*N*eta*Kt*Gp);
Ga = ((parametros(1) + parametros(2)*s*(a/(s+a)))*(numAp)/(denAp)*(Cc)*(numAc)/(denAc)*(N*eta*Kt)) / (N^2*Kt^2*eta*s + s*(numAc)/(denAc)*(Jeq*s+Beq) + s*(Jeq*s+Beq)*(L*s+R));

J = @(parametros) ( (requisitos.wb - bandwidth(minreal(feedback(((parametros(1) + parametros(2)*s*(a/(s+a)))*(numAp)/(denAp)*(Cc)*(numAc)/(denAc)*(N*eta*Kt)) / (N^2*Kt^2*eta*s + s*(numAc)/(denAc)*(Jeq*s+Beq)*Cc + s*(Jeq*s+Beq)*(L*s+R)),1))))^2 + (requisitos.PM - retornarFase(     minreal(((parametros(1) + parametros(2)*s*(a/(s+a)))*(numAp)/(denAp)*(Cc)*(numAc)/(denAc)*(N*eta*Kt)) / (s*N^2*Kt^2*eta + s*(numAc)/(denAc)*Cc*(Jeq*s+Beq) + s*(Jeq*s+Beq)*(L*s+R)))  ) )^2 ) ;

end

function phase = retornarFase(G)
[~,phase,~,~] = margin(G);

end