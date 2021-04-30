%%
alphalist=[0,0.001,0.004,0.01,0.04,0.1,0.3,0.6,1,1.3,1.6,2,2.5,3,3.5,4,5,7,10];
Dcamplist=[0.15];
s0list=[1];
nt=10000;
old_nt=1;
taup=0;
dt=0.1/20;
inertie=0;
amp_ec=0;
npart=1;
advection=1;
%asrc=1;
rdomstart=1;
param_ecexterne=1;
Dnag=5;
sig0=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
siglist=[1]*sig0;
satur=0;
ecoulement=1;
marangoni=1;
L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.*

sig0=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs

cptgen=1;

for cpt1=5:length(alphalist)
    for cpt2=1:length(Dcamplist)
        for cpt3=1:length(s0list)
            for cpt4=1:length(siglist)
                    cptgen
                    alpha=alphalist(cpt1);
                    Dcamp=Dcamplist(cpt2);
                    asrc=s0list(cpt3);
                    sig=siglist(cpt4);
                    
                    seuilmin=0;
                    seuilmax=2;
                    
                    while seuilmax-seuilmin>0.01
                        A=(seuilmin+seuilmax)/2;
                        
                        
                        %% Initialisation des tableaux de stockage de valeurs
                        if old_nt==1 % Correspond à une simu jamais commencée
                            mx=zeros(nt,npart); %Tableaux des positions des nageurs
                            my=zeros(nt,npart);
                            muxp=zeros(nt,npart); % Tableaux des vitesses filtrées "sous le nageur"
                            muyp=zeros(nt,npart);
                            mvsx=zeros(nt,npart); % Tableaux des vitesses des nageurs
                            mvsy=zeros(nt,npart);
                            mvxnage=zeros(nt,npart); % Tableaux de la composante Marangoni de propulsion
                            mvynage=zeros(nt,npart);
                            mvfx=cell(200,1);   % Pour stocker quelques champs de vitesse, pas exploités en ce moment
                            mvfy=cell(200,1);
                        end
                        if old_nt~=1 % Correspond à une simu à poursuivre
                            muxpb=zeros(nt,npart);
                            muypb=zeros(nt,npart);
                            mvsxb=zeros(nt,npart);
                            mvsyb=zeros(nt,npart);
                            mvxnageb=zeros(nt,npart);
                            mvynageb=zeros(nt,npart);
                            muxpb(1:old_nt,1:npart)=muxp(1:old_nt,1:npart);
                            muypb(1:old_nt,1:npart)=muyp(1:old_nt,1:npart);
                            mvsxb(1:old_nt,1:npart)=mvsx(1:old_nt,1:npart);
                            mvsyb(1:old_nt,1:npart)=mvsy(1:old_nt,1:npart);
                            mvxnageb(1:old_nt,1:npart)=mvxnage(1:old_nt,1:npart);
                            mvynageb(1:old_nt,1:npart)=mvynage(1:old_nt,1:npart);
                            muxp=muxpb;
                            muyp=muypb;
                            mvsx=mvsxb;
                            mvsy=mvsyb;
                            mvxnage=mvxnageb;
                            mvynage=mvynageb;
                            
                            mxb=zeros(nt,npart);
                            myb=zeros(nt,npart);
                            mxb(1:old_nt,1:npart)=mx(1:old_nt,1:npart);
                            myb(1:old_nt,1:npart)=my(1:old_nt,1:npart);
                            mx=mxb;
                            my=myb;
                            
                            t=old_nt*dt;
                        end
                        
                        %% Début de la simu
                        
                        % profil source de camphre (centré en pi), qui correspond à un nageur
                        source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
                        % on centre la source en (0,0), translation de -pi en x et y
                        source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
                        
                        % on definit le filtre dans l'espace de fourier
                        gfilt_f=source0_f/sum(sum(source));
                        
                        source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
                        source0_f=asrc*source0_f; % Linéarité de la TF
                        
                        if old_nt==1
                            % Positions aléatoires des nageurs
                            if rdomstart==1
                                xp=2*pi*rand(1,npart);
                                yp=2*pi*rand(1,npart);
                            elseif rdomstart==2
                                xp=(pi/2-0.1)*ones(1,npart);
                                yp=(pi/2-0.1)*ones(1,npart);
                            elseif rdomstart==0
                                xp=pi/4*ones(1,npart);
                                yp=pi/4*ones(1,npart);
                            elseif rdomstart==3
                                xp=pi;
                                yp=pi/2-0.1;
                            elseif rdomstart==4
                                xp=[pi-sqrt(pi^2+(pi/tan(theta))^2)-delai,pi-pi/tan(theta)];
                                yp=[pi+0.00000001,0.00000001];
                            elseif rdomstart==5
                                xp=pi+0.00001;
                                yp=pi/2-0.1;
                            elseif rdomstart==6
                                xp=pi+0.00001;
                                yp=pi+0.00001;
                            end
                            
                            % vitesse initiale = vitesse locale de l'écoulement
                            if ecoulement==1
                                vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
                                vyfilt=real(ifft2(vyextf.*gfilt_f));
                                vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
                                vsy=interp2(x,y,vyfilt,xp,yp,'spline');
                                
                            end
                            if amp_ec==0 && npart==1
                                vsx=0.001; %Juste pour aider le sym breaking
                                vsy=0;
                            end
                            if amp_ec==0 && npart>1
                                angles=2*pi*rand(1,npart);
                                vsx=0.001*cos(angles);
                                vsy=0.001*sin(angles);
                                
                            end
                            if rdomstart==4
                                vsx=[1.554,1.554*cos(theta)];
                                vsy=[0,1.554*sin(theta)];
                            end
                            if rdomstart==6
                                vsx=0.000000000000001;
                                vsy=0;
                            end
                            % stockage de la position initiale
                            xs=xp;
                            ys=yp;
                            t=0;
                        end
                        
                        
                        %% Pas de temps 0
                        
                        % en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
                        % Ces exponentielles sont utiles pour résoudre l'éque diff et la faire
                        % progresser en temps:
                        k2=(kx.^2+ky.^2);
                        expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
                        expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
                        expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
                        
                        if old_nt==1
                            
                            
                            % initialisation t=0 du champ de camphre (une source à la position de
                            % chaque nageur)
                            Ccamp0_f=zeros(size(source0_f));
                            for nn=1:npart
                                Ccamp0_f=Ccamp0_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
                            end
                            Ccamp_f=Ccamp0_f;
                            %     if rdomstart==4
                            %         load('E:\Clément\MyCore\Analyse\SimuNum\Vortex\Cfieldmarang1.mat')
                            %         s=length(Ccampref);
                            %
                            %         [X,Y]=meshgrid(1:size(Ccampref,2),1:size(Ccampref,1));
                            %         pts=zeros(length(X).^2,2);
                            %         ptsf=zeros(length(X).^2,2);
                            %         pts(:,1)=X(:)-64;
                            %         pts(:,2)=Y(:)-64;
                            %         R=[cos(-theta), sin(-theta);-sin(-theta) cos(-theta)];
                            %         v=[s/2-64, s/2-64];
                            %
                            %         tt=v*R;
                            %         pts2=pts*R;
                            %         pts2(:,1)=pts2(:,1)+64;
                            %         pts2(:,2)=pts2(:,2)+64;
                            %
                            %         ptsf(:,1)=pts2(:,2)-tt(2);
                            %         ptsf(:,2)=pts2(:,1)-tt(1);
                            %
                            %         [Ccamprot,count]=bilinear_clement(Ccampref,ptsf);
                            %         Ccamp0_f=fft2(Ccampref).*exp(-1i*(xs(1)-pi)*kx-1i*(ys(1)-pi)*ky)+fft2(Ccamprot).*exp(-1i*(xs(2)-pi)*kx-1i*(ys(2)-pi)*ky);
                            %         Ccamp_f=Ccamp0_f;
                            %         end
                            
                            
                            % TF du champ de vitesse Marangoni du fluide en t=0
                            [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
                            
                            % Champ de vitesse total du fluide filtré et interpolé en t=0
                            % filtrage en fourier, interp dans l'espace physique
                            [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
                            
                            %Donne la vitesse filtrée sur chacun des nageurs
                            [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
                            if rdomstart==4
                                uxp=vsx;
                                uyp=vsy;
                            end
                            % Stockage pour les itérations de Adams-Bashforth
                            vsx_old=vsx;% vitesse des nageurs en t=0
                            vsy_old=vsy;% vitesse des nageurs en t=0
                            xs_old=xs;% position t=0
                            ys_old=ys;% position en t=0
                            uxp_old=uxp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
                            uyp_old=uyp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
                            
                            
                            
                            
                            %% Pas de temps en t=1/2
                            
                            % Source de camphre en t=1/2
                            source_f=zeros(size(source0_f));
                            for nn=1:npart
                                source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
                            end
                            
                            
                            % Calcul du terme d'advection (nul si advection=0)
                            Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
                            
                            Sfcamp=Sfcamp+source_f; % Puisqu'on a résolu par un changement de variable, on revient à celle de départ
                            Sfcamp_old=Sfcamp;% Stockage pour Adams-Bashforth
                            % calcul en t=1/2
                            Ccamp_f=expdt05.*(Ccamp_f + dt*Sfcamp/2); % Propagation du résultat de l'équa diff sur un demi pas de temps
                            Ccamp_f=Ccamp_f.*alias; %pour éviter les vecteurs d'ondes trop grands (aliasing)
                            
                            % calcul des positions et vitesses en t=1/2
                            [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt/2,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %0 car pas d'adams-bashforth ici
                            
                            
                            
                            
                            % TF du champ de vitesse Marangoni en t=1/2
                            [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
                            
                            
                            % Champ de vitesse filtré et interpolé en t=1/2
                            % filtrage en fourier, interp dans l'espace physique
                            [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
                            
                            %Donne la vitesse filtrée sur chacun des nageurs
                            [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
                            
                            
                            % On ne change pas les old ici car pour 2 ce seront t=0 et t=1 les
                            % importants
                            %% scalaire en t=1
                            
                            source_f=zeros(size(source0_f));
                            for nn=1:npart
                                source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
                            end
                            
                            % calcul du champ de camphreen t=1
                            Ccamp=real(ifft2(Ccamp_f));
                            
                            
                            % Calcul du terme d'advection du camphre (nul si advection=0)
                            Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
                            
                            Sfcamp=Sfcamp+source_f;
                            Sfcamp=Sfcamp.*alias;
                            
                            t=t+dt; % Le temps avance
                            Ccamp_f=expdt.*Ccamp0_f + dt*expdt05.*Sfcamp; % Evolution de l'équa dif de 1/2 à 1
                            Ccamp_f=Ccamp_f.*alias; % Pour éviter l'aliasing
                            
                            % calcul de la position et vitesse en dt, grâce à la vitesse en t=1/2. Les old sont
                            % ceux de t=0
                            [xs,ys,vsx,vsy]=eval_posvit(1,inertie,dt/2,xs_old,ys_old,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %
                            
                            % Calcul de la vitesse Marangoni (de propulsion) en t=1
                            % On en a besoin pour calculer le terme d'advection, mais on veut aussi
                            % stocker ce qu'ils valent aux positions des nageurs pour connaitre la
                            % direction de nage
                            vx=real(ifft2((vxf))); %TF-1 du champ de vitesse marangoni du fluide en fourier
                            vy=real(ifft2((vyf)));
                            [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
                            
                            %Stockage du premier pas de temps (t=1)
                            mx(1,1:npart)=xs(1,1:npart);
                            my(1,1:npart)=ys(1,1:npart);
                            muxp(1,1:npart)=uxp(1,1:npart);
                            muyp(1,1:npart)=uyp(1,1:npart);
                            mvsx(1,1:npart)=vsx(1,1:npart);
                            mvsy(1,1:npart)=vsy(1,1:npart);
                            mvxnage(1,1:npart)=vxnage(1,1:npart);
                            mvynage(1,1:npart)=vynage(1,1:npart);
                            
                        end
                        
                        
                        for in=old_nt+1:nt
                            
                            
                            
                            
                            Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
                            
                            Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
                            
                            % Position et vitesse des sources
                            [xsnew,ysnew,vsxnew,vsynew]=eval_posvit(1,inertie,dt,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); % Evolution de vitesse et position des nageurs
                            
                            % On actualise les variables, pour que les old soit toujours au temps
                            % in-1 et les normales au temps in
                            uxp_old=uxp;
                            uyp_old=uyp;
                            vsx_old=vsx;
                            vsy_old=vsy;
                            xs_old=xs;
                            ys_old=ys;
                            vsx=vsxnew;
                            vsy=vsynew;
                            xs=xsnew;
                            ys=ysnew;
                            
                            
                            % Calcul de la source de camphre à l'instant t, en Fourier
                            %source_f=source0_f.*exp(-1i*xs*kx-1i*ys*ky);
                            source_f=zeros(size(source0_f));
                            for nn=1:npart
                                source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
                            end
                            
                            Sfcamp_old=Sfcamp; %On stocke avant de remplacer
                            % calcul du terme d'advection
                            Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias); %advection est l'interrupteur on/off
                            Sfcamp=Sfcamp+source_f;
                            Sfcamp=Sfcamp.*alias;
                            
                            
                            % TF du champ de vitesse du fluide dû à Marangoni en t
                            [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
                            
                            % Champ de vitesse du fluide total filtré et interpolé en t
                            % filtrage en fourier, interp dans l'espace physique
                            [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
                            
                            %Donne la vitesse du fluide tot filtrée sur chacun des nageurs
                            [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
                            
                            % Composante Marangoni de la vitesse du nageur
                            vx=real(ifft2((vxf).*gfilt_f));
                            vy=real(ifft2((vyf).*gfilt_f));
                            [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
                            
                            t=t+dt;
                            
                            
                            mx(in,1:npart)=xs(1,1:npart);% position x
                            my(in,1:npart)=ys(1,1:npart);% position y
                            
                            
                        end
                        v=sqrt((mx(4000:end)-mx(3999:end-1)).^2+(my(4000:end)-my(3999:end-1)).^2);
                        vdic=1e-5;
                        if sum(v<1e-4)==0
                            seuilmax=A;
                        else
                            seuilmin=A;
                        end
                    end
                    seuil(cptgen)=(seuilmin+seuilmax)/2;
                    xalpha(cptgen)=alpha;
                    xDcamp(cptgen)=Dcamp;
                    xasrc(cptgen)=asrc;
                    xsig(cptgen)=sig;
                    cptgen=cptgen+1;
                
            end
        end
    end
end
alphabar=xalpha.*xsig.*xsig./xDcamp;
Mc=seuil.*xasrc./(xDcamp.*xDcamp);

save('E:/Clément/SimuNum/Resultats/seuilnage4.mat','alphabar','Mc','vdic')


%%


% alphalist=[1,2,4];
% Dcamplist=[0.075,0.15,0.3];
% s0list=[0.5,1,2];
% nt=5000;
% old_nt=1;
% taup=0;
% dt=0.1/20;
% inertie=0;
% amp_ec=0;
% npart=1;
% advection=1;
% %asrc=1;
% rdomstart=1;
% param_ecexterne=1;
% Dnag=5;
% sig0=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
% siglist=[0.5,1,2]*sig0;
% satur=0;
% ecoulement=1;
% marangoni=1;
% L = 2*pi; %Taille de la boîte
% N=128;%Résolution de la grille de simu
% make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
% [vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.*
% 
% sig0=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
% 
% %seuil=zeros(1,length(alphalist)*length(s0list)*length(siglist)*length(Dcamplist));
% cptgen=1;
% % xalpha=zeros(1,length(alphalist)*length(s0list)*length(siglist)*length(Dcamplist));
% % xDcamp=zeros(1,length(alphalist)*length(s0list)*length(siglist)*length(Dcamplist));
% % xasrc=zeros(1,length(alphalist)*length(s0list)*length(siglist)*length(Dcamplist));
% % xsig=zeros(1,length(alphalist)*length(s0list)*length(siglist)*length(Dcamplist));
% 
% for cpt1=1:length(alphalist)
%     for cpt2=1:length(Dcamplist)
%         for cpt3=1:length(s0list)
%             for cpt4=1:length(siglist)
%                     cptgen
%                     alpha=alphalist(cpt1);
%                     Dcamp=Dcamplist(cpt2);
%                     asrc=s0list(cpt3);
%                     sig=siglist(cpt4);
%                     
%                     seuilmin=0;
%                     seuilmax=10;
%                     
%                     while seuilmax-seuilmin>0.01
%                         A=(seuilmin+seuilmax)/2;
%                         
%                         
%                         %% Initialisation des tableaux de stockage de valeurs
%                         if old_nt==1 % Correspond à une simu jamais commencée
%                             mx=zeros(nt,npart); %Tableaux des positions des nageurs
%                             my=zeros(nt,npart);
%                             muxp=zeros(nt,npart); % Tableaux des vitesses filtrées "sous le nageur"
%                             muyp=zeros(nt,npart);
%                             mvsx=zeros(nt,npart); % Tableaux des vitesses des nageurs
%                             mvsy=zeros(nt,npart);
%                             mvxnage=zeros(nt,npart); % Tableaux de la composante Marangoni de propulsion
%                             mvynage=zeros(nt,npart);
%                             mvfx=cell(200,1);   % Pour stocker quelques champs de vitesse, pas exploités en ce moment
%                             mvfy=cell(200,1);
%                         end
%                         if old_nt~=1 % Correspond à une simu à poursuivre
%                             muxpb=zeros(nt,npart);
%                             muypb=zeros(nt,npart);
%                             mvsxb=zeros(nt,npart);
%                             mvsyb=zeros(nt,npart);
%                             mvxnageb=zeros(nt,npart);
%                             mvynageb=zeros(nt,npart);
%                             muxpb(1:old_nt,1:npart)=muxp(1:old_nt,1:npart);
%                             muypb(1:old_nt,1:npart)=muyp(1:old_nt,1:npart);
%                             mvsxb(1:old_nt,1:npart)=mvsx(1:old_nt,1:npart);
%                             mvsyb(1:old_nt,1:npart)=mvsy(1:old_nt,1:npart);
%                             mvxnageb(1:old_nt,1:npart)=mvxnage(1:old_nt,1:npart);
%                             mvynageb(1:old_nt,1:npart)=mvynage(1:old_nt,1:npart);
%                             muxp=muxpb;
%                             muyp=muypb;
%                             mvsx=mvsxb;
%                             mvsy=mvsyb;
%                             mvxnage=mvxnageb;
%                             mvynage=mvynageb;
%                             
%                             mxb=zeros(nt,npart);
%                             myb=zeros(nt,npart);
%                             mxb(1:old_nt,1:npart)=mx(1:old_nt,1:npart);
%                             myb(1:old_nt,1:npart)=my(1:old_nt,1:npart);
%                             mx=mxb;
%                             my=myb;
%                             
%                             t=old_nt*dt;
%                         end
%                         
%                         %% Début de la simu
%                         
%                         % profil source de camphre (centré en pi), qui correspond à un nageur
%                         source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
%                         % on centre la source en (0,0), translation de -pi en x et y
%                         source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
%                         
%                         % on definit le filtre dans l'espace de fourier
%                         gfilt_f=source0_f/sum(sum(source));
%                         
%                         source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
%                         source0_f=asrc*source0_f; % Linéarité de la TF
%                         
%                         if old_nt==1
%                             % Positions aléatoires des nageurs
%                             if rdomstart==1
%                                 xp=2*pi*rand(1,npart);
%                                 yp=2*pi*rand(1,npart);
%                             elseif rdomstart==2
%                                 xp=(pi/2-0.1)*ones(1,npart);
%                                 yp=(pi/2-0.1)*ones(1,npart);
%                             elseif rdomstart==0
%                                 xp=pi/4*ones(1,npart);
%                                 yp=pi/4*ones(1,npart);
%                             elseif rdomstart==3
%                                 xp=pi;
%                                 yp=pi/2-0.1;
%                             elseif rdomstart==4
%                                 xp=[pi-sqrt(pi^2+(pi/tan(theta))^2)-delai,pi-pi/tan(theta)];
%                                 yp=[pi+0.00000001,0.00000001];
%                             elseif rdomstart==5
%                                 xp=pi+0.00001;
%                                 yp=pi/2-0.1;
%                             elseif rdomstart==6
%                                 xp=pi+0.00001;
%                                 yp=pi+0.00001;
%                             end
%                             
%                             % vitesse initiale = vitesse locale de l'écoulement
%                             if ecoulement==1
%                                 vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
%                                 vyfilt=real(ifft2(vyextf.*gfilt_f));
%                                 vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
%                                 vsy=interp2(x,y,vyfilt,xp,yp,'spline');
%                                 
%                             end
%                             if amp_ec==0 && npart==1
%                                 vsx=0.001; %Juste pour aider le sym breaking
%                                 vsy=0;
%                             end
%                             if amp_ec==0 && npart>1
%                                 angles=2*pi*rand(1,npart);
%                                 vsx=0.001*cos(angles);
%                                 vsy=0.001*sin(angles);
%                                 
%                             end
%                             if rdomstart==4
%                                 vsx=[1.554,1.554*cos(theta)];
%                                 vsy=[0,1.554*sin(theta)];
%                             end
%                             if rdomstart==6
%                                 vsx=0.000000000000001;
%                                 vsy=0;
%                             end
%                             % stockage de la position initiale
%                             xs=xp;
%                             ys=yp;
%                             t=0;
%                         end
%                         
%                         
%                         %% Pas de temps 0
%                         
%                         % en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
%                         % Ces exponentielles sont utiles pour résoudre l'éque diff et la faire
%                         % progresser en temps:
%                         k2=(kx.^2+ky.^2);
%                         expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
%                         expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
%                         expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
%                         
%                         if old_nt==1
%                             
%                             
%                             % initialisation t=0 du champ de camphre (une source à la position de
%                             % chaque nageur)
%                             Ccamp0_f=zeros(size(source0_f));
%                             for nn=1:npart
%                                 Ccamp0_f=Ccamp0_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
%                             end
%                             Ccamp_f=Ccamp0_f;
%                             %     if rdomstart==4
%                             %         load('E:\Clément\MyCore\Analyse\SimuNum\Vortex\Cfieldmarang1.mat')
%                             %         s=length(Ccampref);
%                             %
%                             %         [X,Y]=meshgrid(1:size(Ccampref,2),1:size(Ccampref,1));
%                             %         pts=zeros(length(X).^2,2);
%                             %         ptsf=zeros(length(X).^2,2);
%                             %         pts(:,1)=X(:)-64;
%                             %         pts(:,2)=Y(:)-64;
%                             %         R=[cos(-theta), sin(-theta);-sin(-theta) cos(-theta)];
%                             %         v=[s/2-64, s/2-64];
%                             %
%                             %         tt=v*R;
%                             %         pts2=pts*R;
%                             %         pts2(:,1)=pts2(:,1)+64;
%                             %         pts2(:,2)=pts2(:,2)+64;
%                             %
%                             %         ptsf(:,1)=pts2(:,2)-tt(2);
%                             %         ptsf(:,2)=pts2(:,1)-tt(1);
%                             %
%                             %         [Ccamprot,count]=bilinear_clement(Ccampref,ptsf);
%                             %         Ccamp0_f=fft2(Ccampref).*exp(-1i*(xs(1)-pi)*kx-1i*(ys(1)-pi)*ky)+fft2(Ccamprot).*exp(-1i*(xs(2)-pi)*kx-1i*(ys(2)-pi)*ky);
%                             %         Ccamp_f=Ccamp0_f;
%                             %         end
%                             
%                             
%                             % TF du champ de vitesse Marangoni du fluide en t=0
%                             [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
%                             
%                             % Champ de vitesse total du fluide filtré et interpolé en t=0
%                             % filtrage en fourier, interp dans l'espace physique
%                             [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
%                             
%                             %Donne la vitesse filtrée sur chacun des nageurs
%                             [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
%                             if rdomstart==4
%                                 uxp=vsx;
%                                 uyp=vsy;
%                             end
%                             % Stockage pour les itérations de Adams-Bashforth
%                             vsx_old=vsx;% vitesse des nageurs en t=0
%                             vsy_old=vsy;% vitesse des nageurs en t=0
%                             xs_old=xs;% position t=0
%                             ys_old=ys;% position en t=0
%                             uxp_old=uxp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
%                             uyp_old=uyp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
%                             
%                             
%                             
%                             
%                             %% Pas de temps en t=1/2
%                             
%                             % Source de camphre en t=1/2
%                             source_f=zeros(size(source0_f));
%                             for nn=1:npart
%                                 source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
%                             end
%                             
%                             
%                             % Calcul du terme d'advection (nul si advection=0)
%                             Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
%                             
%                             Sfcamp=Sfcamp+source_f; % Puisqu'on a résolu par un changement de variable, on revient à celle de départ
%                             Sfcamp_old=Sfcamp;% Stockage pour Adams-Bashforth
%                             % calcul en t=1/2
%                             Ccamp_f=expdt05.*(Ccamp_f + dt*Sfcamp/2); % Propagation du résultat de l'équa diff sur un demi pas de temps
%                             Ccamp_f=Ccamp_f.*alias; %pour éviter les vecteurs d'ondes trop grands (aliasing)
%                             
%                             % calcul des positions et vitesses en t=1/2
%                             [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt/2,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %0 car pas d'adams-bashforth ici
%                             
%                             
%                             
%                             
%                             % TF du champ de vitesse Marangoni en t=1/2
%                             [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
%                             
%                             
%                             % Champ de vitesse filtré et interpolé en t=1/2
%                             % filtrage en fourier, interp dans l'espace physique
%                             [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
%                             
%                             %Donne la vitesse filtrée sur chacun des nageurs
%                             [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
%                             
%                             
%                             % On ne change pas les old ici car pour 2 ce seront t=0 et t=1 les
%                             % importants
%                             %% scalaire en t=1
%                             
%                             source_f=zeros(size(source0_f));
%                             for nn=1:npart
%                                 source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
%                             end
%                             
%                             % calcul du champ de camphreen t=1
%                             Ccamp=real(ifft2(Ccamp_f));
%                             
%                             
%                             % Calcul du terme d'advection du camphre (nul si advection=0)
%                             Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
%                             
%                             Sfcamp=Sfcamp+source_f;
%                             Sfcamp=Sfcamp.*alias;
%                             
%                             t=t+dt; % Le temps avance
%                             Ccamp_f=expdt.*Ccamp0_f + dt*expdt05.*Sfcamp; % Evolution de l'équa dif de 1/2 à 1
%                             Ccamp_f=Ccamp_f.*alias; % Pour éviter l'aliasing
%                             
%                             % calcul de la position et vitesse en dt, grâce à la vitesse en t=1/2. Les old sont
%                             % ceux de t=0
%                             [xs,ys,vsx,vsy]=eval_posvit(1,inertie,dt/2,xs_old,ys_old,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %
%                             
%                             % Calcul de la vitesse Marangoni (de propulsion) en t=1
%                             % On en a besoin pour calculer le terme d'advection, mais on veut aussi
%                             % stocker ce qu'ils valent aux positions des nageurs pour connaitre la
%                             % direction de nage
%                             vx=real(ifft2((vxf))); %TF-1 du champ de vitesse marangoni du fluide en fourier
%                             vy=real(ifft2((vyf)));
%                             [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad);
%                             
%                             %Stockage du premier pas de temps (t=1)
%                             mx(1,1:npart)=xs(1,1:npart);
%                             my(1,1:npart)=ys(1,1:npart);
%                             muxp(1,1:npart)=uxp(1,1:npart);
%                             muyp(1,1:npart)=uyp(1,1:npart);
%                             mvsx(1,1:npart)=vsx(1,1:npart);
%                             mvsy(1,1:npart)=vsy(1,1:npart);
%                             mvxnage(1,1:npart)=vxnage(1,1:npart);
%                             mvynage(1,1:npart)=vynage(1,1:npart);
%                             
%                         end
%                         
%                         
%                         for in=old_nt+1:nt
%                             
%                             
%                             
%                             
%                             Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
%                             
%                             Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
%                             
%                             % Position et vitesse des sources
%                             [xsnew,ysnew,vsxnew,vsynew]=eval_posvit(1,inertie,dt,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); % Evolution de vitesse et position des nageurs
%                             
%                             % On actualise les variables, pour que les old soit toujours au temps
%                             % in-1 et les normales au temps in
%                             uxp_old=uxp;
%                             uyp_old=uyp;
%                             vsx_old=vsx;
%                             vsy_old=vsy;
%                             xs_old=xs;
%                             ys_old=ys;
%                             vsx=vsxnew;
%                             vsy=vsynew;
%                             xs=xsnew;
%                             ys=ysnew;
%                             
%                             
%                             % Calcul de la source de camphre à l'instant t, en Fourier
%                             %source_f=source0_f.*exp(-1i*xs*kx-1i*ys*ky);
%                             source_f=zeros(size(source0_f));
%                             for nn=1:npart
%                                 source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
%                             end
%                             
%                             Sfcamp_old=Sfcamp; %On stocke avant de remplacer
%                             % calcul du terme d'advection
%                             Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias); %advection est l'interrupteur on/off
%                             Sfcamp=Sfcamp+source_f;
%                             Sfcamp=Sfcamp.*alias;
%                             
%                             
%                             % TF du champ de vitesse du fluide dû à Marangoni en t
%                             [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
%                             
%                             % Champ de vitesse du fluide total filtré et interpolé en t
%                             % filtrage en fourier, interp dans l'espace physique
%                             [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
%                             
%                             %Donne la vitesse du fluide tot filtrée sur chacun des nageurs
%                             [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
%                             
%                             % Composante Marangoni de la vitesse du nageur
%                             vx=real(ifft2((vxf).*gfilt_f));
%                             vy=real(ifft2((vyf).*gfilt_f));
%                             [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad);
%                             
%                             t=t+dt;
%                             
%                             
%                             mx(in,1:npart)=xs(1,1:npart);% position x
%                             my(in,1:npart)=ys(1,1:npart);% position y
%                             
%                             
%                         end
%                         v=sqrt((mx(4000:end)-mx(3999:end-1)).^2+(my(4000:end)-my(3999:end-1)).^2);
%                         if sum(v<1e-4)==0
%                             seuilmax=A;
%                         else
%                             seuilmin=A;
%                         end
%                     end
%                     seuil(cptgen)=(seuilmin+seuilmax)/2;
%                     xalpha(cptgen)=alpha;
%                     xDcamp(cptgen)=Dcamp;
%                     xasrc(cptgen)=asrc;
%                     xsig(cptgen)=sig;
%                     cptgen=cptgen+1;
%                 
%             end
%         end
%     end
% end
% alphabar=xalpha.*xsig.*xsig./xDcamp;
% Mc=seuil.*xasrc./(xDcamp.*xDcamp);
% 
% x=1./besselk(0,alphabar);
% x2=1./besselk(0,sqrt(alphabar));
% save('E:/Clément/SimuNum/Resultats/seuilnage2.mat','seuil','alphabar','x','Mc','x2','xDcamp','xsig','xasrc','xalpha')
%  plot(x2,Mc,'+k','LineWidth',2,'MarkerSize',20);xlabel('$1/K_0(\sqrt{\bar{\alpha}})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex')
% % xlim([0,1.7])
% % 
%  plot(x,Mc,'+k','LineWidth',2,'MarkerSize',20);xlabel('$1/K_0(\bar{\alpha})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex')
% % xlim([0,1.2])
% % 
% % figure;hold on;xlabel('$1/K_0(\bar{\alpha})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex');title('D')
% % plot(x(xDcamp==0.15),Mc(xDcamp==0.15),'+k')
% % plot(x(xDcamp==0.075),Mc(xDcamp==0.075),'+r')
% % plot(x(xDcamp==0.3),Mc(xDcamp==0.3),'+b')
% % 
% % figure;hold on;xlabel('$1/K_0(\bar{\alpha})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex');title('s0')
% % plot(x(xasrc==0.5),Mc(xasrc==0.5),'+k')
% % plot(x(xasrc==1),Mc(xasrc==1),'+r')
% % plot(x(xasrc==2),Mc(xasrc==2),'+b')
% % 
% % 
% % figure;hold on;xlabel('$1/K_0(\bar{\alpha})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex');title('sigma')
% % plot(x(xsig==xsig(1)),Mc(xsig==xsig(1)),'+k')
% % plot(x(xsig==xsig(2)),Mc(xsig==xsig(2)),'+b')
% % plot(x(xsig==xsig(3)),Mc(xsig==xsig(3)),'+r')
% % 
% % 
% % figure;hold on;xlabel('$1/K_0(\bar{\alpha})$','Interpreter','latex');ylabel('$M_c$','Interpreter','latex');title('alpha')
% % plot(x(xalpha==1),Mc(xalpha==1),'+k')
% % plot(x(xalpha==2),Mc(xalpha==2),'+b')
% % plot(x(xalpha==4),Mc(xalpha==4),'+r')
% % 
% % 
% 
