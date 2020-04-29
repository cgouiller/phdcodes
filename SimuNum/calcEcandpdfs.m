ii
load(strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'));
N=128;L=2*pi;sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
make_grid;
tracks=[];
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));
vxfilt=real(ifft2((vxextf).*gfilt_f));
vyfilt=real(ifft2((vyextf).*gfilt_f));
vxfiltpad=padarray(vxfilt,[Npad Npad],'circular','both');
vyfiltpad=padarray(vyfilt,[Npad Npad],'circular','both');



%% Energie cinétique 
tracks=[];
for j=1:npart
    round(100*j/npart)
    newpart=[dt*(1:nt)',mx(:,j),my(:,j)];
    for k=2:length(newpart)-1
        newpart(k,4)=(newpart(k+1,2)-newpart(k-1,2))/(newpart(k+1,1)-newpart(k-1,1));%-interp2(xpad,ypad,vxfiltpad,mod(newpart(k,2),2*pi),mod(newpart(k,3),2*pi));
        newpart(k,5)=(newpart(k+1,3)-newpart(k-1,3))/(newpart(k+1,1)-newpart(k-1,1));%-interp2(xpad,ypad,vyfiltpad,mod(newpart(k,2),2*pi),mod(newpart(k,3),2*pi));
        newpart(k,7)=(newpart(k+1,4)-newpart(k-1,4))/(newpart(k+1,1)-newpart(k-1,1));
        newpart(k,8)=(newpart(k+1,5)-newpart(k-1,5))/(newpart(k+1,1)-newpart(k-1,1));
    end
    newpart(1,4)=NaN;
    newpart(length(newpart),4)=NaN;
    newpart(length(newpart),5)=NaN;
    newpart(:,6)=sqrt(newpart(:,4).^2+newpart(:,5).^2);
    newpart(:,9)=j*ones(length(newpart),1);

    tracks=[tracks;newpart];
    newpart=[];
end
for k=1:nt
    Ec(k)=1/2*sum(tracks(tracks(:,1)==tracks(k,1),6).^2);
end
Ec=Ec/npart;


%% MSD

d=zeros(npart,length(mx));
for j=1:npart
d(j,:)=sqrt((mx(:,j)-mx(1,j)).^2+(my(:,j)-my(1,j)).^2)';
end
[MeanSD,mdx,tau]=msd(d,dt,1:20:round(length(d)/3));


%% Histogrammes
[countx,binx]=hist_maison((tracks(:,4)-nanmean2(tracks(:,4)))/nanstd(tracks(:,4)),-5,5,101,1);
[county,biny]=hist_maison((tracks(:,5)-nanmean2(tracks(:,5)))/nanstd(tracks(:,5)),-5,5,101,1);
[countax,binax]=hist_maison((tracks(:,7)-nanmean2(tracks(:,7)))/nanstd(tracks(:,7)),-5,5,101,1);
[countay,binay]=hist_maison((tracks(:,8)-nanmean2(tracks(:,8)))/nanstd(tracks(:,8)),-5,5,101,1);
bin=binx;
fname=strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat');

%load(strcat(fname(1:end-4),'_analyze.mat'))
Ec(isnan(Ec))=0;
[SpEc,fEc]=pwelch(Ec,hanning(length(Ec)),round(length(Ec)/2),length(Ec),1/(dt));

%% Dans quel sens ça nage ?
%cylindric_coord;
tl=[tracks((tracks(:,2)<pi & tracks(:,3)<pi) | (tracks(:,2)>pi & tracks(:,3)>pi),1);tracks((tracks(:,2)<pi & tracks(:,3)>pi) | (tracks(:,2)>pi & tracks(:,3)<pi),1)];
xl=[tracks((tracks(:,2)<pi & tracks(:,3)<pi) | (tracks(:,2)>pi & tracks(:,3)>pi),2);tracks((tracks(:,2)<pi & tracks(:,3)>pi) | (tracks(:,2)>pi & tracks(:,3)<pi),2)];
yl=[tracks((tracks(:,2)<pi & tracks(:,3)<pi) | (tracks(:,2)>pi & tracks(:,3)>pi),3);tracks((tracks(:,2)<pi & tracks(:,3)>pi) | (tracks(:,2)>pi & tracks(:,3)<pi),3)];
vxl=[tracks((tracks(:,2)<pi & tracks(:,3)<pi) | (tracks(:,2)>pi & tracks(:,3)>pi),4);-tracks((tracks(:,2)<pi & tracks(:,3)>pi) | (tracks(:,2)>pi & tracks(:,3)<pi),4)];
vyl=[tracks((tracks(:,2)<pi & tracks(:,3)<pi) | (tracks(:,2)>pi & tracks(:,3)>pi),5);tracks((tracks(:,2)<pi & tracks(:,3)>pi) | (tracks(:,2)>pi & tracks(:,3)<pi),5)];
rl=sqrt((mod(xl,pi)-pi/2).^2+(mod(yl,pi)-pi/2).^2);
thetal=[];
for kk=1:length(xl)
    if mod(yl(kk),pi)==pi/2 
        if mod(xl(kk),pi)>=pi/2
            thetal(kk)=0;
        else
            thetal(kk)=pi;
        end
    else
        thetal(kk)=atan((mod(yl(kk),pi)-pi/2)/(mod(xl(kk),pi)-pi/2));
        if mod(xl(kk),pi)<pi/2
            thetal(kk)=thetal(kk)+pi;
        end
    end
end
vtl=zeros(length(xl),1);
for kk=2:length(thetal)-1
    choix=[thetal(kk+1)-thetal(kk-1),2*pi+thetal(kk+1)-thetal(kk-1),-2*pi+thetal(kk+1)-thetal(kk-1)];
    if ~isempty(find(choix==min(abs(choix))))
        vtl(kk)=rl(kk)*choix(find(choix==min(abs(choix))))/2;
    else
        vtl(kk)=rl(kk)*choix(find(choix==-min(abs(choix))))/2;
    end
end

vxextl=amp_ec.*sin(xl).*cos(yl);
vyextl=-amp_ec.*cos(xl).*sin(yl);
vtextl=vxextl.*cos(thetal')+vyextl.*sin(thetal');

%%
% figure(1);
% imagesc(x0,y0,vxext)
% set(gca,'YDir','normal')
% figure(2);
% imagesc(x0,y0,vyext)
% set(gca,'YDir','normal')
% for i=1:round(length(mx)/20)
%     figure(1)
%     hold on;
%     plot(mx((i-1)*20+1:i*20),my((i-1)*20+1:i*20),'+')
%     hold off;
%     pause(3)
%     figure(2)
%     hold on;
%     plot(mx((i-1)*20+1:i*20),my((i-1)*20+1:i*20),'+')
%     hold off;
%     pause(3)
% end
    
%% Sauvegarde
fname=strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat');
save(strcat(fname(1:end-4),'_analyze.mat'),'dt','MeanSD','tau','Ec','countx','county','countax','countay','bin','fEc','SpEc')
