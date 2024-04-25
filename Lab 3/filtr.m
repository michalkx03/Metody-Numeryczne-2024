function main()
    load('filtr_dielektryczny.mat');
    [~,~,~,~,~,err_norms_J,time_J,~,~] = solve_Jacobi(A,b);
    [~,~,~,~,~,err_norms_G,time_G,~,~] = solve_Gauss_Seidel(A,b);
    [~,~,~,err_norm_d,~] = solve_direct(A,b);

    figure;
    plot(1:length(err_norms_G), err_norms_G, 'b');
    title('Norma błędu residualnego w zależności od liczby iteracji dla Gauss-Seidela');
    xlabel('Liczba iteracji');
    ylabel('Norma błędu residualnego');
    legend('Gauss-Seidel');
    hold off;
    print -dpng zadanie6_gauss.png

    figure;
    semilogy(1:length(err_norms_J), err_norms_J, 'r');
    title('Norma błędu residualnego w zależności od liczby iteracji dla Jacobiego');
    xlabel('Liczba iteracji');
    ylabel('Norma błędu residualnego');
    legend('Jacobi');
    hold off;
    print -dpng zadanie6_jacobi.png
end
