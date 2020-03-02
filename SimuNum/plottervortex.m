clear all;close all;run defaultfig;
L=dir('E:\Clément\SimuNum\Resultats\*.mat');
list=round(logspace(0,4,100)); %Pour l'affichage de 100 points répartis logarithmiquement
figure(1);axes('XScale','log','YScale','log');
%figure(2);axes('XScale','log','YScale','log');
for i=1:length(L)
    load(strcat('E:\Clément\SimuNum\Resultats\',L(i).name));
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
    if npart==1
        col='g';
    else if npart==7
            col='r';
        else if npart==15
                col='b';
            else if npart==30
                    col='k';
                end
            end
        end
    end
    if amp_ec==0
        mark='+';
    else if amp_ec==3
            mark='o';
        else if amp_ec==6
                mark='d';
            end
        end
    end
    meanmsdrepr=meanmsd./(2*r2moy);
    if npart>1
         name=strcat(num2str(npart),' particules et amplitude vortex ',num2str(amp_ec));

    figure(1);hold on;plot(100*dt(list),meanmsdrepr(list),'Color',col,'Marker',mark,'MarkerSize',10,'LineWidth',1,'DisplayName',name);hold off;
  %  figure(2);hold on;loglog(f,Sp,'Color',col,'Marker',mark,'MarkerSize',10,'LineWidth',1,'DisplayName',name);hold off;

    end
end
legend show
xlabel('Nombre de pas de temps')
ylabel('$\frac{\sigma^2_{MSD}}{2<r^2>}$','Interpreter','latex')
grid