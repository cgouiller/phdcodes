dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining PIV treatment...'),'keepthis','timestamp');
tic
load(strcat(directoryAnalyse,'directory.mat'));

L2=L;
clear L;
L=dir(strcat(directoryPivmean,'*.mat'));
load(strcat(directoryPivmean,L(1).name));
derrieregauchey=46;
derrieregauchex=446;
devantdroitey=1346;
devantdroitex=1446;
U_tot=zeros(size(u,1),size(u,2));
V_tot=zeros(size(v,1),size(v,2));
div_tot=zeros(size(v,1),size(v,2));
countsu=zeros(size(u,1),size(u,2));
countsv=zeros(size(u,1),size(u,2));

a=load(strcat(directoryAnalyse,'\positions.mat'));
c=a.c;
imbg=load(strcat(directoryAnalyse,'\im0'));
imbg=imbg.im0;

load(strcat(directoryAnalyse,'\particules_selectionnees.mat'));

calxy=calib; %obtenu grâce à la diagonale d'une image
caluv=calxy*fps; %diagonale d'une image et fps
sample=sortrows(sample,3);

k=round(linspace(1,length(sample)-61,1000));
for i=1:length(L)
    if mod(i,10)==0
        dispstat(sprintf('Progress %d%%',round(i*100/length(L))),'timestamp');
    end
    load(strcat(directoryPivmean,L(i).name));
    
    pos=[c(sample(k(i),3)).x,c(sample(k(i),3)).y,c(sample(k(i),3)).r];
    pos=pos/calib;
    fname=L2(sample(k(i),3)).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    im=im./imbg;
    for kkk=1:length(im)
        for kkkk=1:length(im)
            if ((kkk-length(im)/2)^2+(kkkk-length(im)/2)^2)>radiusCellPx^2
                im(kkk,kkkk)=0;
            end
        end
    end
    for m=1:length(pos(:,3))
        
        for jj=(max(round(pos(m,2))-(3+round(pos(m,3))),1)):(min(round(pos(m,2))+(3+round(pos(m,3))),length(im)))
            for jjj=(max(round(pos(m,1))-(3+round(pos(m,3))),1)):(min(round(pos(m,1))+(3+round(pos(m,3))),length(im)))
                if ((jj-round(pos(m,2)))^2+(jjj-round(pos(m,1)))^2)<(3+round(pos(m,3)))^2
                    im(jj,jjj)=0;
                end
            end
        end
        
    end
    
    s=length(im);
    [X,Y]=meshgrid(1:size(im,2),1:size(im,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-sample(k(i),1)/calib;
    pts(:,2)=Y(:)-sample(k(i),2)/calib;
    R=[cos(sample(k(i),9)), sin(sample(k(i),9));-sin(sample(k(i),9)) cos(sample(k(i),9))];
    vv=[s/2-sample(k(i),1)/calib, s/2-sample(k(i),2)/calib];
    
    tt=vv*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+sample(k(i),1)/calib;
    pts2(:,2)=pts2(:,2)+sample(k(i),2)/calib;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [im,count]=bilinear_clement(im,ptsf);
    im=im(derrieregauchey:devantdroitey,derrieregauchex:devantdroitex);
  
    mask1=1-(im>0.99 | im<0.7);
    
%     Image suivante juste pour masquer
pos=[c(sample(k(i),3)+1).x,c(sample(k(i),3)+1).y,c(sample(k(i),3)+1).r];
    pos=pos/calib;
    fname=L2(sample(k(i),3)+1).name;
    fnamecompl=strcat(directoryVid,fname);
    im2=double(imread(fnamecompl));
    im2=im2(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    im2=im2./imbg;
    for kkk=1:length(im2)
        for kkkk=1:length(im2)
            if ((kkk-length(im2)/2)^2+(kkkk-length(im2)/2)^2)>radiusCellPx^2
                im2(kkk,kkkk)=0;
            end
        end
    end
    for m=1:length(pos(:,3))
        
        for jj=(max(round(pos(m,2))-(3+round(pos(m,3))),1)):(min(round(pos(m,2))+(3+round(pos(m,3))),length(im2)))
            for jjj=(max(round(pos(m,1))-(3+round(pos(m,3))),1)):(min(round(pos(m,1))+(3+round(pos(m,3))),length(im2)))
                if ((jj-round(pos(m,2)))^2+(jjj-round(pos(m,1)))^2)<(3+round(pos(m,3)))^2
                    im2(jj,jjj)=0;
                end
            end
        end
        
    end
    
    s=length(im2);
    [X,Y]=meshgrid(1:size(im2,2),1:size(im2,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-sample(k(i),1)/calib;
    pts(:,2)=Y(:)-sample(k(i),2)/calib;
    R=[cos(sample(k(i),9)), sin(sample(k(i),9));-sin(sample(k(i),9)) cos(sample(k(i),9))];
    vv=[s/2-sample(k(i),1)/calib, s/2-sample(k(i),2)/calib];
    
    tt=vv*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+sample(k(i),1)/calib;
    pts2(:,2)=pts2(:,2)+sample(k(i),2)/calib;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [im2,count]=bilinear_clement(im2,ptsf);
    im2=im2(derrieregauchey:devantdroitey,derrieregauchex:devantdroitex);
  
    mask2=1-(im2>0.99 | im2<0.7);
    
    mask=(mask1 & mask2);
    
    
    
    u(isnan(u))=0;
    v(isnan(v))=0;
    
    Um=NaN(size(im,1),size(im,2));
    Vm=NaN(size(im,1),size(im,2));
    
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
    Y=(y-sizeim/2)*calxy;%en mm
    
    
    U_tot=U_tot+U;
    V_tot=V_tot+V;
    U(U==0)=NaN;
    V(V==0)=NaN;
    countsu=countsu+(ones(size(U))-isnan(U));
    countsv=countsv+(ones(size(V))-isnan(V));
    
    
end

Umoy=U_tot./countsu;
Vmoy=V_tot./countsv;


save(strcat(directoryAnalyse,'\PIV_mean'),'X','Y','Umoy','Vmoy','countsu','countsv','calxy','caluv')
toc
