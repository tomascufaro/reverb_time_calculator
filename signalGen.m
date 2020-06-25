function [y,pol] = signalGen(t,A,f,caso,nTerms)

% https://lpsa.swarthmore.edu/Fourier/Series/ExFS.html

syms n 
T = 1/f;
an = zeros(100);
bn = zeros(100);
    switch caso
        case '1'
            y = tren(t,A,f);
            
            a0 = A;
% %             a0(n) = sym((1/T)*int(1,g,0,T/2));
%             an(n) = sym(0);
% %             an(n) = sym((2/T)*int(cos(n*(2*pi/T)*g),g,0,T/2));
%             bn(n) = sym((2/T)*int(sin(n*(2*pi/T)*g),g,0,T/2));
            for n = 1:1:100
                an(n) = (2*A/(n*pi))*((-1)^((n-1)/2));
                bn(n) = (0);
            end
        case '2'
            y = dienteSable(t,A,f);
            
            a0 = 0;
% %             a0(n) = sym((1/T)*int(g,g,0,T));
            for n = 1:1:100
                an(n) = 0;
    % %             an(n) = sym((2/T)*int(g*cos(n*(2*pi/T)*g),g,0,T));
    %             bn(n) = sym((2/T)*int(g*sin(n*(2*pi/T)*g),g,-T/2,T/2));
                bn(n) = (-2*A/(pi*n))*(-1)^n;
            end
            
        case '3'
            y = triang(t,A,f);
            
            a0 = 0;
            for n = 1:100
                an(n) = -4*A*(1-(-1)^n)/(pi*n)^2;
                bn(n) = 0;
            end
            
%             a0(n) = sym((1/T)*int(1,g,0,T/2));
            
%             an(n) = sym((2/T)*int((1-2*g/pi)*cos(n*(2*pi/T)*t),g,0,T/2));
%             bn(n) = sym(0);
%             bn(n) = sym((2/T)*int((1-2*g/pi)*sin(n*(2*pi/T)*t),g,0,T/2));
    end
    
    pol = bestFourier(a0,an,bn,T,nTerms,t,caso);
    pol = double(pol);
    
end

%% POLINOMIO DE FOURIER
function pol = bestFourier(a0,an,bn,T,nTerms,t,caso)

    pol = (a0/2)*ones(1,length(t));

    for k = 1:nTerms
        if caso == '3'
            i = 2*k-1;
        else
            i = k;
        end
        pol = pol + double(an(i))*cos(((2*i*pi)/T)*t) + double(bn(i))*sin(((2*i*pi)/T)*t);
    end

end


%% TREN DE PULSOS
function [trenPulsos] = tren(t,A,f)

    x0 = ones(1,length(t));
    x2 = square(2*pi*f*(t+1/(4*f)));  %debimos desplazar el eje X para
    trenPulsos = A * 0.5 .* (x0+x2);  %plotear en sincronía

end
%%  DIENTES DE SIERRA
function [saw] = dienteSable(t,A,f)

    saw = A * sawtooth(2*pi*f*(t+1/(2*f))); %debimos desplazar el eje X para
                                            %plotear en sincronía
end
%% TRIANGULAR
function [triangulito] = triang(t,A,f)

    triangulito = A * sawtooth(2*pi*f*t,0.5);

end

