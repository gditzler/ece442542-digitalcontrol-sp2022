% po_dampingratio_example.m 
% Show the relationship between the percent overshoot and damping ratio for
% a second order system. 
%
% MIT License
% 
% Copyright (c) 2022 Gregory Ditzler
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

clc; 
clear; 
close all; 
zeta = 0:0.001:1;

PO = @(z) 100*exp(-z*pi./sqrt(1-z.^2));
% Zeta = @(po) sqrt(log(po/100).^2 / (log(po/100).^2 + pi^2));

figure; 
hold on; 
box on; 
grid on; 
plot(zeta, PO(zeta), 'LineWidth', 3)
% plot(Zeta(5), PO(Zeta(5)), 'LineWidth', 3)
ylabel('PO')
xlabel('zeta')