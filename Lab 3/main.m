function main()
    N = 1000:1000:8000;
    time_Jacobi = zeros(1,length(N));
    time_Gauss_Seidel = zeros(1,length(N));
    iterations_Jacobi = zeros(1,length(N));
    iterations_Gauss_Seidel = zeros(1,length(N));
    
    for i = 1:length(N)
        [~,~,~,~,~,~,time_Jacobi(i),iterations_Jacobi(i),~] = solve_Jacobi(N(i));
        [~,~,~,~,~,~,time_Gauss_Seidel(i),iterations_Gauss_Seidel(i),~] = solve_Gauss_Seidel(N(i));
    end
    plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel);
end


function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla

    subplot(2,1,1);
    plot(N,time_Jacobi);
    hold on;
    plot(N,time_Gauss_Seidel);
    xlabel('Rozmiar macierzy');
    ylabel('Czas wyznaczenia rozwiązania');
    title('Czas wyznaczenia rozwiązania w zależności od rozmiaru macierzy');
    legend('Jacobi','Gauss-Seidel', 'Location', 'eastoutside');
    hold off;
    subplot(2,1,2);
    bar(N,iterations_Jacobi);
    hold on;
    bar(N,iterations_Gauss_Seidel);
    xlabel('Rozmiar macierzy');
    ylabel('Liczba iteracji');
    title('Liczba iteracji w zależności od rozmiaru macierzy');
    legend('Jacobi','Gauss-Seidel', 'Location', 'eastoutside');
    hold off;
    print -dpng zadanie5.png;

end