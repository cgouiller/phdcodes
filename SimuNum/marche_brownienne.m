% on fabrique une marche brownienne

dt=1e-3;
D=1;
np=100;
N=1e5;

z=zeros(np,N);
z(:,1)=randn;

for h=2:N
    dw=sqrt(2*D*dt)*randn(np,1);
    z(:,h)=z(:,h-1)+dw;
end
clear dw
t=0:N-1;t=t*dt;

figure;
hold on
for k=1:np
    plot(t,z(k,:),'.-','color',rand(3,1));
end
hold off
grid
xlabel('t');
ylabel('z(t)');

[mdx2,mdx,tau]=msd(z,dt,1:20:1000);
figure;plot(t(1:1000),2*t(1:1000),'r.',tau,mdx2,'bo');grid
xlabel('t');
ylabel('<(\Delta z)^2>(t)');   
legend('location','southeast','analytique','calcul');











