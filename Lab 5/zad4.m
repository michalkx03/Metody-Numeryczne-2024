function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie4()
    close all;
    P = 20; % liczba unikalnych współrzędnych x punktów dla których będzie obliczana interpolacja
    R = 20; % liczba unikalnych współrzędnych y punktów dla których będzie obliczana interpolacja
    M = 5; % liczba węzłów interpolacji wzdłuż osi X (stopień wielomianu zmiennej x: M-1)
    N = 5; % liczba węzłów interpolacji wzdłuż osi Y (stopień wielomianu zmiennej y: N-1)
    
    % Generowanie węzłów interpolacji na płaszczyźnie
    x_coarse = linspace(0, 1, M);
    y_coarse = linspace(0, 1, N);
    [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
    
    % Wyznaczenie wartości funkcji oryginalnej w węzłach
    F_coarse = cos(pi*X_coarse); % zadanie A: zmień definicję funkcji interpolowanej
    
    MN = M*N;
    xvec_coarse = reshape(X_coarse, MN, 1);
    yvec_coarse = reshape(Y_coarse, MN, 1);
    fvec_coarse = reshape(F_coarse, MN, 1);
    
    % Macierz Vandermonde'a dla interpolacji 2d
    V = zeros(M*N, M*N);
    for i = 0:(M-1)
        for j = 0:(N-1)
            V(:, i*N + j + 1) = xvec_coarse.^i .* yvec_coarse.^j;
        end
    end
    
    % Współczynniki wielomianu interpolacyjnego
    coeffs = V \ fvec_coarse;
    
    % Obliczanie wartości funkcji interpolującej na gęstszej siatce
    x_fine = linspace(0, 1, P);
    y_fine = linspace(0, 1, R);
    [X_fine, Y_fine] = meshgrid(x_fine, y_fine);
    
    F_fine = zeros(size(X_fine));
    % zadanie B: zdefiniuj obliczenia wartości wielomianu interpolującego. Rezultat obliczeń zapisz w zmiennej F_fine.
    for i = 1:numel(x_fine)
        for j = 1:numel(y_fine)
            x_val = x_fine(i);
            y_val = y_fine(j);
            vandermonde_vec = zeros(1, MN);
            for k = 0:(M-1)
                for l = 0:(N-1)
                    vandermonde_vec(k*N + l + 1) = x_val^k * y_val^l;
                end
            end
            F_fine(j,i) = vandermonde_vec * coeffs;
        end
    end
    figure;

    subplot(2,1,1);
    surf(X_coarse, Y_coarse, F_coarse);
    title('Funkcja oryginalna w węzłach interpolacji');
    xlabel('x');
    ylabel('y');
    zlabel('F(x,y)');

    subplot(2,1,2);
    surf(X_fine, Y_fine, F_fine);
    title('Funkcja interpolacyjna');
    xlabel('x');
    ylabel('y');
    zlabel('F(x,y)');
    
    saveas(gcf, 'zadanie4.png');
end