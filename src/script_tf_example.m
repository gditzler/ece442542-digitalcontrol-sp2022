% script_tf_example.m 
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

z = tf('z');               % make a complex z-variable 
G = 1/(z^2 - 0.5*z -0.5);  % define the TF slightly differently
K = 0.5;                   % set the gain 
Tc = K*G/(1 + K*G);        % this matlab's answer 
Td = feedback(K*G, 1);     % this will be in the form of your answer

% the plot below shows the pole-zero map of the system that is created by
% matlab by using the operator overloading expression. the poles of the
% open loop system are effectively being canceled. NOT GOOD BECAUSE THERE
% IS A POLE @ z = 1. 
figure; 
pzmap(Tc);
title('Matlabs Solution'); 

% pole-zero map for the "by hand" solution. this system is formed using the
% feedback function and it is what you expect to get when you find the
% solution on pen'n paper. 
figure; 
pzmap(Td); 
title('Expected Solution'); 

% plot the step response of each system. note that even though the system
% in Tc(z) canceled a pole on the unit circle, the step response was still
% stable. regardless of the simulation, DO NOT EVER CANCEL a pole on or
% outside the unit circle. 
figure; 
step(Tc); 
title('Matlabs Solution'); 

figure; 
step(Td); 
title('Expected Solution'); 
