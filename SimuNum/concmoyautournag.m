%% Calcule la concentration moyenne � chaque endroit autour du nageur en lin�aire


load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mx','my','mxbg','mybg');

dispstat('','init');
dispstat(sprintf('Begining the mean trail calculation...'),'keepthis','timestamp');
sigbbg=sqrt((2*pi)^2/(10000*pi));%sqrt(Dbg*dt)/2;
N=256;%R�solution de la grille de simu
make_grid; %Initialise la grille de simu (N*N) et une variable utile pour g�rer l'aliasing


% profil source de camphre (centr� en pi), qui correspond � un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sigbbg^2)/(2*pi*sigbbg^2);% aire normalis�e � 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
nt=manipCat.nt(ii);

% on definit le filtre dans l'espace de fourier
imtot=zeros(N,N);
counttot=zeros(N,N);
nnag=length(mx(1,:));
ntot=nnag*(nt-10000);
nvoulu=1000;
aleat=round((rand(1,nvoulu)*(ntot-nnag))+10000*nnag);
while length(aleat)~=length(unique(aleat))
    aleat=[unique(aleat),round((rand(1,length(aleat)-length(unique(aleat)))*(ntot-nnag))+5000*nnag)];
end
for jj=1:length(aleat)
    kk=aleat(jj);
    numimage=fix((kk-1)/nnag)+1;
    numnage=kk-(numimage-1)*nnag;
    
    if mod(jj,10)==0
        dispstat(sprintf('Progress %d%%',round(jj*100/length(aleat))),'timestamp');
    end
    
     source_f=zeros(size(source0_f));
    for nn=1:bbg
        source_f=source_f+source0_f.*exp(-1i*mod(mxbg(numimage,nn),L)*kx-1i*mod(mybg(numimage,nn),L)*ky);
    end
    Cfield=real(ifft2(source_f));
    
    s=length(Cfield);
    posxnag=mod(mx(numimage,numnage),L)*N/L;
    posynag=mod(my(numimage,numnage),L)*N/L;
    angle=atan((my(numimage+1,numnage)-my(numimage-1,numnage))/(mx(numimage+1,numnage)-mx(numimage-1,numnage)));
    if mx(numimage+1,numnage)-mx(numimage-1,numnage)<0
        angle=angle+pi;
    end
    [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-posxnag;
    pts(:,2)=Y(:)-posynag;
    R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
    v=[s/2-posxnag, s/2-posynag];
    
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+posxnag;
    pts2(:,2)=pts2(:,2)+posynag;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [im,count]=bilinear_clement(Cfield,ptsf);
    
    
    imtot=imtot+im;
    counttot=counttot+count;
    
    
    
end
immoy=imtot./counttot;
 source_f=zeros(size(source0_f));
    for nn=1:bbg
        source_f=source_f+source0_f.*exp(-1i*mod(mxbg(nt,nn),L)*kx-1i*mod(mybg(nt,nn),L)*ky);
    end
    Cfield=real(ifft2(source_f));
    immoynorm=immoy/mean(mean(Cfield));
save(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_meanTrail.mat'),'immoy','immoynorm');
mkdir(strcat('E:\Cl�ment\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii}))

save(strcat('E:\Cl�ment\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_meanTrail.mat'),'immoy','immoynorm');


