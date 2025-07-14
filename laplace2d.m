%Finite Difference Method for Laplace Equation
clc
clear
close all

a = 1;
b = 1;
nx = 50;
ny = 50; 
dx = a/nx;
dy = b/ny;
x = 0:dx:a;
y = 0:dy:b;%A mesh of size nx*ny is created

%%Analytical
u = zeros(ny+1,nx+1);
for i = 1:ny+1
    for j = 1:nx+1
        u(i,j) = sinh(pi*y(i)).*sin(pi*x(j))./sinh(pi);
    end
end
hold on
maxu = max(u,[],'all');
nu = u/maxu;
figure
subplot(1,3,1)
contour(nu, 200)
title('Analytical Solution')
colormap(jet(256))
colorbar

%%Numerical
C = 1/(2*(dx^2 + dy^2));
N= zeros(ny+1,nx+1);
N(:,1) = 0;
N(:,nx+1) = 0;
N(1,:) = 0;
N(ny+1,:) = sin(pi .* x);

for k =1:10000
    for i =2:ny
        for j = 2:nx
            N(i,j) = C *(dx^2 *(N(i+1,j) + N(i-1,j)) + dy^2 * (N(i,j+1) + N(i,j-1)));
        end
    end
end
maxN = max(N,[],'all');
nN = N/maxN;
subplot(1,3,2)
contour(nN, 200)
title('Numerical Solution')
colormap(jet(256))
colorbar

%% Error Analysis
E = abs(nu-nN);
subplot(1,3,3)
contour(E, 200)
title('Error')
colormap(jet(256))
colorbar