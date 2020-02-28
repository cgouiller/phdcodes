%% Extrait des longueurs caract de Rcc

% clear all;
% run manips180329

N=[2,3,5,10,15,20,30,40,50,60];
L_int=zeros(1,10);
L_seuil50=zeros(1,10);
for numVid=2:11
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVidProcessed,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'RccSp_final.mat'));
    
    dRcc=zeros(1,length(RcccorS)-1);
    for i=1:length(RcccorS)-1
        dRcc(i)=RcccorS(i+1)-RcccorS(i);
    end
    
    
    compt=2;
    comptt=2;
    compttt=2;
    while RcccorS(compt)>0 && dRcc(compt-1)<0
        compt=compt+1;
    end
    while RcccorS(comptt)>0.5
        comptt=comptt+1;
    end
    
    
    L_int(numVid-1)=sum(RcccorS(1:compt)).*(dX(2)-dX(1));
    L_seuil50(numVid-1)=(comptt)*(dX(2)-dX(1));
    %save(strcat(directoryAnalyse,'echellesRcc'),'L_int','L_seuil50','N')
    for i=1:length(RcccorS)
   intRcc(numVid,i)=sum(RcccorS(1:i)); 
    end
    
end


figure;hold on;
plot(N,L_seuil50,'+','MarkerSize',15,'LineWidth',3)
% plot(N,L_int,'sb','MarkerSize',15,'LineWidth',3)
% legend('Seuil à 0,5','Echelle intégrale')
xlabel('Nombre de nageurs','Interpreter','latex')
ylabel('$\Delta$x$_{0,5}$ [mm]','Interpreter','latex')

% 
% for numVid=2:11
%     hold on;
%     color_line(dX,intRcc(numVid,:),ones(1,length(intRcc(numVid,:))).*numVid,'LineWidth',3);
%     hold off;
% end

plot(L_seuil50,depl,'+','MarkerSize',15,'LineWidth',3)
hold on
for ii=1:10
    text(L_seuil50(ii)-0.2,depl(ii)+1,num2str(N(ii)),'Color','k','FontSize',30)
end
    xlabel('$\Delta$x$_{0,5}$ [mm]','Interpreter','latex')
ylabel('Aire de la zone d\''epl\''et\''ee [cm$^2$]','Interpreter','latex')

% legend(videoCatalogue(2:11))
% ylabel('Int\''egrale de Rcc','Interpreter','latex')
% xlabel('Distance [mm]')


