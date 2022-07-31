function [yy,center]=my_lpso_fcm(data,pop,lizi_V,c)
	data_n = size(data, 1);
	in_n = size(data, 2);
	[max_data,index]=max(data);
	[min_data,index2]=min(data);
	c1 = 1.49445;
c2 = 1.49445;
maxgen = 200;   % ��������  
sizepop = 100;   %��Ⱥ��ģ
Vmin = -0.15;
Vmax=0.15;
popmax =1;
popmin=0;

   
%% V. ���弫ֵ��Ⱥ�弫ֵ
[bestfitness, bestindex] = min(fitness);
zbest = pop(bestindex,:,:);   %ȫ�����

gbest = pop;    %�������
fitnessgbest = fitness;   %���������Ӧ��ֵ
fitnesszbest = bestfitness;   %ȫ�������Ӧ��ֵ
ws = 1.2;
we = 0.3;
%% VI. ����Ѱ��
for i = 1:maxgen
      
      % w(i) = ws - (ws-we)*(i/maxgen)^2;
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

center=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*reshape(zbest,c,in_n);
