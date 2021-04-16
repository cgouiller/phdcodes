run defaultfig;
L=2*pi;
cols=['b','r','g','k','c','y','m'];
cpt=1;
Dlist=[];
for Nnag=[7,15,25,45,70,100,150]
    Nnag
    if exist(strcat('E:\Clément\SimuNum\Resultats\modele_2_',num2str(Nnag),'.mat'))==0
%lpm=sqrt(L^2/Nnag); (version1)

secteff=0.8; %taille transverse du champ de camphre pour ce M
lpm=L^2/(Nnag*secteff);

mx=zeros(1,1000000);
my=zeros(1,1000000);

% Pour A=1
ti=[11.23617995,22.47369301,33.69402152,44.99557125,56.19956504,67.49523495,78.68395208,90.00074119,101.32623775, 112.51213168, 123.81846163, 134.99543832,146.31961993, 157.52709423, 168.81037634, 179.99975646,151.98248152, 163.14599308];
   tf=[ 12.85960949,  24.8989    ,  35.55193335,  41.41279106,46.21680011,  49.449228  ,  51.38526478,  52.44074323,52.84271122,  52.7842326 ,  52.53960055,  52.62756225,55.07973019,  72.03605114, 182.9582393 , 180.00118283,59.1496543 , 177.41730057];
       angleact=0;
M=1/(4*0.15^2);
Pe=0.43*sqrt(M-5.98);
       v=Pe*0.15/sqrt(4*pi*(2.5*2.5/90/90));
       dt=lpm/v;
   for i=2:length(mx)
       anglei=rand(1,1)*180;
       anglef=interp1(ti,tf,anglei);
       while anglef~=anglef
       anglei=rand(1,1)*180;
       anglef=interp1(ti,tf,anglei);
       end
    angleact=angleact+sign(rand(1,1)-0.5)*(anglef-anglei)/2;
    mx(i)=mx(i-1)+lpm*cos(pi/180*angleact);
    my(i)=my(i-1)+lpm*sin(pi/180*angleact);
   end
[MeanSDx,mdx,taux]=msd(mx,dt,round(logspace(0,log10(length(mx)/3),100)));
[MeanSDy,mdy,tauy]=msd(my,dt,round(logspace(0,log10(length(mx)/3),100)));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat('E:\Clément\SimuNum\Resultats\modele_2_',num2str(Nnag),'.mat'),'tau','MeanSD')
    else
        load(strcat('E:\Clément\SimuNum\Resultats\modele_2_',num2str(Nnag),'.mat'))
    end
hold on;
loglog(tau,MeanSD,cols(cpt));
hold off;
cpt=cpt+1;
[P,~]=polyfit(tau(tau>300 & tau<3000),MeanSD(tau>300 & tau<3000),1);
Dlist=[Dlist,P(1)];
end
legend({'7','15','25','45','70','100','150'})
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
figure;plot([7,15,25,45,70,100,150],Dlist,'+')
