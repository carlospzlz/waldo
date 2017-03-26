clear all
close all

load wally_dataset
load wally_net

%% Finding the best topology

topologias{1} = 2;
topologias{2} = 3;
topologias{3} = 8;
topologias{4} = 15;
topologias{5} = 25;
topologias{6} = [2 2];
topologias{6} = [8 5];
topologias{7} = [20 5];
topologias{8} = [20 12];

numIteraciones = 50;

for top=1:length(topologias),
    
    topologia = topologias{top};
    errorEntrenamiento = [];
    errorValidacion = [];
    errorTest = [];
    for i=1:numIteraciones,
        rna = newpr(inputs, outputs, topologia);
        rna.trainParam.showWindow = false;
        [rnaEntrenada, tr] = train(rna, inputs, outputs);
        precisionEntrenamiento(i) = calculaPrecision(sim(rnaEntrenada, inputs(:,tr.trainInd)), outputs(:,tr.trainInd));
        precisionValidacion(i)    = calculaPrecision(sim(rnaEntrenada, inputs(:,tr.valInd)),   outputs(:,tr.valInd));
        precisionTest(i)          = calculaPrecision(sim(rnaEntrenada, inputs(:,tr.testInd)),  outputs(:,tr.testInd));
    end;

    disp('------------------------------------------------------------------------------');
    disp(sprintf('Numero de iteraciones: %d',numIteraciones));
    disp('Topologia:');
    disp(topologia);
    disp(sprintf('  Entrenamiento: Precision: %f %% - Desviacion tipica: %f',mean(precisionEntrenamiento),std(precisionEntrenamiento)));
    disp(sprintf('  Validacion:    Precision: %f %% - Desviacion tipica: %f',mean(precisionValidacion),std(precisionValidacion)));
    disp(sprintf('  Test:          Precision: %f %% - Desviacion tipica: %f\n',mean(precisionTest),std(precisionTest)));

end;