run manipsfinales;
load('E:\Clément\Mixing\meanTrailAdivN.mat')
image={zone2,zone7,zone15,zone8,zone45};
R=[1,2.5,2.5,4,2.5];
N=[15,7,15,15,45];
numVid=[23,17,25,27,26];
Sp=struct();
varR=[1,3,4];
XRCat=R(varR);
XNCat=N(varN);
varN=[2,3,5];
for i=1:length(image)
    calib=calibCat(numVid(i));
    mt=image{i};
    mt(isnan(mt))=-0.04;
    
    linex=mt(1,:);
    Nx=length(linex);
    [SpLinex,fx]=pwelch(linex,hanning(Nx),round(Nx/2),Nx,1/calib);
    SpAddx=zeros(length(SpLinex),1);

    liney=mt(:,1);
    Ny=length(liney);
    [SpLiney,fy]=pwelch(liney,hanning(Ny),round(Ny/2),Ny,1/calib);
    SpAddy=zeros(length(SpLiney),1);
    
    for ii=1:Ny
        linex=mt(ii,:);
        [SpLinex,fx]=pwelch(linex,hanning(Nx),round(Nx/2),Nx,1/calib);
        SpAddx=SpAddx+SpLinex;
    end
    SpMeanx=SpAddx/Ny;
    for ii=1:Nx
        liney=mt(:,ii);
        [SpLiney,fy]=pwelch(liney,hanning(Ny),round(Ny/2),Ny,1/calib);
        SpAddy=SpAddy+SpLiney;
    end
    SpMeany=SpAddy/Nx;
    Cstd(i)=sqrt(nanmean2(mt.*mt)-nanmean2(mt)^2);
    Sp(i).Spx=SpMeanx;
    Sp(i).Spy=SpMeany;
    Sp(i).fx=fx;
    Sp(i).fy=fy;
end

        loglog(Sp(j).fx,Sp(j).Spx,'+r')
loglog(Sp(j).fy,Sp(j).Spy,'+k')

        