% script_jury_example.m 
% Check System Stability with the Jury Critera
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


%% problem 1
T = 0.02;
G = tf(1, [1 1 0]); 
Gd = c2d(G, T);

figure; pzmap(G)
figure; pzmap(Gd)
figure; bode(G)
figure; bode(Gd)

%% problem 2
M = 2;       % mass constant   
B = 5;       % dash pot constant 
K = 350;     % spring constant 
gain = 160;  % gain 
T = 0.003;   % sample period 
ws = 2*pi/T; % sample rate (radians)

% set up the state space system matrices
A = [-B/M, 1; -K/M, 0];
B = [0; gain/M]; 
C = [1, 0]; 

% compute the poles of G(s) and the natural frequency 
[v, d] = eig(A); 
wn = abs(diag(d)); 

psi4 = A*T/4; 
psi3 = (A*T/3)*(eye(2)+psi4);
psi2 = (A*T/2)*(eye(2)+psi3);
psi = eye(2) + psi2;
phi = eye(2) + A*T*psi;
gamma = psi*T*B; 
phi1 = expm(A*T); 
e_phi=eig(phi); 

syms s % Define a symbolic variable 's'. This is the Laplace variable.
sImA=s*eye(2)-A,
sImai=sImA^(-1),
eat=ilaplace(sImai),
input_pre=eat*B;
