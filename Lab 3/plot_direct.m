function plot_direct(N,vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    figure;
    subplot(2, 1, 1);
    plot(N, vtime_direct, '-o', 'LineWidth', 2);
    xlabel('Rozmiar macierzy');
    ylabel('Czas wyznaczenia rozwiązania');
    title('Zależność czasu od rozmiaru macierzy');
    grid on;
    print -dpng zadanie2.png
end
