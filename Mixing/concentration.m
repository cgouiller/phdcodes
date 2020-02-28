%% Calcule les grandeurs globales et leur évolution temporelle (Cmoy, Cstd...) avec l'hypothèse d'absorption Beer-Lambert par les glass bubbles.

fprintf('Video ');
fprintf(video(1:length(video)-1));
fprintf('\n');



%list the processed images/Cfield
load(strcat(directoryAnalyse,'directory.mat'));
%load(strcat(directoryAnalyse,'nagcor.mat'));


%% Initializations

CMoy=zeros(length(L),1);
CMoySq=zeros(length(L),1);
C2MoySq=zeros(length(L),1);
C2Moy=zeros(length(L),1);
time=zeros(length(L),1);
%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the process for the movie with Beer-Lambert...'),'keepthis','timestamp');

%Load position of the swimmers
a=load(strcat(directoryAnalyse,'positions.mat'));
c=a.c;
    
%Load background image
imbg=load(strcat(directoryAnalyse,'im0'));
imbg=imbg.im0;

immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));


%% Measure of all quantities for each image with Beer-Lambert
for k=startImg:length(L)
    % Open the image and calculate the concentration field
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    %figure;
    %imagesc(imbg,[160 190]);axis square; colorbar;colormap gray(256)
    if NCat(numVid)>0
        pos=[c(k).x,c(k).y,c(k).r];
        pos=pos/calib;
    else
        pos=[];
    end
  %  figure;
    
    Cfield=calc_CfieldBL(im,imbg,pos,immask);
%     imagesc(Cfield,[-0.1 0.1]);axis square; colorbar;colormap parula(256)
%     pause(0.1);
    time(k)=str2double(fname(1:7))/fps;
    
    % measure all quantities from the field
    sizecf=length(Cfield);
    
    
    %Define the square useful for correlation studies and calculate the
    %same quantities
   % CfieldSq=Cfield(ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4),ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4));
    
    
    CMoy(k)=nanmean2(Cfield);
   % CMoySq(k)=nanmean2(CfieldSq);
    C2Moy(k)=nanmean2(Cfield.*Cfield);
   % C2MoySq(k)=nanmean2(CfieldSq.*CfieldSq);
     
    % timer
    if (mod(k-1,100)==0)
        dispstat(sprintf('Progress %d%%',round((k-startImg)*100/(length(L)-startImg))),'timestamp');
    end
   
        
end

%%
%standard deviation of the Cfield
Cstd=sqrt(C2Moy - CMoy.^2); 
%CstdSq=sqrt(C2MoySq - CMoySq.^2); plot%#ok<NASGU>


param='sans aucune correction';


save(strcat(directoryAnalyse,'ConcBL.mat'),'time','CMoy','C2Moy','Cstd','param')


% %% Initializations
% 
% 
% CMoy=zeros(length(L),1);
% CMoySq=zeros(length(L),1);
% C2MoySq=zeros(length(L),1);
% C2Moy=zeros(length(L),1);
% 
% 
% %Initialize the clock
% dispstat('','init'); % One time only initialization
% dispstat(sprintf('Begining the process for the movie with linear concentration...'),'keepthis','timestamp');
% 
% %Load position of the swimmers
% a=load(strcat(directoryAnalyse,'\positions.mat'));
% c=a.c;
%     
% %Load background image
% imbg=load(strcat(directoryAnalyse,'\im0'));
% imbg=imbg.im0;
%   
% 
% %% Measure of all quantities for each image with Beer-Lambert
% for k=1:length(L)
%     
%     % Open the image and calculate the concentration field
%     fname=L(k).name;
%     fnamecompl=strcat(directoryVid,fname);
%     im=double(imread(fnamecompl));
%     im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
%     pos=[c(k).x,c(k).y,c(k).r];
%     pos=pos/calib;
%     Cfield=calc_Cfieldlin(im,imbg,pos);
%     
%     
%     % measure all quantities from the field
%     sizecf=length(Cfield);
%     
%     
%     %Define the square useful for correlation studies and calculate the
%     %same quantities
%     CfieldSq=Cfield(ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4),ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4));
%     
%     
%     CMoy(k)=nanmean(nanmean(Cfield));
%     CMoySq(k)=nanmean(nanmean(CfieldSq));
%     C2Moy(k)=nanmean(nanmean(Cfield.*Cfield));
%     C2MoySq(k)=nanmean(nanmean(CfieldSq.*CfieldSq));
%      
%     % timer
%     if (mod(k,100)==0)
%         dispstat(sprintf('Progress %d%%',round(k*100/length(L))),'timestamp');
%     end
%         
% end
% 
% %%
% %standard deviation of the Cfield
% Cstd=sqrt(C2Moy - CMoy.^2);
% CstdSq=sqrt(C2MoySq - CMoySq.^2);
% 
% 
% %time vector
% time=(1:length(L))'/fps;
% 
% 
% save(strcat(directoryAnalyse,'\Conclin.mat'),'time','CMoy','C2Moy','Cstd','CMoySq','C2MoySq','CstdSq')
% 
% %end of the timer
% dispstat('Finished.','keepprev');