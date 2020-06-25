function [n, ecm, y_fit, y] = mse_criterion(t, f, A, valor, caso)
    start_n = [10, 20, 30, 40, 50, 60 ,70];
    [ecm, y, y_fit] = fit(t, f, A, 100, caso);
    k = length(start_n);
    if valor < ecm
        n = 100;
    else      
        while ecm < valor
            n = start_n(k);
            [ecm, ~, ~]= fit(t, f, A, n, caso);
            k = k - 1;
            disp(n)
            disp(ecm)
        end 
        while ecm > valor
            n = n + 1;
            [ecm, ~, ~] = fit(t, f, A, n, caso);
            disp(n)
            disp(ecm)
        end 
    n = n - 1;
    [ecm, y, y_fit] = fit(t, f, A, n, caso);
    end
end 
%% Fit function
function [ECM, y, pol] =fit(t, f, A, n, caso)
    [y, pol] = signalGen(t, A, f, caso,n);
    ECM = immse(real(pol),y) ;
end
