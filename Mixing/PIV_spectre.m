clear all;


param='Background sans correction, moyenne sur 200 im dans la zone stat';

run('E:\Clément\Mixing\Matlab\manips180329.m')

%%

for numVid=5
    dispstat('','init');
    dispstat(sprintf('Begining the calculation of direct spectra...'),'keepthis','timestamp');
    count=0;
    
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    directoryPiv=strcat(basePathAnalyse,date,set,video,'\PIV_fullimg\');
    
    %directoryPiv=strcat(basePathAnalyse,date,set,video,'\PIV_moinsrestr\');
    
    
    
    L=dir(strcat(directoryPiv,'4wind*.mat'));
    %get image
    
    
    load(strcat(directoryPiv,L(1).name));
    
    
    
    %  Calibrations pour PIV_moinsrest
    if strcmp(directoryPiv,strcat(basePathAnalyse,date,set,video,'\PIV_moinsrestr\'))==1
        calxy=0.000108152056655729; %obtenu grâce à la diagonale d'une image
        caluv=0.00216304113311457; %diagonale d'une image et 20fps
        %         x=x(6:50,10:65); %On ne garde que la région d'intérêt
        %         y=y(6:50,10:65);
        %         u=u(6:50,10:65);
        %         v=v(6:50,10:65);
    end
    %Calibrations pour PIV_fullimg
    if strcmp(directoryPiv,strcat(basePathAnalyse,date,set,video,'\PIV_fullimg\'))==1
        calxy=0.000151943077255372;
        caluv=0.00303886154510745;
        %         x=x(3:51,9:69);
        %         y=y(3:51,9:69);
        %         u=u(3:51,9:69);
        %         v=v(3:51,9:69);
        
        %         x=x(15:203,37:273);
        %         y=y(15:203,37:273);
        %         u=u(15:203,37:273);
        %         v=v(15:203,37:273);
    end
    
    
          x=x(15:203,37:273);
                y=y(15:203,37:273);
                u=u(15:203,37:273);
                v=v(15:203,37:273);
    X=(x-max(max(x))/2)*calxy*1000;%en mm
    Y=(y-max(max(y))/2)*calxy*1000;%en mm
    
    
    U=u*caluv*1000;%en mm/s
    V=v*caluv*1000;%en mm/s
    
    U=griddata(X(isnan(U)==0),Y(isnan(U)==0),U(isnan(U)==0),X,Y);
    V=griddata(X(isnan(V)==0),Y(isnan(V)==0),V(isnan(V)==0),X,Y);
    %     U=[U,fliplr(U)];
    %     V=[V,fliplr(V)];
    %     U(isnan(U))=0;
    %     V(isnan(V))=0;
    
    
    [SpLineU,fDirectU]=pwelch(U(1,:),hanning(length(U(1,:))),round(length(U(1,:))/2),length(U(1,:)),1/(X(1,2)-X(1,1)));
    [SpLineV,fDirectV]=pwelch(V(1,:),hanning(length(V(1,:))),round(length(V(1,:))/2),length(V(1,:)),1/(X(1,2)-X(1,1)));
    
    
    
    
    
    %get the size of the result and initialize
    SpMeanU=zeros(length(SpLineU),1);
    SpMeanV=zeros(length(SpLineV),1);
    
    
    
    
    
    %% La boucle de calcul
    %loop over 200 images of the stationnary zone (regularly spaced)
    %for k=(startCorr:round(length(indices)/Nstationary)*saut:endCorr)%+1
    for k=1:length(L)
        %get image
        load(strcat(directoryPiv,L(k).name));
        if strcmp(directoryPiv,strcat(basePathAnalyse,date,set,video,'\PIV_moinsrestr\'))==1
            calxy=0.000108152056655729; %obtenu grâce à la diagonale d'une image
            caluv=0.00216304113311457; %diagonale d'une image et 20fps
            %             x=x(6:50,10:65); %On ne garde que la région d'intérêt
            %             y=y(6:50,10:65);
            %             u=u(6:50,10:65);
            %             v=v(6:50,10:65);
        end
        %Calibrations pour PIV_fullimg
        if strcmp(directoryPiv,strcat(basePathAnalyse,date,set,video,'\PIV_fullimg\'))==1
            calxy=0.000151943077255372;
            caluv=0.00303886154510745;
            %         x=x(3:51,9:69);
            %         y=y(3:51,9:69);
            %         u=u(3:51,9:69);
            %         v=v(3:51,9:69);
            
            %         x=x(15:203,37:273);
            %         y=y(15:203,37:273);
            %         u=u(15:203,37:273);
            %         v=v(15:203,37:273);
        end
                x=x(15:203,37:273);
                y=y(15:203,37:273);
                u=u(15:203,37:273);
                v=v(15:203,37:273);
        X=(x-max(max(x))/2)*calxy*1000;%en mm
        Y=(y-max(max(y))/2)*calxy*1000;%en mm
        
        
        U=u*caluv*1000;%en mm/s
        V=v*caluv*1000;%en mm/s
        
        U=griddata(X(isnan(U)==0),Y(isnan(U)==0),U(isnan(U)==0),X,Y);
        V=griddata(X(isnan(V)==0),Y(isnan(V)==0),V(isnan(V)==0),X,Y);
        %     U=[U,fliplr(U)];
        %     V=[V,fliplr(V)];
        
        SpaddU=zeros(length(SpLineU),1);
        SpaddV=zeros(length(SpLineV),1);
        
        
        
        
        
        
        %loop over each line
        countbis=0;
        for i = 1:length(U(:,1))
            
            if sum(sum(isnan(U)))== 0 && sum(sum(isnan(V)))== 0
                countbis=countbis+1;
                [SpLineU,fDirectU]=pwelch(U(i,:),hanning(length(U(i,:)/2)),round(length(U(i,:))/2),length(U(i,:)),1/(X(1,2)-X(1,1)));
                [SpLineV,fDirectV]=pwelch(V(i,:),hanning(length(V(i,:)/2)),round(length(V(i,:))/2),length(V(i,:)),1/(X(1,2)-X(1,1)));
                
                SpaddU=SpaddU+SpLineU;
                SpaddV=SpaddV+SpLineV;
            end
            
        end
        if countbis ~=0
            SpaddU=SpaddU/countbis;
            SpaddV=SpaddV/countbis;
            
            
            count=count+1;
            
            SpMeanU=SpMeanU+SpaddU;
            SpMeanV=SpMeanV+SpaddV;
        end
        % timer
        dispstat(sprintf('Progress %d%%',round((k)*100/(length(L)))),'timestamp');
        
    end
    SpMeanU=SpMeanU/count;
    SpMeanV=SpMeanV/count;
    
    
    
    
    
    
    
    
    
    
    
    
    save(strcat(directoryPiv,'PIV_SpectreDirect_4wind.mat'),'fDirectU','fDirectV','SpMeanU','SpMeanV','param');
end
