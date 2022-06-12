% mex -O Cnop.c
% mex -O Cppnop.cpp
% mex -O Cppnop2.cpp

clc
clearvars

n = 1e5;

t = zeros(5, 1);
for ii = 1 : n
    % Actual nothing
    ts = tic();
    t(1) = t(1) + toc(ts);

    %% nop()
    ts = tic();
    nop();
    t(2) = t(2) + toc(ts);
    
    %% C MEX nop()
    ts = tic();
    Cnop();
    t(3) = t(3) + toc(ts);
    
    %% C++ MEX nop()
    ts = tic();
    Cppnop();
    t(4) = t(4) + toc(ts);
    
    %% C++ MEX nop() - C entry
    ts = tic();
    Cppnop2();
    t(5) = t(5) + toc(ts);
end

fprintf('  nothing x%d   |   %8.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(1)*1e3, t(1)/n*1e6, 1.0);
fprintf('    nop() x%d   |   %8.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(2)*1e3, t(2)/n*1e6, t(2) / t(1));
fprintf('   Cnop() x%d   |   %8.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(3)*1e3, t(3)/n*1e6, t(3) / t(1));
fprintf(' Cppnop() x%d   |   %8.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(4)*1e3, t(4)/n*1e6, t(4) / t(1));
fprintf('Cppnop2() x%d   |   %8.4fms   |   %6.4fus/call   |   %6.3fx\n', n, t(5)*1e3, t(5)/n*1e6, t(5) / t(1));


function nop()
end