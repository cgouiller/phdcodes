%% Comparer les aires de déplétion exp avec des modèles expérimentaux (soit sublimation soit diffusion du camphre dans le volume)

R=[1;1.5;2;2.5;3;3.5;4];
Vmoy=[28.03;38.39;49.02;57.67;64.7;68.23;74.34]*0.001;

%Cas symétrique
% for i=1:length(R)
% L_dif(i)=sqrt((5e-9*(R(i)./4).^2*3e-3)./(pi*Vmoy(i).^2*sqrt(7e-10)));
% L_sub(i)=((5e-9*(R(i)./4).^2*3e-3)./(pi*6e-7*(Vmoy(i))^1.5))^(2/5);
% end

%Cas asym
for i=1:length(R)
%L_difa(i)=((5e-9*(R(i)./4).^2*3e-3)./(pi*7e-10*sqrt(10^(-4)*Vmoy(i)^(3/2)*1000)))^(2/3);
    L_suba(i)=sqrt((5e-9*(R(i)./4).^2*3e-3)./(pi*sqrt(10^(-4))*(Vmoy(i))*6e-7));
%L_difap(i)=sqrt(10^(-4)*L_difa(i)/Vmoy(i));
    L_subap(i)=sqrt(10^(-4)*L_suba(i)/Vmoy(i));
end
%Adif=pi*L_difa.*L_difap;
Asub=pi*L_suba.*L_subap;

plot(R,Asub,'+b','MarkerSize',15,'LineWidth',3,'DisplayName','Sublimation totale');
hold on; 
plot(R,Adif,'+r','MarkerSize',15,'LineWidth',3,'DisplayName','Diffusion totale'); 
plot(R,airel,'+g','MarkerSize',15,'LineWidth',3,'DisplayName','Expérience');
%plot(R,larglist*0.001,'+g','MarkerSize',15,'LineWidth',3,'DisplayName','Expérience')
legend show
xlabel('R [mm]')
xlim([0 4.5]);
%ylim([0 0.022]);
ylabel('Aire [m^2]')

%%
plot(R,L_suba,'+b','MarkerSize',15,'LineWidth',3,'DisplayName','Sublimation totale');
hold on; 
plot(R,L_difa,'+r','MarkerSize',15,'LineWidth',3,'DisplayName','Diffusion totale'); 
plot(R,longlist*0.001,'+g','MarkerSize',15,'LineWidth',3,'DisplayName','Expérience')
legend show
xlabel('R [mm]')
xlim([0 4.5]);
ylim([0 0.3]);
ylabel('L')