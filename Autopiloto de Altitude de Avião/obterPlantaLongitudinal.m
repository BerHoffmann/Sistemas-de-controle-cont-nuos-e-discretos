function planta = obterPlantaLongitudinal()
% planta = obterPlantaLongitudinal() obtem a planta longitudinal na forma
% de espaco de estados. A planta eh um objeto gerado pela funcao ss do
% MATLAB.

A = [-0.00643, 0.0263, 0, -32.2, 0;
     -0.0941, -0.624, 820, 0, 0;
     -0.000222, -0.00153, -0.668, 0, 0;
     0, 0, 1, 0, 0;
     0, -1, 0, 830, 0];

B = [0; -32.7; -2.08; 0; 0];

C = [ 0 0 1 0 0;
      0 0 0 1 0;
      0 0 0 0 1];

D = [0; 0; 0];

planta = ss(A, B, C, D);
end