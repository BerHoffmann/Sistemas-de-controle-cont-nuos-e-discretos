function planta = obterPlantaMulticoptero()
% planta = obterPlantaMulticoptero() obtem os parametros da planta do 
% multicoptero no seguinte formato:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.

planta.m = 0.5;
planta.J = 0.04;
planta.l = 0.2;
planta.g = 9.81;

end