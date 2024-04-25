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
