function precision = calculaPrecision(salidasRNA, salidasDeseadas)

%
% function precision = calculaPrecision(salidasRNA, salidasDeseadas)
%


numSalidas = size(salidasDeseadas,1);

if (numSalidas>2),
    salidasRNAClases = (salidasRNA==repmat(max(salidasRNA),3,1));
    numErrores = sum(sum(salidasRNAClases~=salidasDeseadas))/2;
else
    salidasRNAClases = (salidasRNA>=0.5);
    numErrores = sum(sum(abs(salidasRNAClases-salidasDeseadas)));
end;

numPatrones = size(salidasDeseadas,2);
precision = 100*(numPatrones-numErrores)/numPatrones;
