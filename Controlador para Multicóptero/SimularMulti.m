function SimularMulti

requisitos = obterRequisitos();
planta = obterPlantaMulticoptero();
controlador = projetarControladorMulticoptero(requisitos, planta);
simulacao = simularExperimentoMulticoptero(controlador, planta, 'a');
tracarGraficosSimulacao(simulacao);
end