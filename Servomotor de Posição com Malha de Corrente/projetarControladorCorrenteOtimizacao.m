function controlador = projetarControladorCorrenteOtimizacao(requisitos, planta)
% controlador = projetarControladorCorrenteOtimizacao(requisitos, planta)
% projeta o controlador de corrente atraves de otimizacao. A
% struct requisitos eh:
% requisitos.wb: requisito de banda passante.
% requisitos.GM: requisito de margem de ganho.
% requisitos.PM: requisito de margem de fase.
% requisitos.fs: requisito de taxa de amostragem.
% A struct planta contem os parametros da planta e pode ser obtida atraves
% de planta = obterPlantaServoPosicao().
% A saida da funcao eh a struct controlador:
% controlador.K: ganho proporcional do controlador de corrente.
% controlador.alpha: parametro alpha da compensacao lead.
% controlador.Tl: parametro Tl da compensacao lead.
% controlador.T: periodo de amostragem do controlador de corrente.

controlador.T = 1.0 / requisitos.fs;
parametros(1) = 10054;
parametros(2) = 0.3114;
parametros(3) = 4.5077*1e-04;

J = custoControladorCorrente(requisitos, planta, parametros);
newpar = fminsearch(J, parametros);

controlador.K = newpar(1);
controlador.alpha = newpar(2);
controlador.Tl = newpar(3);

end

function J = custoControladorCorrente(requisitos, planta, parametros)
% J = custoControladorCorrente(requisitos, planta, parametros)
% calcula o custo do controlador de corrente J(K, alpha, Tl) para guiar o
% processo de otimizacao. A struct requisitos eh:
% requisitos.wb: requisito de banda passante.
% requisitos.GM: requisito de margem de ganho.
% requisitos.PM: requisito de margem de fase.
% requisitos.fs: requisito de taxa de amostragem.
% A struct planta contem os parametros da planta e pode ser obtida atraves
% de planta = obterPlantaServoPosicao().
% O vetor parametros eh dado por [K; alpha; Tl].

controlador.K = parametros(1);
controlador.alpha = parametros(2);
controlador.Tl = parametros(3);
controlador.T = 1.0 / requisitos.fs;

s = tf('s');
K = controlador.K;
alpha = controlador.alpha;
Tl = controlador.Tl;
T = controlador.T;

G = 1/((planta.L*s+planta.R));
[numAc,denAc] = pade(T/2,2);
Ac = tf(numAc,denAc);
C = (parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1));

Ga = G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc);
Gf = (G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc) )/(1+G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc));

J= @(parametros) (requisitos.wb - bandwidth((G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc) )/(1+G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc))))^2 + (requisitos.PM - retornarFase(G*(parametros(1)/s)*((parametros(3)*s+1)/(parametros(2)*parametros(3)*s+1))*tf(numAc,denAc)))^2;

end

function phase = retornarFase(G)
[~,phase,~,~] = margin(G);

end
