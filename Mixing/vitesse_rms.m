
run manipsfinales;

list=varNold;
XCat=NCat(list);
ustdlist=[];
for i=1:length(list)
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
        load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
    vx=sample(:,6);
    vy=sample(:,7);
    ustdlist=[ustdlist,sqrt(std(vx(abs(vx)<100))^2+std(vy(abs(vy)<100))^2)];
   

 end
plot(XCat,ustdlist,'+k','LineWidth',2,'MarkerSize',12)
xlim([0 50])
xlabel('R [mm]','Interpreter','latex')
ylabel('Ustd [mm/s]','Interpreter','latex')


%% Pour referee

run manipsfinales;

list=varNold;
XCat=NCat(list);
t=[];
vrms=[];
for i=3
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
        load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
                 load(strcat(directoryAnalyse,'Conc.mat'));

        sample=sortrows(sample,3);
        t=[t,time(sample(1,3))];
        vx=sample(sample(:,3)==sample(1,3),6);
        vy=sample(sample(:,3)==sample(1,3),7);
        vrms=[vrms,sqrt(std(vx(abs(vx)<100))^2+std(vy(abs(vy)<100))^2)];
        for j=1:length(sample)
            if time(sample(j,3))>t(end)
                t=[t,time(sample(j,3))];
                vx=sample(sample(:,3)==sample(j,3),6);
                vy=sample(sample(:,3)==sample(j,3),7);
                vrms=[vrms,sqrt(std(vx(abs(vx)<100))^2+std(vy(abs(vy)<100))^2)];
            end
        end
   
   

 end
plot(t/60,vrms,'-k','LineWidth',2,'MarkerSize',12)
xlim([55 65])
xlabel('t [min]','Interpreter','latex')
ylabel('Ustd [mm/s]','Interpreter','latex')



%%
run manipsfinales;

list=varNold;
XCat=NCat(list);
t=[];
vrms=[];
for i=3
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
       % load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
                load(strcat(directoryAnalyse,'trajectories.mat'));
                 load(strcat(directoryAnalyse,'Conc.mat'));

sample=tracks;
        sample=sortrows(sample,3);
        t=[t,time(sample(1,3))];
        vx=sample(sample(:,3)==sample(1,3),6);
        vy=sample(sample(:,3)==sample(1,3),7);
        vrms=[vrms,sqrt(std(vx(abs(vx)<100))^2+std(vy(abs(vy)<100))^2)];
        for j=1:length(sample)
            if time(sample(j,3))>t(end)
                t=[t,time(sample(j,3))];
                vx=sample(sample(:,3)==sample(j,3),6);
                vy=sample(sample(:,3)==sample(j,3),7);
                vrms=[vrms,sqrt(std(vx(abs(vx)<100))^2+std(vy(abs(vy)<100))^2)];
            end
        end
   
   

 end
plot(t/60,vrms,'-k','LineWidth',2,'MarkerSize',12)
%xlim([0 50])
xlabel('t [min]','Interpreter','latex')
ylabel('Ustd [mm/s]','Interpreter','latex')

