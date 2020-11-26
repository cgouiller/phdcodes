nombreVid=60;

manipCat.taup=[0,0.01,0.1,0.2,0.05,0.05,0.05,0.05,0.05,0.05,...
    0.05,0.05,0.05,0.050,0.2,0.2,0.2,0.2,0.2,0.2,...
    0.2,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0.1,0.1,...
    0.1,0.1,0.1,0.1,0,0,0,0,0,0,...
    0,0,0,0,0,0,0,0,0,0,...
    0,0,0,0,0,0,0,0,0,0];
manipCat.dt=[0.01,0.01,0.1,0.2,0.05,0.05,0.05,0.05,0.05,0.05,...
    0.05,0.05,0.05,0.050,0.2,0.2,0.2,0.2,0.2,0.2,...
    0.2,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0.1,0.1,...
    0.1,0.1,0.1,0.1,0.01,0.01,0.01,0.01,0.01,0.01,...
    0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,...
    0.005,0.01,0.035,0.1,0.35,0.005,0.01,0.035,0.1,0.35]/20;

manipCat.inertie=[0,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,0,0,0,0,0,0,...
    0,0,0,0,0,0,0,0,0,0,...
    0,0,0,0,0,0,0,0,0,0];
                    
manipCat.amp_ec=[3,3,3,3,0,0,0,0,0,0,...
                0,0,0,0,0,0,0,0,0,0,...
                0,0,0,0,0,0,0,0,0,0,...
                0,0,0,0,0,0,0,0,0,0,...
                0,0,0,0,0,0,0,0,0,0,...
                3,3,3,3,3,0,0,0,0,0];
                   
manipCat.npart=[1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,7,15,25,45,70,100,...
    1,1,1,1,1,1,1,1,1,1];
                 
manipCat.A=[0,0,0,0,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10,0.54,1,1.6632,2.1842,2.7053,3.7474,...
    4.7895,6.3526,7.9158,10,1,1,1,1,1,1,...
    0,0,0,0,0,1,1,1,1,1]; 
              
manipCat.set={'iner','iner','iner','iner','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita','vita','vita','vita','vita','vita','vita',...
    'vita','vita','vita','vita','mult','mult','mult','mult','mult','mult',...
    'tine','tine','tine','tine','tine','tine','tine','tine','tine','tine'};
                
manipCat.video={'00','01','02','03','01','02','03','04','05','06',...
    '07','08','09','10','11','12','13','14','15','16',...
    '17','18','19','20','21','22','23','24','25','26',...
    '27','28','29','30','01','02','03','04','05','06',...
    '07','08','09','10','01','02','03','04','05','06',...
    '01','02','03','04','05','06','07','08','09','10'};
                  
manipCat.advection=ones(1,60);

manipCat.asrc=ones(1,nombreVid);

manipCat.nt=1e4*[5,5,2,1,0.2,0.2,0.2,0.2,0.2,0.2,...
    0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,...
    0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,...
    0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.5,0.5,0.5,...
    0.5,0.5,0.5,0.5,10,10,10,10,10,10,...
    5,2.5,0.7143,0.25,0.0714,5,2.5,0.7143,0.25,0.0714];

manipCat.date={'201110','201110','201110','201110','201112','201112','201112','201112','201112','201112',...
    '201112','201112','201112','201112','201112','201112','201112','201112','201112','201112',...
    '201112','201112','201112','201112','201112','201112','201112','201112','201112','201112',...
    '201112','201112','201112','201112','201119','201119','201119','201119','201119','201119',...
    '201119','201119','201119','201119','201119','201119','201119','201119','201119','201119',...
    '201119','201119','201119','201119','201119','201119','201119','201119','201119','201119'};

manipCat.randomstart=[2,2,2,2,2*ones(1,40),1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2];
                        
manipCat.paramec=ones(1,nombreVid);
                            