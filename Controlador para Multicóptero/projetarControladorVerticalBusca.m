function controlador = projetarControladorVerticalBusca(requisitos, planta)
% controlador = projetarControladorVerticalBusca(requisitos, planta) 
% projeta o controlador vertical com um refinamento atraves de busca em 
% grade para um melhor atendimento aos requisitos. As entradas da funcao 
% sao as structs requisitos e planta, que contem os requisitos e os 
% parametros da planta, respectivamente. Os requisitos sao:
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
trs = linspace(0.8 * requisitos.tr, 1.2 * requisitos.tr, N);
Mps = linspace(0.8 * requisitos.Mp, 1.2 * requisitos.Mp, N);

% Iterar sobre a grade de trs e Mps para determinar o par tr e Mp que
% melhor atende aos requisitos

J = +inf;
a = [];
b = [];
    for i = 1:20
        for k = 1:20

            xi = abs(log(Mps(i)) / sqrt(pi^2 + (log(Mps(i)))^2 ));
            wn = (pi - acos(xi)) / (trs(k)*sqrt(1-xi^2));
     
            Kd = 7*xi*wn*planta.m;
            Kp = planta.m*(10*xi^2*wn^2+ wn^2);
            Ki = planta.m*5*xi*wn^3;
            
            s = tf('s');
            dinamica = Ki/ (planta.m*s^3+s^2*Kd+s*Kp+Ki);
    
            info = stepinfo(dinamica,'RiseTimeLimits',[0,1]);

            tr = getfield(info,"RiseTime");
            mp = getfield(info, "Overshoot");
            mp = mp/100;

            aux = abs((requisitos.tr - tr))/abs(requisitos.tr) + (abs(requisitos.Mp - mp)/abs(requisitos.Mp));
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
 
controlador.Kd = 7*xi*wn*planta.m;
controlador.Kp = planta.m*(10*xi^2*wn^2+ wn^2);
controlador.Ki = planta.m*5*xi*wn^3;

end