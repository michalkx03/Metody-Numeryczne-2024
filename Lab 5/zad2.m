function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    % nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
    % V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
    % V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
    % interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
    %       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    x_coarse = linspace(-1, 1, N);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N);
    V2 = vandermonde_matrix(length(nodes_Chebyshev), nodes_Chebyshev);

    original_Runge = 1 ./ (1 + 25 * x_fine.^2);

    y_coarse = 1 ./ (1 + 25 * x_coarse.^2)';
    c_runge = V \ y_coarse;
    interpolated_Runge = polyval(flipud(c_runge), x_fine);

    y_coarse_Chebyshev = 1 ./ (1 + 25 * nodes_Chebyshev.^2)';
    c_runge_Chebyshev = V2 \ y_coarse_Chebyshev;
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine);

    figure;

    subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Funkcja Runge');
    hold on;
    plot(x_coarse, y_coarse, 'o', 'DisplayName', 'Węzły interpolacji');
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolacja');
    hold off;
    legend('show');
    title('Interpolacja dla równomiernych węzłów interpolacji');
    xlabel('x');
    ylabel('f(x)');
    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Funkcja Runge');
    hold on;
    plot(nodes_Chebyshev, y_coarse_Chebyshev, 'o', 'DisplayName', 'Węzły interpolacji');
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolacja');
    hold off;
    legend('show');
    title('Interpolacja dla węzłów interpolacji Czebyszewa');
    xlabel('x');
    ylabel('f(x)');

    saveas(gcf, 'zadanie2.png');
end

function nodes = get_Chebyshev_nodes(N)
    nodes = cos(((0:N-1)*pi)/(N-1));
end

function V = vandermonde_matrix(N, x_coarse)
    if nargin < 2
        x_coarse = linspace(-1,1,N);
    end
    V = zeros(N);

    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end
