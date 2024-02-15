function requisitos = obterRequisitos()
% Obtem os requisitos usados no projeto do multicoptero no seguinte
% formato:
% requisitos.x.tr: tempo de subida de 0 a 100% da malha horizontal.
% requisitos.x.Mp = sobressinal da malha horizontal.
% requisitos.z.tr = tempo de subida de 0 a 100% da malha vertical;
% requisitos.z.Mp = sobressinal da malha horizontal.
% requisitos.theta.tr = tempo de subida de 0 a 100% da malha de arfagem.
% requisitos.theta.Mp = sobressinal da malha de arfagem.

requisitos.x.tr = 1.0;
requisitos.x.Mp = 0.1;
requisitos.z.tr = 1.0;
requisitos.z.Mp = 0.1;
requisitos.theta.tr = 0.1;
requisitos.theta.Mp = 0.05;

end