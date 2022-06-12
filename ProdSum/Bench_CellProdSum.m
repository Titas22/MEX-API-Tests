% mex -O CProdSum.c -R2018a
% mex -O CppProdSum.cpp -R2018a
% mex -O CppProdSum2.cpp -R2018a

clc
clearvars

% Create data
for jj = 1000 : -1 : 1
    arr{jj, 1} = 0.5 + rand(randi(50, 1), 1);
end

n = 1e2;
x3 = 0;
x4 = 0;
t = zeros(5, 1);
for ii = 1 : n
    %% ProdSum()
    ts = tic();
    x1 = ProdSum(arr);
    t(1) = t(1) + toc(ts);

    %% Cellfun
    ts = tic();
    x2 = sum(cellfun(@(x) prod(x), arr));
    t(2) = t(2) + toc(ts);
    
    %% C MEX ProdSum()
    ts = tic();
    x3 = CProdSum(arr);
    t(3) = t(3) + toc(ts);
    
    %% C++ MEX ProdSum()
    ts = tic();
    x4 = CppProdSum(arr);
    t(4) = t(4) + toc(ts);

    %% C++ MEX ProdSum2() - C entry
    ts = tic();
    x5 = CppProdSum2(arr);
    t(5) = t(5) + toc(ts);
end

fprintf('    ProdSum() x%d   |   %9.4fms   |   %9.4fus/call   |   %6.3fx   |   val = %g\n', n, t(1)*1e3, t(1)/n*1e6, 1, x1);
fprintf('      cellfun x%d   |   %9.4fms   |   %9.4fus/call   |   %6.3fx   |   val = %g\n', n, t(2)*1e3, t(2)/n*1e6, t(2) / t(1), x2);
fprintf('   CProdSum() x%d   |   %9.4fms   |   %9.4fus/call   |   %6.3fx   |   val = %g\n', n, t(3)*1e3, t(3)/n*1e6, t(3) / t(1), x3);
fprintf(' CppProdSum() x%d   |   %9.4fms   |   %9.4fus/call   |   %6.3fx   |   val = %g\n', n, t(4)*1e3, t(4)/n*1e6, t(4) / t(1), x4);
fprintf('CppProdSum2() x%d   |   %9.4fms   |   %9.4fus/call   |   %6.3fx   |   val = %g\n', n, t(5)*1e3, t(5)/n*1e6, t(5) / t(1), x5);


function x = ProdSum(arr)
    x = 0;
    for jj = 1 : size(arr, 1)
        x = x + prod(arr{jj});
    end
end