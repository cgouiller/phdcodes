fprintf('Beginning research of correction factors...');
fprintf('\n');


%%
% load things calculated before
%load(strcat(directoryAnalyse,'Conc.mat'));
load(strcat(directoryAnalyse,'Corr200.mat'));

%spatial step for fft
dXfft=dX(2)-dX(1);

% non-corrected correlation functions and fft and spectra
%temporal
% RccnoncorT=(2*dC2MoyTT-S2)/(2*(dC2MoyTT));
% RccnoncorTsym=[flipud(RccnoncorT);RccnoncorT];
% N=length(RccnoncorTsym);
% SpnoncorT=fft(RccnoncorTsym,N);
% SpwelchnoncorT= pwelch(RccnoncorTsym,hanning(N),N/4,N,1/calib);

%spatial
RccnoncorS=(2*dC2MoyST-S2)/(2*(dC2MoyST));
RccnoncorSsym=[flipud(RccnoncorS);RccnoncorS];



%% corrected correlation function fft and spectra
%temporal

% supT=dC2MoyTT-1E-9;
% infT=0;

% dichotomia
% while supT-infT>1E-6
%     
%     RccnoncorSupT=(2*dC2MoyTT-S2)/(2*(dC2MoyTT-supT));
%     RccnoncorInfT=(2*dC2MoyTT-S2)/(2*(dC2MoyTT-infT));
%     fitobjectSup=fit(dX(6:10)',RccnoncorSupT(6:10),'poly1');
%     fitobjectInf=fit(dX(6:10)',RccnoncorInfT(6:10),'poly1');
%     
%     if abs(fitobjectSup.p2-1) < abs(fitobjectInf.p2-1)
%         infT=(supT+infT)/2;
%     else
%         supT=(supT+infT)/2;
%     end
%     
% end
% 
% varBruitT=(infT+supT)/2;
% 
% RcccorT=(2*dC2MoyTT-S2)/(2*(dC2MoyTT-varBruitT));
% RcccorsymT=[flipud(RcccorT);RcccorT];
% N=length(RcccorsymT);
% SpcorT=fft(RcccorsymT,N);
% SpwelchcorT=pwelch(RcccorsymT,hanning(N),N/4,N,1/calib);

%Moyennes spatiales
supS=dC2MoyST-1E-9;
infS=0;
while supS-infS>1E-6
    
    RccnoncorSupS=(2*dC2MoyST-S2)/(2*(dC2MoyST-supS));
    RccnoncorInfS=(2*dC2MoyST-S2)/(2*(dC2MoyST-infS));
    fitobjectSup=fit(dX(6:10)',RccnoncorSupS(6:10),'poly1');
    fitobjectInf=fit(dX(6:10)',RccnoncorInfS(6:10),'poly1');
    
    if abs(fitobjectSup.p2-1) < abs(fitobjectInf.p2-1)
        infS=(supS+infS)/2;
    else
        supS=(supS+infS)/2;
    end
    
end

varBruitS=(infS+supS)/2;

RcccorS=(2*dC2MoyST-S2)/(2*(dC2MoyST-varBruitS));
RcccorsymS=[flipud(RcccorS);RcccorS];
N=length(RcccorsymS);
SpcorS=fft(RcccorsymS,N);
Spnonsym=fft(RcccorS,round(length(RcccorS)/2));

%% SAVE EVERYFUCKINGTHING

ppath=strcat(directoryAnalyse,'RccSp_final.mat');
k=1/(2*dXfft)*linspace(0,1,N/2-1);
knet = (0:1:length(RcccorsymS)-1)*(1/dXfft)/N;
knonsym=(0:1:length(RcccorS)-1)*(1/dXfft)/length(RcccorS);
save(ppath,'dX','k','RccnoncorS','RcccorS','SpcorS','param','knet','knonsym','Spnonsym');

