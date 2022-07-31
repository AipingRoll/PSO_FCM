%% I. 清空环境
clc
clear
%% DATA preparation for PSO & FCM

A=iris(:,1:4);
data=table2array(A);
data_n = size(data, 1);
in_n = size(data, 2);
%dat=zscore(data);
%[c,center]=my_graph_cluster(dat);%cluster center and number based on graph theory model 
[max_data,index]=max(data);
[min_data,index2]=min(data);
c=7;



%% III. 参数初始化
c1 = 1.49445;
c2 = 1.49445;
maxgen = 1000;   % 进化次数  
sizepop = 100;   %种群规模
Vmin = -0.15;
Vmax=0.15;
popmax =1;
popmin=0;

pop=zeros(sizepop,c,in_n);
lizi_V=zeros(sizepop,c,in_n);

[center1,U1,obj_fcn1]=fcm(data,9,[2 1000 1e-8 1]);



%% IV. 产生初始粒子和速度
    % 随机产生一个种群   
   for i=1:sizepop
       
          pop(i,:,:)=rand(c,in_n);
                
   end
   for i=1:sizepop
        lizi_V(i,:,:) =ones(c,1)*Vmax.*rands(c,in_n);
        %初始化                                                                      
                    
        % 计算适应度
         p1=reshape(pop(i,:,:),c,in_n);
         p2=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*p1;

         fitness(i) =my_fitness(p2, data,c)  ;%适应度
        
         
   end
    
pop=pop_ori=;
lizi_V=lizi_V_ori;
fitness=fitness_ori;
    
   
%% V. 个体极值和群体极值
[bestfitness, bestindex] = min(fitness);
zbest = pop(bestindex,:,:);   %全局最佳

gbest = pop;    %个体最佳
fitnessgbest = fitness;   %个体最佳适应度值
fitnesszbest = bestfitness;   %全局最佳适应度值
ws = 1.2;
we = 0.35;
%% VI. 迭代寻优
for i = 1:maxgen
      
      %w(i) = ws - (ws-we)*(i/maxgen);
       %w(i) = ws - (ws-we)*(i/maxgen)^2;
        w(i) = (log(2.98+i/maxgen))^(-1.51);
     
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
plot(yy),hold on
center=ones(c,1)*min_data+ones(c,1)*(max_data-min_data).*reshape(zbest,c,in_n);








figure
plot(yy_lpsofcm,'linewidth',1.5),grid on ,hold on
xlabel('generation ','fontname','times','fontsize',14);ylabel('fitness function f=J_m','fontname','times','fontsize',14);
plot(yy_logpsofcm,'r','linewidth',1.5),hold on
plot(yy_spsp_fcm,'k','linewidth',1.5),hold on
plot(obj_fcn1,'m','linewidth',1.5),hold on

legend('L-PSO-FCM','LOG-PSO-FCM','S-PSO-FCM','FCM');







%% VII.输出结果
[fitnesszbest, zbest]
plot3(zbest(1), zbest(2), fitnesszbest,'bo','linewidth',1.5)
