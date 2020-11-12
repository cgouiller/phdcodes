nombreVid=24;

manipCat.taup=[0,0.1,0.2,0.01,0.05,0.05,0.05,0.05,0.05,0.05,...
    0.05,0.05,0.05,0.050,0.2,0.2,0.2,0.2,0.2,0.2,...
    0.2,0.2,0.2,0.2];
                
manipCat.inertie=[0,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1];
                    
manipCat.amp_ec=[3,3,3,3,0,0,0,0,0,0,0,0,0,0,...
    0,0,0,0,0,0,0,0,0,0,...
    0,0,0,0];
                   
manipCat.npart=[1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1];
                 
manipCat.A=[0,0,0,0,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10]; 
              
manipCat.set={'iner','iner','iner','iner','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita'};
                
manipCat.video={'00','01','02','03','01','02','03','04','05','06',...
    '07','08','09','10','11','12','13','14','15','16',...
    '17','18','19','20'};
                  
manipCat.advection=ones(1,nombreVid);

manipCat.asrc=ones(1,nombreVid);

manipCat.nt=1e4*[1,0.5,0.5,5,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1];

manipCat.date={'201110','201110','201110','201110','201112','201112','201112','201112','201112','201112',...
    '201112','201112','201112','201112','201112','201112','201112','201112','201112','201112',...
    '201112','201112','201112','201112'};

manipCat.randomstart=zeros(1,24);
                        
manipCat.paramec=ones(1,24);
                            