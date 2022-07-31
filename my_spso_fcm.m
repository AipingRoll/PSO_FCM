function [yy,center]=my_lpso_fcm(data,pop,lizi_V,c)
	data_n = size(data, 1);
	in_n = size(data, 2);
	[max_data,index]=max(data);
	[min_data,index2]=min(data);
	c1 = 1.49445;
c2 = 1.49445;
maxgen = 200;   % 进化次数  
sizepop = 100;   %种群规模
Vmin = -0.15;
Vmax=0.15;
popmax =1;
popmin=0;

   
%% V. 个体极值和群体极值
[bestfitness, bestindex] = min(fitness);
zbest = pop(bestindex,:,:);   %全局最佳

gbest = pop;    %个体最佳
fitnessgbest = fitness;   %个体最佳适应度值
fitnesszbest = bestfitness;   %全局最佳适应度值
ws = 1.2;
we = 0.3;
%% VI. 迭代寻优
for i = 1:maxgen
      
      % w(i) = ws - (ws-we)*(i/maxgen)^2;
       w(i) = ws - (ws-we)*(i/maxgen)^2;

     
     for j = 1:sizepop
       
       
            lizi_V(j,:,:) = w(i)*lizi_V(j,:,:) + c1*rand*(gbest(j,:,:) - pop(j,:,:)) + c2*rand*(zbest - pop(j,:,:)) ;
        lizi_V(j,find(lizi_V(j,:,:)>Vmax)) = Vmax;
        lizi_V(j,find(lizi_V(j,:,:)<Vmin)) = Vmin;
                  % 种群更新
        pop(j,:,:) = pop(j,:,:) + lizi_V(j,:,:);
        
        
        
        pop(j,find(pop(j,:,:)>popmax))=popmax;
        pop(j,find(pop(j,:,:)<popmin))=popmin;
                % 适应度值更新
       p1=reshape(pop(j,:,:),c,in_n);
         p2=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*p1;

         fitness(j) =my_fitness(p2, data,c)  ;%适应度
                    
                                
      
     end
    
    for j = 1:sizepop  
        % 个体最优更新
        if fitness(j) < fitnessgbest(j)
            gbest(j,:,:) = pop(j,:,:);
            fitnessgbest(j) = fitness(j);
        end
        
        % 群体最优更新                     
        if fitness(j) < fitnesszbest
            zbest = pop(j,:,:);
            fitnesszbest = fitness(j);
        end
    end 
    yy(i) = fitnesszbest   ;         
end

center=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*reshape(zbest,c,in_n);
