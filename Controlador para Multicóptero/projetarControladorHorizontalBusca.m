function controlador = projetarControladorHorizontalBusca(requisitosX,...
    requisitosTheta, planta)
% controlador = projetarControladorHorizontalBusca(requisitosX,
% requisitosTheta, planta) projeta o controlador horizontal com um 
% refinamento atraves de busca em grade para um melhor atendimento aos 
% requisitos. As entradas da funcao sao as structs requisitosX, 
% requisitosTheta e planta, que contem os requisitos da malha horizontal,
% os requisitos da malha de arfagem e os parametros da planta, 
% respectivamente. requisitosX e requisitosTheta sao da forma:
% requisitos.tr: tempo de subidade de 0 a 100%.
% requisitos.Mp: sobressinal.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.

% Numero de valores de cada parametro usados na grade
N = 20;

% Gerando os valores na grade
trs = linspace(0.8 * requisitosX.tr, 1.2 * requisitosX.tr, N);
Mps = linspace(0.8 * requisitosX.Mp, 1.2 * requisitosX.Mp, N);

% Iterar sobre a grade de trs e Mps para determinar o par tr e Mp que
% melhor atende aos requisitos

xiT = abs(log(requisitosTheta.Mp) / sqrt(pi^2 + (log(requisitosTheta.Mp))^2 ));
wnT = (pi - acos(xiT)) / (requisitosTheta.tr*sqrt(1-xiT^2));

KvT = 2*xiT*wnT*planta.J;
KpT = wnT^2*planta.J / KvT;

J = +inf;
a = [];
b = [];
    for i = 1:20
        for k = 1:20

            xi = abs(log(Mps(i)) / sqrt(pi^2 + (log(Mps(i)))^2 ));
            wn = (pi - acos(xi)) / (trs(k)*sqrt(1-xi^2));
     
            Kd = 7*xi*wn/planta.g;
            Kp = (10*xi^2*wn^2+ wn^2)/planta.g;
            Ki = 5*xi*wn^3/planta.g;
            
            s = tf('s');

            F = (Ki*KpT*planta.g*KvT)/((Kd*s^2+Kp*s+Ki)*KpT*planta.g*KvT);
            dinamica = F * (((Kd*s^2+Kp*s+Ki)*KpT*planta.g*KvT)/(planta.J*s^5+s^4*KvT+s^3*KpT+KpT*KvT*planta.g*(Kd*s^2+Kp*s+Ki)));
    
            info = stepinfo(dinamica,'RiseTimeLimits',[0,1]);

            tr = getfield(info,"RiseTime");
            mp = getfield(info, "Overshoot");
            mp = mp/100;

            aux = abs((requisitosX.tr - tr))/abs(requisitosX.tr) + (abs(requisitosX.Mp - mp)/abs(requisitosX.Mp));
            if(aux < J)
                J = aux;
                a = i;
                b = k;
            end
        end
    end

    trfinal = trs(b);
    mpfinal = Mps(a);
    
    xi = abs(log(mpfinal) / sqrt(pi^2 + (log(mpfinal))^2 ));
    wn = (pi - acos(xi)) / (trfinal*sqrt(1-xi^2));
    

controlador.Kd = 7*xi*wn/planta.g;
controlador.Kp = (10*xi^2*wn^2+ wn^2)/planta.g;
controlador.Ki = 5*xi*wn^3/planta.g;

end