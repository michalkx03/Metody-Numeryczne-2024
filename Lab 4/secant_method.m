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
