clear all;
run('E:\Clément\Mixing\Matlab\manips180329.m');


%video processed
%numVid=5;
for numVid=3:8
    set=strjoin(setCatalogue(numVid));
    video=strjoin(videoCatalogue(numVid));
    
    %paths
    directoryVid=strcat('E:\Clément\Mixing\Analyse\',date,set,video,'\processed\');
    directoryAnalyse=strcat('E:\Clément\Mixing\Analyse\',date,set,video);
    
    load(strcat(directoryAnalyse,'\','trailtest.mat'))
    R=sizeim/2*calib;
    dispstat('','init');
    dispstat(sprintf('Begining the trajectory analysis...'),'keepthis','timestamp');
    
    
    
    tracks = sortrows(tracks,4);
    nbpart=tracks(length(tracks(:,1)),4);
    
    
    
    compteur=1;
    liste=zeros(nbpart,1);
    for i=1:nbpart
        %Repérer toutes les images correspondant à une particule
        
        test=0;
        while(test==0) && compteur<=length(tracks(:,1))
            if i==1
                if tracks(compteur,4)==tracks(1,4)
                    compteur=compteur+1;
                    
                else
                    test=1;
                    
                    liste(i)=compteur-1; % liste(i) contient le numéro de la dernière ligne portant sur la particule i
                    
                    
                end
            else
                if tracks(compteur,4)==tracks(liste(i-1)+1,4)
                    compteur=compteur+1;
                    
                else
                    test=1;
                    
                    liste(i)=compteur-1; % liste(i) contient le numéro de la dernière ligne portant sur la particule i
                    
                    
                end
            end
        end
        %Tri à l'intérieur de chaque trajectoire
        if i==1
            tracks(1:liste(i)) = sortrows(tracks(1:liste(i)),3);
            
        else
            
            tracks(1+liste(i-1):liste(i),:) = sortrows(tracks(1+liste(i-1):liste(i),:),3);
            
        end
        
    end
    
    %Calculer les vitesses le long de chaque trajectoire, puis l'angle que
    %fait la trajectoire
    tracks(:,9)=zeros(length(tracks(:,1)),1);
    tracks(:,10)=zeros(length(tracks(:,1)),1);
    tracks(:,11)=zeros(length(tracks(:,1)),1);
    tracks(:,12)=zeros(length(tracks(:,1)),1);
    sample=[];
    for i=2:length(tracks(:,1))
        if tracks(i,4)==tracks(i-1,4) && tracks(i-1,3)+1==tracks(i,3)
            tracks(i,9)=(tracks(i,1)-tracks(i-1,1))*fps;
            tracks(i,10)=(tracks(i,2)-tracks(i-1,2))*fps;
            tracks(i,11)=sqrt(tracks(i,9)*tracks(i,9)+tracks(i,10)*tracks(i,10));
            tracks(i,12)=-atan(tracks(i,9)/tracks(i,10)); %le - vient du fait que y vers le bas dans nos images
            if tracks(i,10)<0
                tracks(i,12)=tracks(i,12)+pi;
            end
            
        end
    end
    stock=[];
    stockd=[];
    tracks = sortrows(tracks,3);
    
    for i=1:length(tracks(:,1))
        if mod(i,100)==0
            dispstat(sprintf('Progress %i%%',round(i*100/(length(tracks(:,1))))),'timestamp');
        end
        if tracks(i,11)>100 %Enlever les valeurs abhérentes
            tracks(i,11)=0;
        end
        compteur=1;
        ttest=0;
        while ttest==0
            if tracks(compteur,3)==tracks(i,3)
                ttest=1;
                deb=compteur;
                stockd=[stockd,deb];
            else
                compteur=compteur+1;
            end
        end
        while ttest==1
            if compteur == length(tracks(:,1))
                fin=compteur;
                ttest=0;
            elseif tracks(compteur,3)==tracks(i,3) && compteur <length(tracks(:,1))
                compteur=compteur+1;
                
            else
                ttest=0;
                fin=compteur-1;
            end
            
        end
        samp=[];
        samp=tracks(deb:fin,1:2);
        
        if tracks(i,11)~=0
            test=0;
            %On définit le rectangle dans lequel les particules ne doivent pas être
            %             xv=[tracks(i,1)+9*cos(tracks(i,12))-14*sin(tracks(i,12)),tracks(i,1)+9*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))-14*sin(tracks(i,12))];
            %             yv=[tracks(i,2)+14*cos(tracks(i,12))+9*sin(tracks(i,12)),tracks(i,2)+9*sin(tracks(i,12))-14*cos(tracks(i,12)),tracks(i,2)-14*cos(tracks(i,12))-32*sin(tracks(i,12)),tracks(i,2)+14*cos(tracks(i,12))-32*sin(tracks(i,12)),];
             xv=[tracks(i,1)+6*cos(tracks(i,12))-10*sin(tracks(i,12)),tracks(i,1)+6*cos(tracks(i,12))+10*sin(tracks(i,12)),tracks(i,1)-20*cos(tracks(i,12))+10*sin(tracks(i,12)),tracks(i,1)-20*cos(tracks(i,12))-10*sin(tracks(i,12))];
             yv=[tracks(i,2)+10*cos(tracks(i,12))+6*sin(tracks(i,12)),tracks(i,2)+6*sin(tracks(i,12))-10*cos(tracks(i,12)),tracks(i,2)-10*cos(tracks(i,12))-20*sin(tracks(i,12)),tracks(i,2)+10*cos(tracks(i,12))-20*sin(tracks(i,12)),];

            for j=1:length(samp(:,1))
                if inpolygon(samp(j,1),samp(j,2),xv,yv)
                    if deb-1+j~=i
                        test=1;
                    end
                end
            end
            
            dCenter=sqrt((tracks(i,1)-R)^2+(tracks(i,2)-R)^2);
            stock=[stock,dCenter];
            if tracks(i,11)~=0 && dCenter<65 && test==0
                sample=[sample;tracks(i,:)];
            end
        end
    end
    %sample_bubfree=sample;
    save(strcat(directoryAnalyse,'\','sample_moinsrestrictif.mat'),'sample')
end
%Parmi les présentes à chaque frame, regarder celles qui sont assez
%loin du bord et de leurs voisines. Les sauvegarder.

%Les envoyer dans measure trail