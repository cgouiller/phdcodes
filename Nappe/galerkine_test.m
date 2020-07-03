clear all;close all;
L=1;
a=0.5;
b=0.9;
k0=pi/L;
N=5;

x = linspace(a,b,N)' ;
y = 0.5*sin(k0*x) + 0.1*sin(k0*2*x) + 0.01*randn(size(x));

xlim([0 1])
ylim([0 0.6])

A = [sin(k0*x) sin(k0*2*x)];

cp=pinv(A)*y;

xx = linspace(0,1,100);
yyp = 0.5*sin(k0*xx)+0.1*sin(2*k0*xx);
yyq = cp(1)*sin(k0*xx)+cp(2)*sin(2*k0*xx);


plot(x, y, 'bo', xx, yyp, 'r+', xx, yyq, 'k-','LineWidth',2);
grid