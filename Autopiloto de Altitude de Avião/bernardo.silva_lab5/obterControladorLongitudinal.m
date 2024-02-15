function controlador = obterControladorLongitudinal()
% controlador = obterControladorLongitudinal() retorna uma struct com os
% parametros do controlador longitudinal:
% controlador.Kph: ganho proporcional do controlador de altitude.
% controlador.Kph: ganho derivativo do controlador de altitude.
% controlador.Kph: ganho proporcional do controlador de altitude.
% controlador.Kdh: ganho proporcional do controlador de altitude.
% controlador.a: parametro a do filtro usado no termo PD.

controlador.Kph = 0.00096997;
controlador.Kdh = 0.00096997 * 0.52;
controlador.Ktheta = 7.0278;
controlador.Kq = 1.968;
controlador.a = 10;

end