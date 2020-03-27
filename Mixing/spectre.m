
load(strcat(directoryAnalyse,'Conc.mat'))
% start timer
dispstat('','init');
dispstat(sprintf('Begining the calculation of direct spectra...'),'keepthis','timestamp');


          load(strcat(directoryAnalyse,'directory.mat'));
%Load position of the swimmers
a=load(strcat(directoryAnalyse,'positions.mat'));
c=a.c;
    
%Load background image
imbg=load(strcat(directoryAnalyse,'im0'));
imbg=imbg.im0;
immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));

%%
%test de pwelch sur une image pour r?cup?rer la taille du vecteur r?sultat
%et initialiser les vecteurs qui accueilleront les spectres moyens

fname=L(startImg).name;
fnamecompl=strcat(directoryVid,fname);
im=double(imread(fnamecompl));
im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));

pos=[c(startImg).x,c(startImg).y,c(startImg).r];
pos=pos/calib;

Cfield=calc_CfieldBL(im,imbg,pos,immask);


%square inside circle
CfieldSq=Cfield(ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4),ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4));
% nan -> 0
CfieldSq(isnan(CfieldSq))=0;

%get a line and symetrize
line=CfieldSq(1,:);

%get the length of the full frame for the spectrum and gogogo pwelch
N=round(length(line));
[SpLine,f]=pwelch(line,hanning(N),round(N/2),N,1/calib);

%get the size of the result and initialize
SpMean=zeros(length(SpLine),1);
%mkdir(strcat(directoryAnalyse,'sauv\'))
aleat=round((rand(1,3000)*(find(time==65*60)-find(time==55*60)-1))+find(time==55*60));

%% Measure of all quantities for each image with Beer-Lambert
for kk=1:length(aleat)
    k=aleat(kk);
 
    
    %get image
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    
    pos=[];
    pos=[c(k).x,c(k).y,c(k).r];
    pos=pos/calib;
    Cfield=calc_CfieldBL(im,imbg,pos,immask);
    
    CfieldSq=Cfield(ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4),ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4));
            
    
    CfieldSq(isnan(CfieldSq))=-0.04; % Nécessaire parce que pwelch prend pas de NaN. On affecte donc la concentration en bdv adéquate : 0 puisqu'il y a le nageur
  %  CfieldSq=(CfieldSq-CMoySq(k))/CstdSq(k);
    
    
    Spadd=zeros(length(SpLine),1);
    
    %loop over each line
    for i = 1:length(CfieldSq)
        
        %calculate spectrum for the spatially reduced Cfield
        line=CfieldSq(i,:);
        
        N=round(length(line));
        SpLine=pwelch(line,hanning(N),round(N/2),N,1/calib);
        
        Spadd=Spadd+SpLine;
        
    end
    
    
    Spadd=Spadd/length(CfieldSq);
    
    
    %     SpMean=SpMean+Spadd;
    SpMean=SpMean+Spadd;
    
    
    
    
    % timer
    if mod(kk,50)==0
    dispstat(sprintf('Progress %d%%',round((kk*100/length(aleat)))),'timestamp');
    end
    
end


Sp=SpMean/length(aleat);


quefairedesnan='remplacé par -0.04 qui est à peu près la valeur dans la zone de depl';

% Save results !!!




save(strcat(directoryAnalyse,'Spectre.mat'),'f','Sp','quefairedesnan');


dispstat('Finished.','keepprev');