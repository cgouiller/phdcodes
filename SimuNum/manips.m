nombreVid=109;

manipCat200320.taup=[0,0,0.1,0.2,0.4,0.1,0.2,0.4,0,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...       
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...          
                    0.2,0.2,0.2,0.2,0.2,0.2,0,0.2,0.2,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,... %50
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,...
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,... % 100
                    0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2];
                
manipCat200320.inertie=[0,0,1,1,1,1,1,1,0,1,...
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,0,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,... %50
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,...
                        1,1,1,1,1,1,1,1,1,1,... %100
                        1,1,1,1,1,1,1,1,1];
                    
manipCat200320.amp_ec=[1,5,1,1,1,5,5,5,0,0,...
                       0,0,0,0,0,2,4,6,3,3,...
                       3,0,1,1,1,1,1,1,1,1,...
                       1,1,1,6,6,6,6,6,1,1,...
                       1,1,1,1,3,3,3,3,3,3,... %50
                       3,3,3,1,1,5,5,5,5,5,...
                       5,5,1,5,5,3,3,5,5,5,...
                       5,5,5,5,3,3,1,3,3,1,...
                       1,1,1,1,1,1,1,1,1,3,...
                       3,3,3,3,5,5,5,5,5,4,... %100
                       4,4,4,4,2,2,2,2,2];
                   
manipCat200320.npart=[1,1,1,1,1,1,1,1,10,10,...
                      7,15,30,45,1,1,1,1,1,1,...
                      1,10,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,... %50
                      1,1,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,...
                      1,1,1,1,1,1,1,1,1,1,... %100
                      1,1,1,1,1,1,1,1,1];
                  
manipCat200320.A=[0,0,0,0,0,0,0,0,0.8,0.8,...
                  0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.2,0.4,...
                  0.6,0.8,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,...
                  0.5,0.55,0.6,0.2,0.4,0.6,0,0,0.4,0.45,...
                  0.5,0.55,0.6,1,0.15,0.2,0.25,0.3,0.35,0.4,... %50
                  0.45,0.5,0.55,0.005,1.5,0.15,0.2,0.25,0.3,0.35,...
                  0.4,0.45,0.05,0.55,0.6,0.005,0.01,0.05,0.01,1,...
                  1.5,0.1,0.5,0.005,0.05,0.1,0.01,1,1.5,0.005,...
                  0.01,0.05,1,1.5,0.001,0.005,0.01,0.05,0.1,0.001,...
                  0.005,0.01,0.05,0.1,0.001,0.005,0.01,0.05,0.1,0.001,... %100
                  0.005,0.01,0.05,0.1,0.001,0.005,0.01,0.05,0.1]; 
              
manipCat200320.set={'test','test','test','test','test','test','test','test','test','test',...
                    'varN','varN','varN','varN','varV','varV','varV','varV','varA','varA',...
                    'varA','test','varA','varA','varA','varA','varA','varA','varA','varA',...
                    'varA','varA','varA','varA','varA','varA','test','test','varA','varA',...
                    'varA','varA','varA','varA','varA','varA','varA','varA','varA','varA',... %50
                    'varA','varA','varA','varA','varA','varA','varA','varA','varA','varA',...
                    'varA','varA','varA','varA','varA','varA','varA','varA','varA','varA',...
                    'varA','varA','varA','varA','varA','varA','varA','varA','varA','varA',...
                    'varA','varA','varA','varA','cycl','cycl','cycl','cycl','cycl','cycl',...
                    'cycl','cycl','cycl','cycl','cycl','cycl','cycl','cycl','cycl','cycl',... %100
                    'cycl','cycl','cycl','cycl','cycl','cycl','cycl','cycl','cycl'};
                
manipCat200320.video={'01','02','03','04','05','06','07','08','09','10',...
                      '07','15','30','40','00','02','04','06','02','04',...
                      '06','11','01','02','03','04','05','06','07','08',...
                      '09','10','11','12','13','14','15','16','01','02',...
                      '03','04','05','06','07','08','09','10','11','12',... %50
                      '13','14','15','16','17','18','19','20','21','22',...
                      '23','24','25','26','27','28','29','30','31','32',...
                      '33','34','35','36','37','38','39','40','41','42',...
                      '43','44','45','46','01','02','03','04','05','06',...
                      '07','08','09','10','11','12','13','14','15','16',...
                      '17','18','19','20','21','22','23','24','25'};
                  
manipCat200320.advection=ones(1,109);

manipCat200320.asrc=ones(1,109);

manipCat200320.nt=1e4*[ones(1,8),5,5,...
                       5,5,5,5,1,1,1,1,5,5,...
                       20,4,100,50,30,20,10,10,20,10,...
                       20,10,50,5,5,5,2,2,20,10,...
                       20,10,50,5,5,5,5,5,5,5,... %50
                       5,20,20,20,5,5,5,5,5,5,...
                       5,5,5,5,5,40,40,40,40,20,...
                       20,20,20,20,20,20,20,20,20,20,...
                       20,20,20,20,10,10,10,10,10,10,...
                       10,10,10,10,10,10,10,10,10,10,... %100
                       10,10,10,10,10,10,10,10,10];
manipCat200320.date={'200320','200320','200320','200320','200320','200320','200320','200320','200320','200320',...
                     '200320','200320','200320','200320','200320','200320','200320','200320','200320','200320',...
                     '200320','200320','200402','200402','200402','200402','200402','200402','200402','200402',...
                     '200402','200402','200402','200402','200402','200402','200402','200402','200410','200410',...
                     '200410','200410','200410','200410','200410','200410','200410','200410','200410','200410',... %50
                     '200410','200410','200410','200410','200410','200410','200410','200410','200410','200410',...
                     '200410','200410','200410','200410','200410','200410','200410','200410','200410','200410',...
                     '200410','200410','200410','200410','200410','200410','200410','200410','200410','200410',...
                     '200410','200410','200410','200410','200414','200414','200414','200414','200414','200414',...
                     '200414','200414','200414','200414','200414','200414','200414','200414','200414','200414',... %100
                     '200414','200414','200414','200414','200414','200414','200414','200414','200414'};



manipCat200320.randomstart=[ones(1,10),...
                            ones(1,10),...
                            1,1,0,0,0,0,0,0,1,1,...
                            ones(1,6),0,0,1,1,...
                            ones(1,10),... %50
                            ones(1,10),...
                            ones(1,5),0,0,0,0,1,...
                            ones(1,10),...
                            ones(1,4),zeros(1,6),...
                            zeros(1,10),... %100
                            zeros(1,9)];