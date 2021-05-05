load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mx','my');
mx=mod(mx,2*pi);
my=mod(my,2*pi);
tlist=length(mx)/4:length(mx);

p6list=zeros(length(tlist),length(mx(1,:)));
for jj=1:length(tlist)
    
    lastx=mx(tlist(jj),:);
    lasty=my(tlist(jj),:);
    
    lastxext=[];
    lastyext=[];
    for kk=[-1,0,1]
        for kkk=[-1,0,1]
            lastxext=[lastxext,lastx+kk*L];
            lastyext=[lastyext,lasty+kkk*L];
        end
    end
    for j=1:length(lastx)
        
        costmp=0;
        sintmp=0;
        distlist=sqrt((lastxext-lastx(j)).^2+(lastyext-lasty(j)).^2);
        for k=1:7
            idx=find(distlist==min(distlist));
            indppv=idx(1);
            if k~=1
                costmp=costmp+cos(6*atan2(lastyext(indppv)-lasty(j),lastxext(indppv)-lastx(j)));
                sintmp=sintmp+sin(6*atan2(lastyext(indppv)-lasty(j),lastxext(indppv)-lastx(j)));
            end
            distlist(indppv)=100000; %ce sera plus le plus près comme ça
        end
        p6list(jj,j)=costmp+sintmp*1i;
        
    end
    
end
save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_p6.mat'),'p6list','tlist');
        p6list=abs(p6list);
directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
mkdir(directoryPyt);
        save(strcat(directoryPyt,manipCat.video{ii},'_p6time.mat'),'tlist','p6list')

