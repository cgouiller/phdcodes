run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
%for ii=45:50
cpt=1;
for ii=[45,48,50,271]
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    ii
            npart=manipCat.npart(ii);

    if exist(strcat(directoryPyt,num2str(manipCat.video{ii}),'_corr.mat'))==0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));

        mx=mx(length(mx)/2:end,:);
        my=my(length(my)/2:end,:);
            vx=(mx(2:end,:)-mx(1:end-1,:))/(manipCat.dt(ii));
            vy=(my(2:end,:)-my(1:end-1,:))/(manipCat.dt(ii));
            ax=(vx(2:end,:)-vx(1:end-1,:))/(manipCat.dt(ii));
            ay=(vy(2:end,:)-vy(1:end-1,:))/(manipCat.dt(ii));
            vx=vx';
            vy=vy';
            ax=ax';
            ay=ay';
inc=round(logspace(0,log10(length(vx)/30),250));
tau=inc*manipCat.dt(ii);
Nmax=length(inc);
rvx=zeros(1,Nmax);
ivx=tau;
for k=1:length(ivx) 
    dx=vx(:,1+inc(k):end).*vx(:,1:end-inc(k));
    rvx(k)=mean(mean(dx))/mean(mean(vx.^2));
end

inc=round(logspace(0,log10(length(vy)/30),250));
tau=inc*manipCat.dt(ii);
Nmax=length(inc);
rvy=zeros(1,Nmax);
ivy=tau;
for k=1:length(ivy) 
    dx=vy(:,1+inc(k):end).*vy(:,1:end-inc(k));
    rvy(k)=mean(mean(dx))/mean(mean(vy.^2));
end

inc=round(logspace(0,log10(length(ax)/30),250));
tau=inc*manipCat.dt(ii);
Nmax=length(inc);
rax=zeros(1,Nmax);
iax=tau;
for k=1:length(iax) 
    dx=ax(:,1+inc(k):end).*ax(:,1:end-inc(k));
    rax(k)=mean(mean(dx))/mean(mean(ax.^2));
end

inc=round(logspace(0,log10(length(ay)/30),250));
tau=inc*manipCat.dt(ii);
Nmax=length(inc);
ray=zeros(1,Nmax);
iay=tau;
for k=1:length(iay) 
    dx=ay(:,1+inc(k):end).*ay(:,1:end-inc(k));
    ray(k)=mean(mean(dx))/mean(mean(ay.^2));
end

        
        
         save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_corr.mat'),'ivx','rvx','ivy','rvy','iax','iay','rax','ray');
     else
         load(strcat(directoryPyt,num2str(manipCat.video{ii}),'_corr.mat'))
         
    end
    figure(1);
    hold on;
    plot(ivx,rvx,cols(cpt),'linewidth',3)
    hold off;
    figure(2);
        hold on;
    plot(ivy,rvy,cols(cpt),'linewidth',3)
    hold off;
    figure(3);
        hold on;
    plot(iax,rax,cols(cpt),'linewidth',3)
    hold off;
    figure(4);
        hold on;
    plot(iay,ray,cols(cpt),'linewidth',3)
    hold off;
   
    
    cpt=cpt+1;
end

%legend({'7','15','25','45','70','100'})
%
figure(1);
    xlabel('$\tau$','Interpreter','latex')
    ylabel('Rvx')
    xlim([0,12])
legend({'7','45','100','150'})
figure(2);
    xlabel('$\tau$','Interpreter','latex')
    ylabel('Rvy')
        xlim([0,12])

legend({'7','45','100','150'})
figure(3);
    xlabel('$\tau$','Interpreter','latex')
    ylabel('Rax')
        xlim([0,12])

legend({'7','45','100','150'})
figure(4);
    xlabel('$\tau$','Interpreter','latex')
    ylabel('Ray')
        xlim([0,12])

legend({'7','45','100','150'})

  %  set(gca, 'YScale', 'log')

