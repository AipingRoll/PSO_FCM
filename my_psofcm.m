function [center  obj]=my_psofcm(data,c)


in_n = size(data, 2);
%[c,center]=my_graph_cluster(dat);%cluster center and number based on graph theory model 
[max_data,~]=max(data);
[min_data,~]=min(data);




%% III. 
c1 = 1.49445;
c2 = 1.49445;
maxgen = 200;   
sizepop = 100;   
Vmin = -0.2;
Vmax=0.2;
popmax =1;
popmin=0;
pop=zeros(sizepop,c,in_n);
lizi_V=zeros(sizepop,c,in_n);

%    [center1,U1,obj_fcn1]=my_fcm(data,3);



%% IV. 
    % 
   for i=1:sizepop
       
          pop(i,:,:)=rand(c,in_n);
                
   end
   for i=1:100
       lizi_V(i,:,:) =ones(c,1)*Vmax.*rands(c,in_n);
       
       p1=reshape(pop(i,:,:),c,in_n);
       p2=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*p1;
       
       fitness(i) =my_fitness(p2, data,c)  ;%��Ӧ��
       
         
    end
    

%% V. ���弫ֵ��Ⱥ�弫ֵ
[bestfitness, bestindex] = min(fitness);
zbest = pop(bestindex,:,:);   %ȫ�����
gbest = pop;    %�������
fitnessgbest = fitness;   %���������Ӧ��ֵ
fitnesszbest = bestfitness;   %ȫ�������Ӧ��ֵ
ws = 0.9;
we = 0.4;
%% VI. ����Ѱ��
for i = 1:maxgen
      
       w(i) = ws - (ws-we)*(i/maxgen)^2;
     
     for j = 1:sizepop
       
       
            lizi_V(j,:,:) = w(i)*lizi_V(j,:,:) + c1*rand*(gbest(j,:,:) - pop(j,:,:)) + c2*rand*(zbest - pop(j,:,:)) ;
        lizi_V(j,find(lizi_V(j,:,:)>Vmax)) = Vmax;
        lizi_V(j,find(lizi_V(j,:,:)<Vmin)) = Vmin;
                  % ��Ⱥ����
        pop(j,:,:) = pop(j,:,:) + lizi_V(j,:,:);
        
        
        
        pop(j,find(pop(j,:,:)>popmax))=popmax;
        pop(j,find(pop(j,:,:)<popmin))=popmin;
                % ��Ӧ��ֵ����
       p1=reshape(pop(j,:,:),c,in_n);
         p2=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*p1;

         fitness(j) =my_fitness(p2, data,c)  ;%��Ӧ��
                    
                                
      
     end
    
    for j = 1:sizepop  
        % �������Ÿ���
        if fitness(j) < fitnessgbest(j)
            gbest(j,:,:) = pop(j,:,:);
            fitnessgbest(j) = fitness(j);
        end
        
        % Ⱥ�����Ÿ���                     
        if fitness(j) < fitnesszbest
            zbest = pop(j,:,:);
            fitnesszbest = fitness(j);
        end
    end 
    yy(i) = fitnesszbest   ;         
end



obj=yy;
center=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*reshape(zbest,c,in_n);






