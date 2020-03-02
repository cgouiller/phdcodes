hold off

h = figure;
axis tight manual
filenameGif=strcat(directoryAnalyse,'_correlationsRadiales.gif');
N=51;

for k=1:N
    %Capture the plot as an image
    plot(vectDist(:,1)*calib,radialCorrelation(:,k));
    xlabel('$r$ (mm)','Interpreter','latex','FontSize',18,'position',[10,-0.3e-3]);
    ylabel('$\langle C_1 . C_2 \rangle$','Interpreter','latex','FontSize',18,'position',[-1.5,2.5e-3]);
    
    x=[0 4 8 12 16 20];
    y=[0 0.001 0.002 0.003 0.004 0.005];
    set(gca,'XTick',x)
    set(gca,'XTickLabel',sprintf('    ',x))
    set(gca,'YTick',y)
    set(gca,'YTickLabel',sprintf(' ',y))
    %set(gca,'Color',[1 1 1 0])
    
    text('Interpreter','LaTex','string','$0$','position',[-0.8,-0.05e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$1$','position',[-0.8,0.95e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$2$','position',[-0.8,1.95e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$3$','position',[-0.8,2.95e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$4$','position',[-0.8,3.95e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$5$','position',[-0.8,4.95e-3],'FontSize',16)
    
    text('Interpreter','LaTex','string','$0$','position',[-0.2,-0.2e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$4$','position',[3.8,-0.2e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$8$','position',[7.8,-0.2e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$12$','position',[11.6,-0.2e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$16$','position',[15.6,-0.2e-3],'FontSize',16)
    text('Interpreter','LaTex','string','$20$','position',[19.6,-0.2e-3],'FontSize',16)
    
    text('Interpreter','LaTex','string',strcat('$t = $',num2str((k-1)*5),'s'),'position',[16,4.5e-3],'FontSize',18)
    
    text('Interpreter','LaTex','string','$\times 10^{-3}$','position',[-0,5.1e-3],'FontSize',14)
    
    ylim([0 0.005]);
    xlim([0 20]);
    frame = getframe(h);

    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    
    %Write to the GIF File
    if k == 1
        imwrite(imind,cm,filenameGif,'gif', 'Loopcount',inf,'DelayTime',0.3);
    else
        imwrite(imind,cm,filenameGif,'gif','WriteMode','append','DelayTime',0.3);
    end
    
end