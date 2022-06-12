% mex -O CEmpty.c
% mex -O CppEmpty.cpp
% mex -O CppEmpty2.cpp

clc
clearvars

n = 1e5;

t = zeros(6, 1);
for ii = 1 : n
    %% Inline
    ts = tic();
    x1 = [];
    t(1) = t(1) + toc(ts);

    %% Empty()
    ts = tic();
    x2 = Empty();
    t(2) = t(2) + toc(ts);

    %% @()[]
    empty2 = @()[];
    ts = tic();
    x3 = empty2();
    t(3) = t(3) + toc(ts);
    
    %% C MEX Empty()
    ts = tic();
    x4 = CEmpty();
    t(4) = t(4) + toc(ts);
    
    %% C++ MEX Empty()
    ts = tic();
    x5 = CppEmpty();
    t(5) = t(5) + toc(ts);
    
    %% C++ MEX Empty2() - C entry
    ts = tic();
    x6 = CppEmpty2();
    t(6) = t(6) + toc(ts);
end

fprintf('     inline x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(1)*1e3, t(1)/n*1e6, 1);
fprintf('    empty() x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(2)*1e3, t(2)/n*1e6, t(2) / t(1));
fprintf('      @()[] x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(3)*1e3, t(3)/n*1e6, t(3) / t(1));
fprintf('   CEmpty() x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(4)*1e3, t(4)/n*1e6, t(4) / t(1));
fprintf(' CppEmpty() x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(5)*1e3, t(5)/n*1e6, t(5) / t(1));
fprintf('CppEmpty2() x%d   |   %9.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(6)*1e3, t(6)/n*1e6, t(6) / t(1));


function x = Empty()
    x = [];
end