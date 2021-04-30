run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
%for ii=45:50

for ii=[45,48,50,271]
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    ii
            npart=manipCat.npart(ii);

    %if exist(strcat(directoryPyt,num2str(manipCat.video{ii}),'_pdfs.mat'))==0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        vxl=zeros(1,ceil(100000/npart)*npart);
        vyl=zeros(1,ceil(100000/npart)*npart);
        axl=zeros(1,ceil(100000/npart)*npart);
        ayl=zeros(1,ceil(100000/npart)*npart);
        cpt=1;
        
        for i=round(linspace(length(mx(:,1))/2,length(mx(:,1))-2,ceil(100000/npart)))
            vx=(mx(i+1,:)-mx(i-1,:))/(2*manipCat.dt(ii));
            vy=(my(i+1,:)-my(i-1,:))/(2*manipCat.dt(ii));
            ax=(mx(i+2,:)+mx(i-2,:)-2*mx(i,:))/(4*manipCat.dt(ii)*manipCat.dt(ii));
            ay=(my(i+2,:)+my(i-2,:)-2*my(i,:))/(4*manipCat.dt(ii)*manipCat.dt(ii));
            vxl(cpt:cpt+npart-1)=vx;
            vyl(cpt:cpt+npart-1)=vy;
            axl(cpt:cpt+npart-1)=ax;
            ayl(cpt:cpt+npart-1)=ay;
            cpt=cpt+npart;
        end
        [cvx,bvx] = hist_maison(vxl,min(vxl),max(vxl),30,1);
        [cvy,bvy] = hist_maison(vyl,min(vyl),max(vyl),30,1);
        [cax,bax] = hist_maison(axl,min(axl),max(axl),100,1);
        [cay,bay] = hist_maison(ayl,min(ayl),max(ayl),100,1);
        bvx=(bvx-mean(vxl))/std(vxl);
        bvy=(bvy-mean(vyl))/std(vyl);
        bax=(bax-mean(axl))/std(axl);
        bay=(bay-mean(ayl))/std(ayl);
        
        
        save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_pdfs.mat'),'bvx','cvx','bax','cax','bvy','cvy','bay','cay');
%     else
%         load(strcat(directoryPyt,num2str(manipCat.video{ii}),'_pdfs.mat'))
%         
%     end
    figure;
    hold on;
    plot(bvx,cvx,'-b')
    plot(bvy,cvy,'-r')
    plot(bax,cax,'-k')
    plot(bay,cay,'-g')
    legend({'vx','vy','ax','ay'})
    set(gca, 'YScale', 'log')
    xlabel('(s-<s>)/std')
    ylabel('pdf')
    title(num2str(npart))
    
    hold off;
end

%legend({'7','15','25','45','70','100'})
%legend({'7','45','100','150'})
%

