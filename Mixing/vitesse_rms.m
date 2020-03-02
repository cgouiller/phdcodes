
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