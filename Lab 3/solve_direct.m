function [A,b,x,time_direct,err_norm,index_number] = solve_direct(A,b)
    index_number = 193387;
    L1 = mod(index_number,10);
    tic
    x = A\b;
    time_direct = toc;
    err_norm = norm(A*x-b);
end