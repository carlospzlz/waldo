close all;

figure(1);
clf;
plot(inputs(1,find(outputs==1)),inputs(2,find(outputs==1)),'r*');
hold on;
plot(inputs(1,find(outputs==0)),inputs(2,find(outputs==0)),'b.');
 
% eje vertical: pantalones
% eje horizontal: rojos (1) o piel (3)

[X, Y] = meshgrid(0:0.01:1, 0:0.01:1);
[tamX, tamY] = size(X);
X = reshape(X,1,tamX*tamY);
Y = reshape(Y,1,tamX*tamY);
salidas = sim(trainedNet, [X; Y]);
salidas = (salidas>0.5);
figure(2);
clf;
plot(X(1,find(salidas==1)),Y(1,find(salidas==1)),'r*');
hold on;
plot(X(1,find(salidas==0)),Y(1,find(salidas==0)),'b.');


% figure(5);
% clf;
% plot(positivos(1,:),positivos(2,:),'r*');
% hold on;
% plot(negativos(1,:),negativos(2,:),'b.');

 
