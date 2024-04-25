a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;
t = 75;

[time_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @(t) rocket_velocity(t));
[time_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @(t) rocket_velocity(t));

figure;
subplot(2, 1, 1);
plot(xtab_bisection, 'r');
hold on;
plot(xtab_secant, 'g');
title('Przybliżone wartości t');
xlabel('Iteracja');
ylabel('t');
legend('Bisekcja', 'Sieczne');

subplot(2, 1, 2);
semilogy(xdif_bisection, 'r');
hold on;
semilogy(xdif_secant, 'g');
title('Różnica pomiędzy kolejnymi t');
xlabel('Iteracja');
ylabel('Różnica');
legend('Bisekcja', 'Sieczne');

print('zadanie6','-dpng');

function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety
M = 750; % [m/s]
g = 1.622;
m0 = 150000;
u = 2000;
q = 2700;


if(t<=0)
    error("error");
end
velocity_delta = abs(u * log(m0 / (m0 - q * t)) - g * t) - M; 

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
