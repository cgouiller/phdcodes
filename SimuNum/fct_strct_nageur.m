run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
cpt=1;
%for ii=45:50
tic
for ii=[45,48,50,271]
         directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');

  %  if exist(strcat(directoryPyt,num2str(manipCat.video{ii}),'_S2.mat'))==0
    load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii);
    nbins=20;
    edges=logspace(log10(0.25),log10(2*manipCat.L(ii)*sqrt(2)),nbins);
    cpts=zeros(1,length(edges));
    vals=zeros(1,length(edges));
    for i=round(linspace(length(mx(:,1))/2,length(mx(:,1))-1,ceil(100000/npart)))
        mxtt=mod(mx(i,:),manipCat.L(ii));
        mytt=mod(my(i,:),manipCat.L(ii));
        vxtt=(mx(i+1,:)-mx(i-1,:))/(2*manipCat.dt(ii));
        vytt=(my(i+1,:)-my(i-1,:))/(2*manipCat.dt(ii));
        vxt=[];
        vyt=[];
        mxt=[];
        myt=[];
        for k=-1:1
            for j=-1:1
                mxt=[mxt,mxtt+k*manipCat.L(ii)];
                myt=[myt,mytt+j*manipCat.L(ii)];
                vxt=[vxt,vxtt];
                vyt=[vyt,vytt];
            end
        end
          for k=1:length(mxtt)
              for j=1:length(mxt)
                        d=sqrt((mxt(j)-mxtt(k))^2+(myt(j)-mytt(k))^2);
                   if d~=0 && d~=manipCat.L(ii) && d~=manipCat.L(ii)*sqrt(2)

                        id=find(edges>=d);
                        id=id(1);
                        cpts(id)=cpts(id)+1;
                        vals(id)=vals(id)+(((vxt(j)-vxtt(k))*(mxt(j)-mxtt(k))+(vyt(j)-vytt(k))*(myt(j)-mytt(k)))/d)^2;
                    end
              end
          end
    end
    S2=vals./cpts;
    S2=S2(2:end);
    bins=(edges(1:end-1)+edges(2:end))/2;

    save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_S2.mat'),'bins','S2');
   % else
   %     load(strcat(directoryPyt,num2str(manipCat.video{ii}),'_S2.mat'))
   % end
hold on;
loglog(bins,S2,cols(cpt))
hold off;
cpt=cpt+1;
end
toc
%legend({'7','15','25','45','70','100'})
legend({'7','45','100','150'})
% 
 set(gca, 'XScale', 'log')
 set(gca, 'YScale', 'log')
 xlabel('r')
 ylabel('S2')

