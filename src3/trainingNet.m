clear all
close all

load 'wally_dataset';

%% training the net
hiddenLayers = 4;
net = newpr(inputs,outputs,hiddenLayers);

net.trainParam(1).max_fail = 20;

[trainedNet, tr] = train(net,inputs,outputs);

save('wally_net','trainedNet');
