function [mdx2,mdx,tau]=msd(x,dt,inc)

% this prog computes the incr of a signal
% inc is a vector containing the values of increments to be used
% if inc is a scalar, it assume to be the number of points
% r.v. 03/2020
% Nmax, number of points

if dt==0;
    dt=1;
end

if length(inc)==1
    Nmax=inc;
    tau=1:Nmax;
else
    Nmax=length(inc);
    tau=inc;
end

mdx2=zeros(1,Nmax);
mdx=zeros(1,Nmax);
tau=tau*dt;

for k=1:length(inc) 
    dx=x(:,1+inc(k):end)-x(:,1:end-inc(k));
    mdx2(k)=mean(mean(dx.^2));
    mdx(k)=mean(mean(dx));
end













