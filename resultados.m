function [ECM, porcentajeGibbs] = resultados(Fourier,Signal)
% Realiza los calculos de porcentaje de gibbs y de ECM. 
% Las salidas son del tipo STRING
%
%Entrdas: {Fourier} polinomio de Fourier
%         {Signal} señal a partir de signalGen

        ECM = immse(Signal,Fourier);
        

        porcentajeGibbs = (2*abs(max(Fourier) - max(Signal))/(max(Signal) - min(Signal))*100);
        %porcentajeGibbs = [num2str(porcentajeGibbs), ' %'];
    
end
 

