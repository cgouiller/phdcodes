load(manipCat{ii});
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
for j=1:npart
    newpart=ma.tracks{j};
    for k=2:length(newpart)-1
        newpart(k,4)=(newpart(k+1,2)-newpart(k-1,2))/(newpart(k+1,1)-newpart(k-1,1))-interp2(xpad,ypad,vxfiltpad,mod(newpart(k,2),2*pi),mod(newpart(k,3),2*pi));
        newpart(k,5)=(newpart(k+1,3)-newpart(k-1,3))/(newpart(k+1,1)-newpart(k-1,1))-interp2(xpad,ypad,vyfiltpad,mod(newpart(k,2),2*pi),mod(newpart(k,3),2*pi));
        newpart(k,7)=(newpart(k+1,4)-newpart(k-1,4))/(newpart(k+1,1)-newpart(k-1,1));
        newpart(k,8)=(newpart(k+1,5)-newpart(k-1,5))/(newpart(k+1,1)-newpart(k-1,1));
    end
    newpart(1,4)=NaN;
    newpart(length(newpart),4)=NaN;
    newpart(length(newpart),5)=NaN;
    newpart(:,6)=sqrt(newpart(:,4).^2+newpart(:,5).^2);
    
    tracks=[tracks;newpart];
    
end
for k=1:length(newpart)
    Ec(k)=1/2*sum(tracks(tracks(:,1)==tracks(k,1),6).^2);
end
Ec=Ec/npart;
mamsd=ma.getMeanMSD;
dt=mamsd(:,1);
%
[countx,binx]=hist_maison((tracks(:,4)-nanmean2(tracks(:,4)))/nanstd(tracks(:,4)),-5,5,101,1);
[county,biny]=hist_maison((tracks(:,5)-nanmean2(tracks(:,5)))/nanstd(tracks(:,5)),-5,5,101,1);
[countax,binax]=hist_maison((tracks(:,7)-nanmean2(tracks(:,7)))/nanstd(tracks(:,7)),-5,5,101,1);
[countay,binay]=hist_maison((tracks(:,8)-nanmean2(tracks(:,8)))/nanstd(tracks(:,8)),-5,5,101,1);
save(strcat(manipCat{ii}(1:end-4),'_analyze.mat'),'dt','Ec','tracks','countx','county','countax','countay','binx','biny','binax','binay')
