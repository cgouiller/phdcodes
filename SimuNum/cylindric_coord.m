x0=((0:127)+0.5)*2*pi/128;
y0=((0:127)+0.5)*2*pi/128;
[x,y]=meshgrid(x0,y0);
R=zeros(size(x));
T=zeros(size(x));
Vr=zeros(size(x));
Vt=zeros(size(x));

for i=1:length(x)/2
    for j=1:length(x)/2
        R(i,j)=sqrt((x(i,j)-pi/2)^2+(y(i,j)-pi/2)^2);
        T(i,j)=atan((y(i,j)-pi/2)/(x(i,j)-pi/2));
        if x(i,j)-pi/2<0
            T(i,j)=T(i,j)-pi;
        end
    end
end
for i=1:length(x)/2
    for j=length(x)/2+1:length(x)
        R(i,j)=sqrt((x(i,j)-3*pi/2)^2+(y(i,j)-pi/2)^2);
        T(i,j)=atan((y(i,j)-pi/2)/(x(i,j)-3*pi/2));
        if x(i,j)-3*pi/2<0
            T(i,j)=T(i,j)-pi;
        end
        
    end
end
for i=length(x)/2+1:length(x)
    for j=1:length(x)/2
        R(i,j)=sqrt((x(i,j)-pi/2)^2+(y(i,j)-3*pi/2)^2);
        T(i,j)=atan((y(i,j)-3*pi/2)/(x(i,j)-pi/2));
        if x(i,j)-pi/2<0
            T(i,j)=T(i,j)-pi;
        end
        
    end
end
for i=length(x)/2+1:length(x)
    for j=length(x)/2+1:length(x)
        R(i,j)=sqrt((x(i,j)-3*pi/2)^2+(y(i,j)-3*pi/2)^2);
        T(i,j)=atan((y(i,j)-3*pi/2)/(x(i,j)-3*pi/2));
        if x(i,j)-3*pi/2<0
            T(i,j)=T(i,j)-pi;
        end
        
    end
end
T=flipud(T);
T=fliplr(T);
T=T+3*pi/2;
%figure;imagesc(x0,y0,T);set(gca,'YDir','normal')
