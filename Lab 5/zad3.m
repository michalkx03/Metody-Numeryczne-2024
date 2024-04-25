function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
    % Zwracane są trzy wektory wierszowe:
    % matrix_condition_numbers - współczynniki uwarunkowania badanych macierzy Vandermonde
    % max_coefficients_difference_1 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera wartości funkcji liniowej
    % max_coefficients_difference_2 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera zaburzone wartości funkcji liniowej
    
    N = 5:40;
    
    %% chart 1
    matrix_condition_numbers = zeros(1, length(N));
     for i = 1:length(N)
            ni = N(i);
            V = vandermonde_matrix(ni);
            matrix_condition_numbers(i) = cond(V);
     end
    
    %% chart 2
    max_coefficients_difference_1 = zeros(1, length(N));
    a1 = randi([20,30]);
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        
        % Niech wektor b zawiera wartości funkcji liniowej
        b = linspace(0,a1,ni)';
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
        
        % Wyznacznie współczynników wielomianu interpolującego
        calculated_coefficients = V \ b;
    
        max_coefficients_difference_1(i) = max(abs(calculated_coefficients-reference_coefficients));
    end
    
    %% chart 3
    max_coefficients_difference_2 = zeros(1, length(N));
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        
        % Niech wektor b zawiera wartości funkcji liniowej nieznacznie zaburzone
        b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
        
        % Wyznacznie współczynników wielomianu interpolującego
        calculated_coefficients = V \ b;
        
        max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
    end
    
    figure;

    subplot(3,1,1);
    semilogy(N, matrix_condition_numbers);
    title('Współczynniki uwarunkowania macierzy Vandermonde');
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Współczynnik uwarunkowania');
    grid on;

    subplot(3,1,2);
    plot(N, max_coefficients_difference_1);
    title('Błąd wyznaczenia współczynników dla funkcji liniowej');
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Maksymalna różnica');
    grid on;

    subplot(3,1,3);
    plot(N, max_coefficients_difference_2);
    title('Błąd wyznaczenia współczynników dla zaburzonej funkcji liniowej');
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Maksymalna różnica');
    grid on;

    saveas(gcf, 'zadanie3.png');

end


function V = vandermonde_matrix(N)
    x_coarse = linspace(0,1,N);
    V = zeros(N);

    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end