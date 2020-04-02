%% Fusionne les résultats aux différents temps pour la manip 180913

clear all;

fprintf('Concentration Fields Moments...');
fprintf('\n');

run('E:\Clément\Mixing\Matlab\manips180913.m');
timetot=(1:217000)/(20*60);
Cstdtot=[];
timetot=[];
timefilt=[];
Cstdfilt=[];
Cstdfiltstd=[];
CMoytot=[];
%%
for numVid=1:14
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,sete,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video,'\');
   % L=dir(strcat(directoryVid,'*.tif'));
    
    load(strcat(directoryAnalyse,'Conc.mat'));
    Cstdtot=[Cstdtot,Cstd];
    CMoytot=[CMoytot,CMoy];
    timetot=[timetot,str2num(video)*60+time];
%    Cstdtot(str2num(video)*60*20+startImgCatalogue(numVid):str2num(video)*60*20+length(L)-1)=Cstd;
%     for k=1:floor(length(Cstd)/300)
%         Cstdfilt=[Cstdfilt,mean(Cstd((k-1)*300+1:k*300))];
%         Cstdfiltstd=[Cstdfiltstd,std(Cstd((k-1)*300+1:k*300))];
%         timefilt=[timefilt,str2num(video)+(150+300*(k-1))/20/60];
%     end
    
end
time=timetot;
Cstd=Cstdtot;
CMoy=CMoytot;
save(strcat(basePathAnalyse,date,sete,'Conc.mat'),'time','Cstd','CMoy')
% Cstdfilt=Cstdfilt/0.035; %Normalisation radeau bdv dans cuve
% plot(timefilt,Cstdfilt,'+k','LineWidth',2,'MarkerSize',12)
% xlabel('temps [min]','Interpreter','latex')
% ylabel('$C_{std}$','Interpreter','latex')
% xlim([0 125])
% ylim([0 1.05])
% hold on;
% % create a new pair of axes inside current figure
% axes('position',[.65 .65 .25 .25])
% box on % put box around new pair of axes
% indexOfInterest = timefilt<10; % range of t near perturbation
% plot(timefilt(indexOfInterest),Cstdfilt(indexOfInterest),'+k','LineWidth',2,'MarkerSize',12) % plot on new axes
% axis tight
% %xlabel('temps [min]','Interpreter','latex','FontSize',20)
% %ylabel('$\sqrt{<C^2>-<C>^2}$','Interpreter','latex','FontSize',20)
% xlim([0 10])
% ylim([0 1.05])

% 
% 
% Cstdtot=Cstdtot/max(Cstdtot);
% plot(timetot,Cstdtot,'+')
% xlabel('temps [min]','Interpreter','latex')
% ylabel('$C_{std}$','Interpreter','latex')
% xlim([0 125])
% ylim([0 1.05])
% hold on;
% 
% 
% create a new pair of axes inside current figure
% axes('position',[.65 .65 .25 .25])
% box on % put box around new pair of axes
% indexOfInterest = timetot<10; % range of t near perturbation
% plot(timetot(indexOfInterest),Cstdtot(indexOfInterest),'+') % plot on new axes
% axis tight
% %xlabel('temps [min]','Interpreter','latex','FontSize',20)
% %ylabel('$\sqrt{<C^2>-<C>^2}$','Interpreter','latex','FontSize',20)
% xlim([0 10])
% ylim([0 1.05])

%pause(300);
%launcherCorrelation; 