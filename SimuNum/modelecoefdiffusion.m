run defaultfig;
L=2*pi;
cols=['b','r','g','k','c','y','m'];
cpt=1;
Dlist=[];
airesdepl=[0.02935791,  0.0111084 , 0.00543213,   0.00311279, 0.00262451, 0.0022583 , 0.00476074]*L^2;
Nnagl=[7,15,25,45,70,100,150];
%secteff=0.8; %jusqu'au 210623!taille transverse du champ de camphre pour
%ce M (version 1)
secteff=26*2*pi/128; %(version f)
for ii=1:length(Nnagl)
    Nnag=Nnagl(ii)
    airedepl=airesdepl(ii);
   %if exist(strcat('E:\Clément\SimuNum\Resultats\modele_4_',num2str(Nnag),'.mat'))==0
        lpm=L^2/(Nnag*secteff); %(version1)
      %  lpm=(L^2-Nnag.*airedepl)./(Nnag*secteff); %(v2);
        
        
        
        % Pour A=1
        ti=[11.23617995,22.47369301,33.69402152,44.99557125,56.19956504,67.49523495,78.68395208,90.00074119,101.32623775, 112.51213168, 123.81846163, 134.99543832,146.31961993, 157.52709423, 168.81037634, 179.99975646,151.98248152, 163.14599308];
        tf=[ 12.85960949,  24.8989    ,  35.55193335,  41.41279106,46.21680011,  49.449228  ,  51.38526478,  52.44074323,52.84271122,  52.7842326 ,  52.53960055,  52.62756225,55.07973019,  72.03605114, 182.9582393 , 180.00118283,59.1496543 , 177.41730057];
        angleact=0;
        M=1/(0.15^2);
        Pe=1.00477438;
        v=Pe*0.15/0.0985;
        dt=lpm/v;
        mx=zeros(1,round(4e5/dt));
        my=zeros(1,round(4e5/dt));
        for i=2:length(mx)
            %anglei=rand(1,1)*180;% version <4
            anglei=rand(1,1)*180;
           % anglei=180/sqrt(2)*sqrt(1-cos(angleran));
            anglef=interp1(ti,tf,anglei);
            while anglef~=anglef
            anglei=rand(1,1)*180;
            anglef=interp1(ti,tf,anglei);
            %anglei=180/sqrt(2)*sqrt(1-cos(angleran));                anglef=interp1(ti,tf,anglei);
            end
            angleact=angleact+sign(rand(1,1)-0.5)*(anglef+anglei)/2;
            mx(i)=mx(i-1)+lpm*cos(pi/180*angleact);
            my(i)=my(i-1)+lpm*sin(pi/180*angleact);
        end
        mxtot=zeros(1,(length(mx)-1)*100);
        mytot=zeros(1,(length(my)-1)*100);

        for i=1:length(mx)-1
            mxtot(1,(i-1)*100+1:i*100)=linspace(mx(i),mx(i+1),100);
            mytot(1,(i-1)*100+1:i*100)=linspace(my(i),my(i+1),100);
        end
        [MeanSDx,mdx,taux]=msd(mxtot,dt/100,round(logspace(0,log10(length(mxtot)/3),100)));
        [MeanSDy,mdy,tauy]=msd(mytot,dt/100,round(logspace(0,log10(length(mxtot)/3),100)));
        MeanSD=MeanSDx+MeanSDy;
        tau=taux;
        clear mxtot;
        clear mytot;
      %  save(strcat('E:\Clément\SimuNum\Resultats\modele_1_',num2str(Nnag),'.mat'),'tau','MeanSD') 
      save(strcat('E:\Clément\SimuNum\Resultats\modele_f_',num2str(Nnag),'.mat'),'tau','MeanSD') 
%    else
%         load(strcat('E:\Clément\SimuNum\Resultats\modele_4_',num2str(Nnag),'.mat'))
%    end
    tau=tau/(0.0985^2/0.15);
    MeanSD=MeanSD/(0.0985^2);
    hold on;
    loglog(tau,MeanSD,cols(cpt));
    hold off;
    cpt=cpt+1;
    [P,~]=polyfit(tau(tau>500 & tau<5000),MeanSD(tau>500 & tau<5000),1);
    Dlist=[Dlist,P(1)/(4)];
end
legend({'7','15','25','45','70','100','150'})
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
figure;plot([7,15,25,45,70,100,150],Dlist,'+')
xlabel('N')
ylabel('Deff')
