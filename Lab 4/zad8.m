a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;

[n_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @(N) estimate_execution_time(N));
[n_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @(N) estimate_execution_time(N));
figure;
subplot(2, 1, 1);
plot(xtab_bisection, 'r');
hold on;
plot(xtab_secant, 'g');
title('Przybliżone wartości N');
xlabel('Iteracja');
ylabel('t');
legend('Bisekcja', 'Sieczne');

subplot(2, 1, 2);
semilogy(xdif_bisection, 'r');
hold on;
semilogy(xdif_secant, 'g');
title('Różnica pomiędzy kolejnymi N');
xlabel('Iteracja');
ylabel('Różnica');
legend('Bisekcja', 'Sieczne');

print('zadanie8','-dpng');

function time_delta = estimate_execution_time(N)
    % time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
    % N - liczba parametrów wejściowych
    M = 5000; % [s]

    if N <= 0
        error("error");
    end
    
    time_delta = abs((N^(16/11) + N^((pi^2)/8))/1000) - M;
end

function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego (x0=a)
% b - prawa granica przedziału poszukiwań miejsca zerowego (x1=b)
% max_iterations - maksymalna liczba iteracji działania metody siecznych
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od x2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

iterations = 0;
xtab = [a;b];
xdif = [];
err = 10000;

while (iterations < max_iterations && err > ytolerance)
    xk = xtab(end);
    xk_1 = xtab(end-1);
    xk1 = xk-((fun(xk)*(xk-xk_1))/(fun(xk)-fun(xk_1)));
    xtab=[xtab;xk1];

    iterations = iterations + 1;
    if (iterations > 1)
        xdif = [xdif;abs(xtab(end)-xtab(end-1))];
        err = abs(fun(xk1));
    end
end
xtab=xtab(3:end)
xsolution = xk1;
ysolution = fun(xk1);


end

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

iterations = 0;
xtab = [];
xdif = [];
err = 10000;
while (iterations < max_iterations && err > ytolerance)
    centrum = (a+b)/2;
    xtab = [xtab;centrum];

    if(fun(a)*fun(centrum)<0)
        b = centrum;
    else
        a = centrum;
    end
    iterations = iterations + 1;
    if (iterations > 1)
        xdif = [xdif;abs(xtab(end)-xtab(end-1))];
        err = abs(fun(centrum));
    end
end
xsolution = centrum;
ysolution = fun(centrum);

end

