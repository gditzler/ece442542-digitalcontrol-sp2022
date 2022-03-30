clc; 
clear; 
close all; 

N = 500; 
z1 = linspace(1, 2, N);
z2 = linspace(-2, -.5, N);
K = @(z) abs((z.^2-3*z+2)./z);

figure; 
hold on; 
grid on; 
box on; 
plot(z1, K(z1), 'b', 'LineWidth', 3)
xlabel('z')
ylabel('K')

figure; 
hold on; 
grid on; 
box on; 
plot(z2, K(z2), 'b', 'LineWidth', 3)
xlabel('z')
ylabel('K')

% in matlab
z = tf('z');
G = z/((z-1)*(z-2));
rlocus(G)