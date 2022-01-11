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

% Chapter 4: Example 4.6 - Check to see if the system is stable using the
% Jury Criteria. The system is given by 
% F(z) = z^5 + 2.6 z^4 - 0.56 z^3 - 2.05 z^2 + 0.0775 z + 0.35
clc; 
clear; 
close all; 

% define the coefficients [a5, a4, ... , a0]
a = [1, 2.6, -.56, -2.05, 0.0775, 0.35]; 
jury(a); % call T = jury(a) if the system is stable to get the table. 