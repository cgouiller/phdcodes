 nombreVid=50;

manipCat.taup=[0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
               0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
               0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
               0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
               0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2];
                
manipCat.inertie=[1,1,1,1,1,1,1,1,1,1,...
                  1,1,1,1,1,1,1,1,1,1,...
                  1,1,1,1,1,1,1,1,1,1,...
                  1,1,1,1,1,1,1,1,1,1,...
                  1,1,1,1,1,1,1,1,1,1];
                    
manipCat.amp_ec=[0,0,0,0,0,0,0,0,0,0,...
                 0,0,0,0,0,0,0,0,0,0,...
                 0,0,0,0,0,0,0,0,0,0,...
                 0,0,0,0,0,0,0,0,0,0,...
                 0,0,0,0,0,0,0,0,0,0];
                   
manipCat.npart=[1,1,1,1,1,1,1,1,1,1,...
                1,1,1,1,1,1,1,1,1,1,...
                1,1,1,1,1,1,1,1,1,1,...
                1,1,1,1,1,1,1,1,1,1,...
                1,1,1,1,1,1,1,1,1,1];
                  
manipCat.A=[0.1000,0.6211,1.1421,1.6632,2.1842,2.7053,3.2263,3.7474,4.2684,4.7895,...
    5.3105,5.8316,6.3526,6.8737,7.3947,7.9158,8.4368,8.9579,9.4789,10.0000,...
    11.0422,12.0844,13.1266,14.1688,15.2110,16.2532,17.2954,18.3376,19.3798,20.4220,...
    0.2,0.3,0.4,0.5,25,30,40,50,75,100,...
    0.52,0.54,0.56,0.58,0.6,0.7,0.8,0.9,1,1.35]; 
              
manipCat.set={'vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn',...
              'vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn',...
              'vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn',...
              'vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn',...
              'vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn','vitn'};
                
manipCat.video={'01','02','03','04','05','06','07','08','09','10',...
                '11','12','13','14','15','16','17','18','19','20',...
                '21','22','23','24','25','26','27','28','29','30',...
                '31','32','33','34','35','36','37','38','39','40',...
                '41','42','43','44','45','46','47','48','49','50'};
                  
manipCat.advection=ones(1,nombreVid);

manipCat.asrc=ones(1,nombreVid);

manipCat.nt=1e4*[0.5*ones(1,10),...
                 0.5*ones(1,10),...
                 0.5*ones(1,10),...
                 0.5*ones(1,10),...
                 0.5*ones(1,10)];
manipCat.date={'200715','200715','200715','200715','200715','200715','200715','200715','200715','200715',...
               '200715','200715','200715','200715','200715','200715','200715','200715','200715','200715',...
               '200715','200715','200715','200715','200715','200715','200715','200715','200715','200715',...
               '200715','200715','200715','200715','200715','200715','200715','200715','200715','200715',...
               '200715','200715','200715','200715','200715','200715','200715','200715','200715','200715'};



manipCat.randomstart=[zeros(1,10),...
                      zeros(1,10),...
                      zeros(1,10),...
                      zeros(1,10),...
                      zeros(1,10)];
                        
manipCat.paramec=[zeros(1,10),...
                  zeros(1,10),...
                  zeros(1,10),...
                  zeros(1,10),...
                  zeros(1,10)];
                            