function main
    n_max = 200;
    a=10;
    r_max=a/2;
    [circles, index_number,circle_areas,rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
    plot_circles(a, circles, index_number);
    plot_circle_areas(circle_areas);
    plot_counts_mean(counts_mean);
end

function [circles,index_number,circle_areas,rand_counts,counts_mean] = generate_circles(a,r_max,n_max)
    index_number = 193387;
    L1 = 7;

    circles = zeros([3,n_max])
    rand_counts = zeros([n_max,1])
    counts_mean = zeros([n_max, 1]);
    for i = 1:n_max
        while true
            collides = 0;
            r = r_max*rand(1);
            x = a*rand(1);
            y = a*rand(1);
            rand_counts(i)=rand_counts(i)+1;
            for j = 1:i-1
                distance_x = x - circles(2, j);
                distance_y = y - circles(3, j);
                distance = sqrt(distance_x^2 + distance_y^2);
                if distance <= r + circles(1, j)
                    collides = 1;
                end
            end
            if (x + r <= a) && (x - r >= 0) && (y + r <= a) && (y - r >= 0) && collides == 0
                break
            end
        end
        circles(1, i) = r;
        circles(2, i) = x;
        circles(3, i) = y;
        counts_mean(i) = mean(rand_counts(1:i));
    end
    circle_areas = cumsum(pi*(circles(1,:).^2))
end

function plot_circles(a,circles,index_number)
    figure
    hold on
    axis equal
    axis([0 a 0 a])
    L1 = 7;
    for i = 1:size(circles, 2)
        plot_circle(circles(1, i), circles(2, i), circles(3, i));
    end
    hold off
    print -dpng 'zadanie1.png'
end
function plot_circle_areas(circle_areas)
    figure
    plot(circle_areas)
    title("Pola koł")
    xlabel("index")
    ylabel("pole")

    print -dpng zadanie3.png 
end

function plot_counts_mean(counts_mean)
    figure
    plot(counts_mean)
    title("Srednie losowan")
    xlabel("index")
    ylabel("Srednia")
    print -dpng zadanie5.png 
end




