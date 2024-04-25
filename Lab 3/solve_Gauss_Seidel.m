function [A,b,M,bm,x,err_norms,time,iterations,index_number] = solve_Gauss_Seidel(A,b)
% A - macierz rzadka z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje M jako M_{GS}
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje bm jako b_{mGS}
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu residualnego wyznaczona dla rozwiązania x; err_norm = norm(A*x-b);
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Gaussa-Seidla
% index_number - Twój numer indeksu
    index_number = 193387;
    L1 = mod(index_number,10);
    D = diag(diag(A));
    L = tril(A,-1);
    U = triu(A,1);
    N = length(A);
    x = ones(N,1);

    M = -(D+L)\U;
    bm = (D+L)\b;
    err_norms = [];
    tic;
    err_norm = norm(A*x-b);
    for iterations=1: 1000
        if(norm(A*x-b)<1e-12)
            break;
        end
        x = M*x + bm;
        err_norm = norm(A*x-b);
        err_norms = [err_norms, err_norm];
    end
    time = toc;

end
