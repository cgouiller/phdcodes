clear all;
hold on;
clf;
close all;

%load displacement fields
file='C:\Users\ccottin\Desktop\PIVlab';
a=load(strcat(file,'.txt'));
v=loadvec(strcat(file,'b.txt'));

%%
% parameters for the reconstruction
H0=50.5;    % Distance between pattern and surface
HC=500;     % Distance between camera and surface
xc=90;  %en mm 
yc=90;   % en mm
echant=1001;


%%

sizex=size(v.vx);
sizey=size(v.vx);
sizex=sizex(1);
sizey=sizey(2);



%%
xx=reshape(a(:,1),sizey,sizex)*1000;
xx=xx(1,:);
yy=reshape(a(:,2),sizey,sizex)*1000;
yy=yy(:,1)';
vxx=reshape(a(:,3),sizey,sizex)'*1000;
vyy=reshape(a(:,4),sizey,sizex)'*1000;


%%
v.x=xx;v.y=yy;v.vx=vxx;v.vy=vyy;
v.vx(isnan(v.vx))=0;
v.vy(isnan(v.vy))=0;

width=max(v.x)-min(v.x);
height=max(v.y)-min(v.y);

h=surfheight(v,H0,HC,1.33,'submean','remap','notsetzero');

h.w=h.w-H0;
figure,showf(h)
bool=0;

%%

if bool==1
    thetaCorr=pi/4;
    grad=(0.06546+0.03616)/(50.5-38.2);
    [Xmesh,Ymesh]=meshgrid(h.y, h.x);
    gradMatrix=-grad*cos(thetaCorr)*Xmesh+grad*sin(thetaCorr)*Ymesh;
    h.w=h.w+gradMatrix;
end

%%

indmaxx=size(h.x);
indmaxx=indmaxx(2);
indmaxy=size(h.y);
indmaxy=indmaxy(2);

if xc==0
    xc=width/2;
    yc=height/2;
end

hinterp=zeros(echant,10);
hinterpnear=zeros(echant,10);

for n=1:10
    theta=n*pi/5;%(n-2)*pi/4;
    
    xend=xc-100*cos(theta);
    yend=yc-100*sin(theta);
    
    linex=linspace(xc,xend,echant);
    liney=linspace(yc,yend,echant);
    
    for i=1:echant
        xi=linex(i);
        yi=liney(i);
        if ((xi>min(h.x)) && (xi<max(h.x)) && (yi>min(h.y)) && (yi<max(h.y)))
            indx=find(abs(h.x-xi)==min(abs(h.x-xi)));
            indy=find(abs(h.y-yi)==min(abs(h.y-yi)));
            
            if indx~=1
                if indx~=indmaxx
                    if abs(h.x(indx-1)-xi)<abs(h.x(indx+1)-xi)
                        indx1=indx-1; indx2=indx;
                    else
                        indx1=indx; indx2=indx+1;
                    end
                else
                    indx1=indx-1; indx2=indx;
                end
            else
                indx1=indx; indx2=indx+1;                
            end
            
            if indy~=1
                if indy~=indmaxy
                    if abs(h.y(indy-1)-yi)<abs(h.y(indy+1)-yi)
                        indy1=indy-1; indy2=indy;
                    else
                        indy1=indy; indy2=indy+1;
                    end
                else
                    indy1=indy-1; indy2=indy;
                end
            else
                indy2=indy; indy1=indy+1;
            end
            
            x1=h.x(indx1); x2=h.x(indx2); y1=h.y(indy1); y2=h.y(indy2);
            h11=h.w(indx1,indy1); h21=h.w(indx2,indy1);
            h12=h.w(indx1,indy2); h22=h.w(indx2,indy2);
            pref=1/((x2-x1)*(y2-y1));
            t11=h11*(x2-xi)*(y2-yi);
            t21=h21*(xi-x1)*(y2-yi);
            t12=h12*(x2-xi)*(yi-y1);
            t22=h22*(xi-x1)*(yi-y1);
            hinterp(i,n)=pref*(t11+t21+t12+t22);
            hinterpnear(i,n)=h.w(indx,indy);
            
        end
    end
end

r=linspace(0,100,echant);
textfile=[ r' hinterp];
figure;
plot(r,hinterp(:,1),'b');
hold on;
plot(r,hinterp(:,2),'c');
plot(r,hinterp(:,3),'g');
plot(r,hinterp(:,4),'y');
plot(r,hinterp(:,5),'r');

%%
profilmoyen=mean(hinterp,2);
figure;
plot(r,profilmoyen,'b');
textfile=[ r' profilmoyen];
dlmwrite(strcat(file,'_profil.txt'),textfile,'delimiter','\t')

