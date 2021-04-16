%% Manip pour connaitre le prfil transverse de la nappe 200110
posmes=[6.2:0.1:7.2,7.25,7.29,7.3,7.35,7.4:0.1:8.1]; %positions relevées sur le vernier
posreel=0.001*(posmes-posmes(1))/2; %le vernier de la platine indique deux fois plus que son vrai déplacement
pmes=[1.31,1.28,1.28,1.38,1.56,3.86,14.3,44.6,102,197.5,288,315.8,319.5,315,295,256,164,84,35.4,13,4.25,2.20,2.47];
plot(posreel,pmes,'+-')
xlabel('Distance Z [$\mu$ m]','Interpreter','latex')
ylabel('Puissance mesur\''ee [nW]','Interpreter','latex')
%% Exploitation
%On fitte les data par une gaussienne, les param sont
x0=5.4153e-4;
sig=9.5736e-5;
a=315.8644;
poscentered=posreel-x0; % On centre la nappe autour de son max

x=-0.1:0.0000001:0.1;
pfit=a*exp(-x.^2/(2*sig^2));
filtre=zeros(1,length(x));
filtre(abs(x)<15e-6)=sqrt((15e-6)^2-x(abs(x)<15e-6).^2);

nappe=deconvwnr(pfit,filtre);
plot(x,nappe);hold on;plot(poscentered,pmes*max(nappe)/max(pmes),'+r')
xlim([-0.001 0.001])
plotyy(x,nappe,poscentered,pmes)


%% Idem le 200122 (au milieu de la cuve)
posmes=17.65:0.1:19.15;
posreel=(posmes-posmes(1))*0.001/2;
pmes=[1.4,1.4,1.4,3.5,13.8,50.5,138.8,259,313.9,249.9,136.7,47.7,10.6,1.6,1.4,1.4]*1e-9;
plot(posreel,pmes,'+')
xlabel('Distance Z [$\mu$ m]','Interpreter','latex')
ylabel('Puissance mesur\''ee [W]','Interpreter','latex')
%% Exploitation
%On fitte les data par une gaussienne, les param sont
x0=0.00039776;
sig=8.2265e-5;
a=3.139e-7;
poscentered=posreel-x0; % On centre la nappe autour de son max

x=-0.1:0.0000001:0.1;
pfit=a*exp(-x.^2/(2*sig^2));
filtre=zeros(1,length(x));
filtre(abs(x)<15e-6)=sqrt((15e-6)^2-x(abs(x)<15e-6).^2);

nappe=deconvwnr(pfit,filtre);
plot(x,nappe);hold on;plot(poscentered,pmes*max(nappe)/max(pmes),'+r')
xlim([-0.001 0.001])
plotyy(x,nappe,poscentered,pmes)
x=x(990000:10:1010000);
nappe=nappe(990000:10:1010000);
save('E:\Clément\MyCore\Analyse\Nappe\profilnappe.mat','x','nappe','poscentered','pmes')
%% Manip pour connaitre la relation entre angle du plexi et hauteur de la nappe
angle1=170:10:240;
hauteurslues=[5.3,7.93,7.93-0.81+3.77,7.93-0.81+6.25,7.93-0.81+8.47,7.93-0.81+8.47-2.97+4.27,7.93-0.81+8.47-2.97+6.69,7.93-0.81+8.47-2.97+9.3];
hauteur1=0.001*(hauteurslues-hauteurslues(1))/2; %le vernier de la platine indique deux fois plus que son vrai déplacement

%% On recommence car ça avait l'air faux
angle2=160:4:284;
hauteurlue=[0.46+13.05-20.51-21.32+15.92,0.46+13.05-20.51-21.32+17.16,0.46+13.05-20.51-21.32+18.52,0.46+13.05-20.51-21.32+19.96,0.46+13.05-20.51,0.46-20.51+14.11,0.46-20.51+15.36,0.46-20.51+16.52,0.46-20.51+17.63,0.46-20.51+18.63,0.46-20.51+19.6,0.46,1.37,2.36,3.19,4.16,5.1,6.1,7.03,8,8.99,10.15,11.37,12.88,14.17,15.72,17.19,18.72,20.44,22.23,23.67,24.67];
hauteur2=-(hauteurlue-hauteurlue(5))/2+10.9725+0.4794;
plot(hauteur2,angle2,'+-')
xlabel('Position [mm]')
ylabel('Angle (deg)')
angles=interp1(hauteur2,angle2,0:0.3:4.5,'spline');

hold on;plot(0:0.3:4.5,angles,'r+')

%% Tentative de fit
angle3=(angle2)*pi/180;
hauteur3=-hauteur2;
%hth=18.7*sin(angle3-asin(sin(angle3)/1.469))./cos(asin(sin(angle3)/1.469))+8.78;
%plot(angle3,hauteur3,'+b');hold on;plot(angle3,hth,'-r')
f2 = fit( angle3',hauteur3', 'a+18.7*sin(x+c-asin(sin(x+c)/n))/cos(asin(sin(x+c)/n))', 'StartPoint',[-5,-4,1.5] );
hth=f2.a+18.7*sin(angle3+f2.c-asin(sin(angle3+f2.c)/f2.n))./cos(asin(sin(angle3+f2.c)/f2.n));
angles=interp1(hauteur3,angle3,-15:0.3:5,'spline');

plot((angle3+f2.c)*180/pi,hauteur3-f2.a,'+b');hold on;plot((angle3+f2.c)*180/pi,hth-f2.a,'-k');plot((angles+f2.c)*180/pi,(-15:0.3:5)-f2.a,'-r')
xexp=(angle3+f2.c)*180/pi;
yexp=hauteur3-f2.a;
xth=(angle3+f2.c)*180/pi;
yth=hth-f2.a;
xint=(angles+f2.c)*180/pi;
yint=(-15:0.3:5)-f2.a;
legend({'exp','th','interp'})
ylabel('Decalage [mm]')
xlabel('angle [deg]')
%plot(angle3,hauteur3,'-b');hold on;plot(angle3,hfit,'-g')
save('E:\Clément\MyCore\Analyse\Nappe\calibangle.mat','xexp','yexp','xth','yth','xint','yint')

%% Interpolation pour trouver point d'inflex
abc=linspace(min(angle2),max(angle2),100);
hauteurs=interp1(angle2,hauteur2,abc,'spline');
%plot(angle2,hauteur2,'+b');hold on; plot(abc,hauteurs,'-')

der=(hauteurs(2:end)-hauteurs(1:end-1))./(abc(2:end)-abc(1:end-1));
xder=(abc(1:end-1)+abc(2:end))/2;
der2=(der(2:end)-der(1:end-1))./(xder(2:end)-xder(1:end-1));
xder2=(xder(1:end-1)+xder(2:end))/2;
plot(xder,der,'-');hold on;plot([0,max(xder2)],[0,0],':')
% plot(angle3,hth,'-r')
% plot(angle3,hfit,'-g')
% hold on;
% plot(angle3,hth,'-r')