function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    % Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
    % V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
    % interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
    %       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
    % interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
    %       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = 1 ./ (1 + 25 * x_fine.^2); % Funkcja Runge
    original_sine = sin(2 * pi * x_fine); % Funkcja sinus

    subplot(2,1,1);
    plot(x_fine, original_Runge,'DisplayName', sprintf('Original Runge'));
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i)); % Macierz Vandermonde
        x_coarse = linspace(-1, 1, N(i)); % Węzły interpolacji
        y_coarse_Runge = 1 ./ (1 + 25 * x_coarse.^2)'; % Wartości funkcji Runge w węzłach interpolacji
        c_runge = V{i} \ y_coarse_Runge; % Współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % Interpolacja
        plot(x_fine, interpolated_Runge{i}, 'DisplayName', sprintf('N = %d', N(i)));
    end
    hold off;
    title('Interpolacja funkcji Runge');
    xlabel('x');
    ylabel('f(x)');
    legend('show');
    subplot(2,1,2);
    plot(x_fine, original_sine,'DisplayName', sprintf('Original sine'));
    hold on;
    for i = 1:length(N)
        x_coarse = linspace(-1, 1, N(i));
        y_coarse_sine = sin(2 * pi * x_coarse)';
        c_sine = V{i} \ y_coarse_sine;
        interpolated_sine{i} = polyval(flipud(c_sine), x_fine);
        plot(x_fine, interpolated_sine{i}, 'DisplayName', sprintf('N = %d', N(i)));
    end
    hold off;
    title('Interpolacja funkcji sinus');
    xlabel('x');
    ylabel('f(x)');
    legend('show');
    saveas(gcf,'zadanie1.png');
end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N);

    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end
