clear all;close all;run defaultfig;
ncat=[7,15,30,40,1,1,1,1];
ampeccat=[0,0,0,0,0,2,4,6];
manipCat={strcat('E:\Clément\SimuNum\Resultats\200318\varN\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\15.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\30.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\40.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\0.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\6.mat')};

list=round(logspace(0,4,100)); %Pour l'affichage de 100 points répartis logarithmiquement
figure(1);axes('XScale','log','YScale','log');
figure(2);axes('XScale','log','YScale','log');

% MSD et Spectre
%for i=1:length(varN)

for ii=5:8
        load(manipCat{ii});

    mamsd=ma.getMeanMSD;
    dt=mamsd(:,1);
    meanmsd=mamsd(:,2);
    stdmsd=mamsd(:,3);
    Sp=(Spx+Spy)/2;
    r2moy=zeros(length(meanmsd),1);
    
    for j=1:npart
        tab=ma.tracks{j,1};
        r2moy=r2moy+(tab(:,2)-pi).^2+(tab(:,3)-pi).^2;
    end
    r2moy=r2moy/npart;
    if mod(ii,4)==1
        col='g';
    else if mod(ii,4)==2
            col='r';
        else if mod(ii,4)==3
                col='b';
            else if mod(ii,4)==0
                    col='k';
                    
                end
            end
        end
    end
    %         if npart==1
    %             col='g';
    %         else if npart==7
    %                 col='r';
    %             else if npart==15
    %                     col='b';
    %                 else if npart==30
    %                         col='k';
    %                     elseif npart==40
    %                         col='g';
    %                     end
    %                 end
    %             end
    %         end
    %         if amp_ec==0
    %             mark='+';
    %         else if amp_ec==3
    %                 mark='o';
    %             else if amp_ec==6
    %                     mark='d';
    %                 end
    %             end
    %         end
    meanmsdrepr=meanmsd./(2*r2moy);
    % if npart>1
    name=strcat(num2str(npart),' particules et amplitude vortex ',num2str(amp_ec));
    
     figure(1);hold on;plot(100*dt(list),meanmsdrepr(list),'Color',col,'Marker','+','MarkerSize',10,'LineWidth',1,'DisplayName',name);hold off;
    figure(2);hold on;loglog(f,Sp,'Color',col,'Marker','+','MarkerSize',10,'LineWidth',1,'DisplayName',name);hold off;
    
    %end
end
%end
figure(1);
legend show
xlabel('Nombre de pas de temps')
ylabel('$\frac{\sigma^2_{MSD}}{2<r^2>}$','Interpreter','latex')
grid;
figure(2);
legend show
xlabel('Fréquence')
ylabel('pwelch moyen')
grid


%% Energie cinétique et PDF
%axes('YScale','log');
ncat=[7,15,30,40,1,1,1,1];
ampeccat=[0,0,0,0,0,2,4,6];
manipCat={strcat('E:\Clément\SimuNum\Resultats\200318\varN\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\15.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\30.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\40.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\0.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\6.mat')};
for ii=5:8

    npart=ncat(ii);
    amp_ec=ampeccat(ii);
    load(strcat(manipCat{ii}(1:end-4),'_analyze.mat'))
    if mod(ii,4)==0
        col='g';
    else if mod(ii,4)==1
            col='r';
        else if mod(ii,4)==2
                col='b';
            else if mod(ii,4)==3
                    col='k';
                    
                end
            end
        end
    end
    
    
    
    name=strcat(num2str(npart),' particules et amplitude vortex ',num2str(amp_ec));
   % figure(1);hold on;plot(100*dt(1:1000:length(dt)),Ec(1:1000:length(dt)),'Color',col,'Marker','+','MarkerSize',10,'LineWidth',1,'DisplayName',name);hold off;
    figure;
    semilogy(binx,countx);hold on;semilogy(biny,county,'r');semilogy(binax,countax,'+');semilogy(binay,countay,'+r');
    legend({'vx','vy','ax','ay'});
    title(num2str(amp_ec))
    xlabel('$(s-<s>)/\sigma_s$','Interpreter','latex')
    ylabel('PDF')
    
    
end
% figure(1);
% legend show
% ylim([0 2.5])
%     grid
% xlabel('pas de temps')
% ylabel('Energie cinétique moyenne par particule')%
