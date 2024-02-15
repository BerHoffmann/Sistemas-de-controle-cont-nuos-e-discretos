planta.R = 1.2;
planta.L = 0.56 * 10^-3;
planta.Kt = 25.5 * 10^-3;
planta.Jm = 92.5 * 10^-3 * (10^-2)^2;
planta.Jw = 16396.23 * 10^-3 * (10^-3)^2;
planta.Jl = planta.Jw;
planta.N = 3;

K = 10054;
alpha = 0.3114;
T = 4.5077*1e-4;


s = tf('s');
G = 1/(s*(planta.L*s+planta.R));
Ga = K*((T*s+1)/(alpha*T+1))*G;
margin(Ga);