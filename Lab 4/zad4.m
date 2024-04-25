a=1;
b=50;
ytolerance = 1e-12;
max_iterations = 100;
omega = 75;

[omega_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @(omega) impedance_magnitude(omega));
[omega_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @(omega) impedance_magnitude(omega));

figure;
subplot(2, 1, 1);
plot(xtab_bisection, 'r');
hold on;
plot(xtab_secant, 'g');
title('Przybliżone wartości');
xlabel('Iteracja');
ylabel('Omega');
legend('Bisekcja', 'Sieczne');

subplot(2, 1, 2);
semilogy(xdif_bisection, 'r');
hold on;
semilogy(xdif_secant, 'g');
title('Różnica pomiędzy kolejnymi omega');
xlabel('Iteracja');
ylabel('Różnica');
legend('Bisekcja', 'Sieczne');

print('zadanie4','-dpng');

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

function impedance_delta = impedance_magnitude(omega)
if(omega<=0)
    error("error");
end
R = 525;
C = 7*(10^-5);
L = 3;
M = 75; % docelowa wartość modułu impedancji


Z = abs(1/sqrt(1/(R^2) + (omega * C - 1/(omega * L)) ^ 2));


impedance_delta = Z - M;

end

