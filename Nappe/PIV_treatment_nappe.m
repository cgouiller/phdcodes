clear all;

fps=200;
nums=[1,2,3,4,5];
for j=2%:length(nums)
directoryVid=strcat('D:\2019_12_gouiller\200124\',num2str(nums(j)),'\');
directoryPivmean=strcat(directoryVid,'Piv\');

load(strcat(directoryPivmean,'PIVlab.mat'))
load(strcat(directoryVid,'trajectories.mat'));
load(strcat(directoryVid,'positions.mat'));
L=dir(strcat(directoryVid,'*.tif'));

startpretr=9;
endpretr=length(L)-8;

xs=x;
ys=y;
u=u_original{1,1};
v=v_original{1,1};

U_tot=zeros(size(u,1),size(u,2));
V_tot=zeros(size(v,1),size(v,2));
div_tot=zeros(size(v,1),size(v,2));
countsu=zeros(size(u,1),size(u,2));
countsv=zeros(size(u,1),size(u,2));

tracks(:,2)=tracks(:,2)+200;


calxy=1; %obtenu grâce à la diagonale d'une image
caluv=calxy*fps; %diagonale d'une image et fps
tracks=sortrows(tracks,4);

for i=20:40%length(u_original)
    i
    k=startpretr+i-1;
    
    
    pos=[c(tracks(k,3)).x,c(tracks(k,3)).y+200,c(tracks(k,3)).r];
    fname=L(tracks(k,3)).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    
    imsq=zeros(1248,1248);
   imsq(201:1048,:)=im;
    
        
        for jj=(max(round(pos(1,2))-(3+round(pos(1,3))),1)):(min(round(pos(1,2))+(3+round(pos(1,3))),length(imsq)))
            for jjj=(max(round(pos(1,1))-(3+round(pos(1,3))),1)):(min(round(pos(1,1))+(3+round(pos(1,3))),length(imsq)))
                if ((jj-round(pos(1,2)))^2+(jjj-round(pos(1,1)))^2)<(3+round(pos(1,3)))^2
                    imsq(jj,jjj)=0;
                end
            end
        end
        
   
    [X,Y]=meshgrid(1:size(imsq,2),1:size(imsq,1));
    s=size(imsq,1);
    [X,Y]=meshgrid(1:size(imsq,2),1:size(imsq,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-tracks(k,1);
    pts(:,2)=Y(:)-tracks(k,2);
    R=[cos(tracks(k,9)), sin(tracks(k,9));-sin(tracks(k,9)) cos(tracks(k,9))];
    vv=[s/2-tracks(k,1), s/2-tracks(k,2)];
    
    tt=vv*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+tracks(k,1);
    pts2(:,2)=pts2(:,2)+tracks(k,2);
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [imsq,count]=bilinear_clement(imsq,ptsf);
  
    mask1=1-(imsq>150 | imsq<3);
    
%     Image suivante juste pour masquer
pos=[c(tracks(k,3)+4).x,c(tracks(k,3)+4).y+200,c(tracks(k,3)+4).r];
    fname=L(tracks(k,3)+4).name;
    fnamecompl=strcat(directoryVid,fname);
    im2=double(imread(fnamecompl));
    imsq2=zeros(1248,1248);
   imsq2(201:1048,:)=im2;
   
  
    
        
        for jj=(max(round(pos(1,2))-(3+round(pos(1,3))),1)):(min(round(pos(1,2))+(3+round(pos(1,3))),length(im2)))
            for jjj=(max(round(pos(1,1))-(3+round(pos(1,3))),1)):(min(round(pos(1,1))+(3+round(pos(1,3))),length(im2)))
                if ((jj-round(pos(1,2)))^2+(jjj-round(pos(1,1)))^2)<(3+round(pos(1,3)))^2
                    im2(jj,jjj)=0;
                end
            end
        end
        
   
    
    s=length(imsq2);
    [X,Y]=meshgrid(1:size(imsq2,2),1:size(imsq2,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-tracks(k,1);
    pts(:,2)=Y(:)-tracks(k,2);
    R=[cos(tracks(k,9)), sin(tracks(k,9));-sin(tracks(k,9)) cos(tracks(k,9))];
    vv=[s/2-tracks(k,1), s/2-tracks(k,2)];
    
    tt=vv*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+tracks(k,1);
    pts2(:,2)=pts2(:,2)+tracks(k,2);
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [imsq2,count]=bilinear_clement(imsq2,ptsf);
  
    mask2=1-(imsq2>150 | imsq2<3);
    
    mask=(mask1 & mask2);
    
    u=u_original{i,1};
    v=v_original{i,1};
    x=xs{i,1};
    y=ys{i,1};
    u(isnan(u))=0;
    v(isnan(v))=0;
    
    Um=NaN(size(imsq,1),size(imsq,2));
    Vm=NaN(size(imsq,1),size(imsq,2));
    
    for ii=1:length(x(1,:))
        for j=1:length(y(:,1))
            Um(y(j,1),x(1,ii))=u(j,ii);
            Vm(y(j,1),x(1,ii))=v(j,ii);
        end
    end
    
    Um=Um.*mask;
    Vm=Vm.*mask;
    
    for ii=1:length(x(1,:))
        for j=1:length(y(:,1))
            u(j,ii)=Um(y(j,1),x(1,ii));
            v(j,ii)=Vm(y(j,1),x(1,ii));
        end
    end
    
    
    
    U=u*caluv;%en mm/s
    V=v*caluv;%en mm/s
    
    X=(x-max(max(x))/2)*calxy;%en mm
    Y=(y-length(imsq)/2)*calxy;%en mm
    
    
    U_tot=U_tot+U;
    V_tot=V_tot+V;
    U(U==0)=NaN;
    V(V==0)=NaN;
    countsu=countsu+(ones(size(U))-isnan(U));
    countsv=countsv+(ones(size(V))-isnan(V));
    
    
end

Umoy=U_tot./countsu;
Vmoy=V_tot./countsv;


%save(strcat(directoryVid,'PIV_mean'),'X','Y','Umoy','Vmoy','countsu','countsv','calxy','caluv')

end