fps=1/dt;
px=1;
Ndecim = 10;
load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mxbg','mybg');

%%
%load('25.mat');
vtracks=mat2tracks(mxbg(:,1:200),mybg(:,1:200));

%%
%% Calcul des vitesses et accélérations
w=5;
L=3*w;
kerp = posfiltcoef(w,L);
%kerv = velfiltcoef(w,L);
%kera = accfiltcoef(w,L);
tic
if ~exist('Nmax')
    vtracks = addStructFun(vtracks,'X','Xf',@(X)(conv(X,kerp,'valid')*px));
    vtracks = addStructFun(vtracks,'Y','Yf',@(X)(conv(X,kerp,'valid')*px));
%     vtracks = addStructFun(vtracks,'X','Vx',@(X)(conv(X,kerv,'valid')*px*fps));
%     vtracks = addStructFun(vtracks,'Y','Vy',@(X)(conv(X,kerv,'valid')*px*fps));
%     vtracks = addStructFun(vtracks,'X','Ax',@(X)(conv(X,kera,'valid')*px*fps^2));
%     vtracks = addStructFun(vtracks,'Y','Ay',@(X)(conv(X,kera,'valid')*px*fps^2));
    vtracks = addStructFun(vtracks,'Xf','Tf',@(X)([0:numel(X)-1]));
else
    vtracks = addStructFun(vtracks,'X','Xf',@(X)(conv(X(1:Nmax),kerp,'valid')*px));
    vtracks = addStructFun(vtracks,'Y','Yf',@(X)(conv(X(1:Nmax),kerp,'valid')*px));
%     vtracks = addStructFun(vtracks,'X','Vx',@(X)(conv(X(1:Nmax),kerv,'valid')*px*fps));
%     vtracks = addStructFun(vtracks,'Y','Vy',@(X)(conv(X(1:Nmax),kerv,'valid')*px*fps));
%     vtracks = addStructFun(vtracks,'X','Ax',@(X)(conv(X(1:Nmax),kera,'valid')*px*fps^2));
%     vtracks = addStructFun(vtracks,'Y','Ay',@(X)(conv(X(1:Nmax),kera,'valid')*px*fps^2));
    vtracks = addStructFun(vtracks,'T','Tf',@(X)(X(floor(L/2)+1:Nmax-floor(L/2))));  
end

disp('Acc and Vel done\n');

for k = 1:100:numel(vtracks)
    vtracks(k).Xf=vtracks(k).Xf(1:Ndecim:end);
    vtracks(k).Yf=vtracks(k).Yf(1:Ndecim:end);
%     vtracks(k).Vx=vtracks(k).Vx(1:Ndecim:end);
%     vtracks(k).Vy=vtracks(k).Vy(1:Ndecim:end);
%     vtracks(k).Ax=vtracks(k).Ax(1:Ndecim:end);
%     vtracks(k).Ay=vtracks(k).Ay(1:Ndecim:end);
    vtracks(k).Tf=vtracks(k).Tf(1:Ndecim:end);
end
if exist('Nmax')
    Nmax = Nmax/Ndecim;
end
toc
    
%% Transform tracks data into frame data
%part = track2part(vtracks,{'Tf','Xf','Yf','Vx','Vy','Ax','Ay'},1);
part = track2part(vtracks,{'Tf','Xf','Yf'},1);
part = addStructFun(part,'Xf','X',@(X)(X));
part = addStructFun(part,'Yf','Y',@(X)(X));


%% Calculate pairs (relative position, velocity and acceleration per frame)
tic
pair = pairStat(part);
%pair = pairAll;
toc

%% Recombine pair data into pair-tracks

%pair=part

dNtrack=[pair.dNtrack];
II=find(abs(dNtrack)==0);
dNtrack(II)=[];
%%
dX=[pair.dX];
dX(II)=[];

dY=[pair.dY];
dY(II)=[];

dD2=[pair.dR2];
dD2(II)=[];
% 
% dVx=[pair.dVx];
% dVx(II)=[];
% 
% dVy=[pair.dVy];
% dVy(II)=[];
% % 
% dV2=[pair.dV2];
% dV2(II)=[];
% 
% if isfield(pair,'dVpx');
%     dVpx=[pair.dVpx];
%     dVpy=[pair.dVpy];
%     dVp2=[pair.dVp2];
% end
% dAx=[pair.dAx];
% dAx(II)=[];
% 
% dAy=[pair.dAy];
% dAy(II)=[];
% 
% dA2=[pair.dA2];
% dA2(II)=[];

%cRho=[pair.cRho];
%cRho(II)=[];

%Xm=[pair.Xm];
%Ym=[pair.Ym];
%

[dNs,Is]=sort(dNtrack);
pairTracks = bwconncomp(1-abs(diff(dNs))>=1);

[dNtrackU]=unique(dNtrack(Is));
dX=dX(Is);
dY=dY(Is);
dD2=dD2(Is);
% dVx=dVx(Is);
% dVy=dVy(Is);
% dV2=dV2(Is);
% if isfield(pair,'dVpx');
%     dVpx=dVpx(Is);
%     dVpy=dVpy(Is);
%     dVp2=dVp2(Is);
% end
% dAx=dAx(Is);
% dAy=dAy(Is);
% dA2=dA2(Is);
%cRho=cRho(Is);

%
%Xm=Xm(Is);
%Ym=Ym(Is);
%
%[Thetam,Rhom,Zm]=cart2pol((Xm-nanmean(Xm))*90e-6,(Ym-nanmean(Ym))*90e-6,(Zm-nanmean(Zm))*90e-6);
%


%% From here the code is more specific to the matrix type data from simulations (where all tracks have same length)
% First, keep the piece of tracks for a selected initial time, including a
% prescribed initial time shift
% For instance in simulations where particles are initially injected at a
% point source, we may want to calculate stats only once particles are
% spread over the entire domain. In this case shiftI0 must be large enough
% to correspond to a time for which this condition is reached. 
% (Note that shiftI0 is in units of the decimated time)
%
% I0 contains the list of initial times. Note that in this simplified
% version only one initial time is considered per track. 
%
% In stationnary conditions, on could simply use the classical increment
% functions (strcutFunc_sctruct.m) from the reconstructed pairTracl strcutures

%shiftI0=12000;
shiftI0=100;
I0=cellfun(@(X)(X(1+shiftI0)),pairTracks.PixelIdxList);
Ltrack=cellfun(@numel,pairTracks.PixelIdxList)-shiftI0;
Lmax=max(Ltrack);
MD2=NaN(pairTracks.NumObjects,Lmax);

%% Calculate MD2, the matrix of all pair tracks starting at time shiftI0

for kk=1:pairTracks.NumObjects
    MD2(kk,1:Ltrack(kk)+1)=...
        (dX(I0(kk):I0(kk)+Ltrack(kk))-dX(I0(kk))).^2+...
        (dY(I0(kk):I0(kk)+Ltrack(kk))-dY(I0(kk))).^2;
    dNNs(kk,1:Ltrack(kk)+1)=dNs(I0(kk):I0(kk)+Ltrack(kk));
end

%% Estimate bins to sort data by initial separation or initial relative vel or initial relativ acc
%
D2max=max(dD2)-1e-10;
% V2max=max(dV2)-1e-10;
% A2max=max(dA2)-1e-10;
%Rhomax=max(cRho)-1e-10;

Nbins=10;

%edgesD2=linspace(0,D2max,Nbins);
edgesD2=linspace(0,D2max/3,Nbins);
%edgesD2=([0 5 10 15 20 25 30 35 40]./0.2).^2;
%edgesD2=logspace(1,log10(D2max),Nbins);
%edgesV2=logspace(-4,log10(V2max),Nbins);
% edgesV2=linspace(0,V2max,Nbins);
% edgesA2=linspace(0,A2max,Nbins);
%edgesRhom=linspace(0,max(Rhom)*1.0001,Nbins);
%edgesRho=linspace(0,Rhomax,11);

binD2=(edgesD2(2:end)+edgesD2(1:end-1))/2;
% binV2=(edgesV2(2:end)+edgesV2(1:end-1))/2;
% binA2=(edgesA2(2:end)+edgesA2(1:end-1))/2;
%binRho=(edgesRho(2:end)+edgesRho(1:end-1))/2;
%binRhom=(edgesRhom(2:end)+edgesRhom(1:end-1))/2;
%binZm=(edgesZm(2:end)+edgesZm(1:end-1))/2;
%
[ND2,edgesD20,~,binD20]=histcn(dD2(I0)',edgesD2); %I0 ind instt initial
% [NV2,edgesV20,binV20]=histcounts(dV2(I0),edgesV2);
% [NA2,edgesA20,binA20]=histcounts(dA2(I0),edgesA2);
%[NRho,edgesRho0,binRho0]=histcounts(cRho(I0),edgesRho);

%[NRhom,edgesRhom0,binRhom0]=histcounts(Rhom(I0),edgesRhom);
%[NZm,edgesZm0,binZm0]=histcounts(Zm(I0),edgesZm);

%% D2 conditionned on initial separation

for k=1:numel(binD2)
    I=find((binD20==k))%&(binRho0<11));
    meanD2(k).dD2=nanmean(MD2(I,:),1);
    meanD2(k).dD20=binD2(k);
    meanD2(k).dT=([1:Lmax+1]-1)/fps;
    meanD2(k).ND20=numel(I);
end
%%
figure;hold on
for k = 1:numel(meanD2)
    k
    if meanD2(k).ND20>10
        loglog(meanD2(k).dT,meanD2(k).dD2);
    end
end
set(gca,'FontSize',28);
set(gca,'XScale','log');
set(gca,'YScale','log');
xlabel('$\tau$','Interpreter','latex');
ylabel('$D^2$','Interpreter','latex');
%axis([min(meanD2(1).dT) max(meanD2(1).dT) 1e-1 1e3]);
grid minor;
box;

% %% Below are other conditionning (initial vel, initial acc, etc.)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% D2 conditionned on initial velocity
% for k=1:numel(binD2)
%     I=find((binV20==k));%&(binRho0<11));
%     meanD2(k).dD2=nanmean(MD2(I,:),1);
%     meanD2(k).dV20=binV2(k);
%     meanD2(k).dT=([1:Lmax+1]-1)/F_Ech;
%     meanD2(k).ND20=numel(I);
% end
% %figure;hold on
% 
% %% D2 conditionned on initial acceleration
% for k=1:numel(binA2)
%     I=find((binA20==k));%&(binRho0<8));
%     meanD2(k).dA2=nanmean(MD2(I,:),1);
%     meanD2(k).dA20=binA2(k);
%     meanD2(k).NA20=numel(I);
% end
% 
% %%
% %% D2 conditionned on initial separation and velocity
% I=find((binD20==2)&(binV20==1));
% figure;loglog(meanD2(1).dT,nanmean(MD2(I,:),1));
% %%
% figure;hold on;
% for i=1:Nbins
% I=find((binD20==i));
% 
% loglog(meanD2(1).dT,nanmean(MD2(I,:),1));
% end
% f=gcf,set(f,'name','N=30, vmoy_filt Dmax=70mm','numbertitle','off')
% %%
% legend(num2str(edgesD2(1).^0.5.*0.29),num2str(edgesD2(2).^0.5.*0.29),num2str(edgesD2(3).^0.5.*0.29),num2str(edgesD2(4).^0.5.*0.29),num2str(edgesD2(5).^0.5.*0.29))
% %%
% legend(num2str(edgesD2(1).^0.5.*0.29),num2str(edgesD2(2).^0.5.*0.29),num2str(edgesD2(3).^0.5.*0.29),num2str(edgesD2(4).^0.5.*0.29),num2str(edgesD2(5).^0.5.*0.29),num2str(edgesD2(6).^0.5.*0.29),num2str(edgesD2(7).^0.5.*0.29),num2str(edgesD2(8).^0.5.*0.29),num2str(edgesD2(9).^0.5.*0.29),num2str(edgesD2(10).^0.5.*0.29)); 
% 
% %%
% MD2_vtracks50_no_filt=MD2;
% meanD2_T_vtracks50_no_filt=meanD2(1).dT;
% edgesD2_vtracks_50_no_filt=edgesD2;

%% D2 conditionned on initial velocity and position
%I=find(((binRhom0<=3)&(abs(binZm0-16)<=4))&(binV20<=2));
%figure;loglog(meanD2(1).dT,nanmean(MD2(I,:),1)./meanD2(1).dT.^3);