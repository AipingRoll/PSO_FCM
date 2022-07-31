clc,clear
%%   data generated provided with j k l 
%---- miu-delay; ita-noisy factor; lamda-wave length;

f1=1561.098;f2=1268.520;f3=1176.450; % slected frequency
f0=gcd(gcd(1561098,1268520),1176450)/1000;
k1= round(f1/f0) ;
k2= round(f2/f0)  ;
k3=  round(f3/f0) ;
lamda1=3e+8/(f1*1e+6);
lamda2=3e+8/(f2*1e+6);
lamda3=3e+8/(f3*1e+6);
i=1;
for j=-40:1:40
    for k=-40:1:40
        for l=-40:1:40
    kk=j*k1+k*k2+l*k3;
    miu=j+k*lamda2/lamda1+l*lamda3/lamda1;
    if kk<1500 && kk>-100 
            if  miu<5 && miu>-5
                  s(i,1)=j+k+l;
                  s(i,2)=j;s(i,3)=k;s(i,4)=l;
                  miuu(i)=miu;
                  lamda(i)=1./(j/lamda1+k/lamda2+l/lamda3); 
                  ita(i)=sqrt(j^2+k^2+l^2);
                  kkk(i)=kk;
                  i=i+1;
            end
    end             
        end
    end
end
clear i j k l k1 k2 k3 f1 f2 f3 kk f0 lamda1 lamda2 lamda3 miu_bar % realease memory
%%   s=0  dataset 
ind_2=find(s(:,1)==-2);
ind_1=find(s(:,1)==-1);
ind0=find(s(:,1)==0);
ind1=find(s(:,1)==1);
ind2=find(s(:,1)==2);
ind3=find(s(:,1)==3);
miuu_2=miuu(ind_2);
miuu_1=miuu(ind_1);
miuu0=miuu(ind0);lamda0=lamda(ind0);ita0=ita(ind0);
miuu1=miuu(ind1);
miuu2=miuu(ind2);
miuu3=miuu(ind3);
kkk_2=kkk(ind_2);
kkk_1=kkk(ind_1);
kkk0=kkk(ind0);
kkk1=kkk(ind1);
kkk2=kkk(ind2);
kkk3=kkk(ind3);
j=1;
for i=1:length(kkk_2)  %% center points
     if abs(kkk_2(i))<20
         if abs(miuu_2(i)+4.5)<0.1
             cen(j,1)=kkk_2(i);
             cen(j,2)=miuu(ind_2(i));
             cen(j,3:5)=s(ind_2(i),2:4);
             cen(j,3:5)=s(ind_2(i),2:4);
             cen(j,6)=lamda(ind_2(i));
             cen(j,7)=miuu(ind_2(i));
             cen(j,8)=ita(ind_2(i));
j=j+1;
         end
     end
    
end

[num, ind]=min(abs(kkk_2));
miuu_2(ind);


line(kkk_2,miuu_2,'linestyle','none',...
'marker','o','color','g');
line(kkk_1,miuu_1,'linestyle','none',...
'marker','x','color','r');

ita0=ita(ind0);
kkkk0=kkk0(find(ita0<100));


plot(kkk0,miuu0,'.','markerfacecolor','[0 0 1]','markersize',7), hold on
grid on
plot(kkk1,miuu1,'.','markerfacecolor','[0 1 0]','markersize',10), hold on
plot(kkk2,miuu2,'.','markerfacecolor','[0 1 1]','markersize',7), hold on
plot(kkk3,miuu3,'.','markerfacecolor','[0 1 1]','markersize',7), hold on
plot(kkk_1,miuu_1,'.','markerfacecolor','[1 1 0]','markersize',7), hold on
plot(kkk_2,miuu_2,'.','markerfacecolor','[1 1 1 ]','markersize',7), hold on
xlabel('\itk','fontname','times','fontsize',14), hold on
ylabel('\partial_c','fontname','times','fontsize',14), hold on

find(miuu0(find(kkk0(find(kkk0>(-15)))<0))>-0.1)
find(miuu0==-0.05829)
ii=1;
for i=1:689
    
    
    if kkk0(i)<70 &&kkk0(i)>-70
        if miuu0(i)<0.18 &&  miuu0(i)>-0.18
          ind_k0(ii)=i;ii=ii+1;
          [kkk0(i),  miuu0(i)],
        end
    end
end
i=1;


plot(kkk0(ind_k0),miuu0(ind_k0),'.','markerfacecolor','[0 1 0]','markersize',14), hold on
grid on
s0(ind_k0,:)
shuchu=[s(ind0(ind_k0),:),miuu0(ind_k0)',lamda0(ind_k0)',ita0(ind_k0)'];
xlswrite('biaoge1.xls',shuchu);
indkkk=find(kkk0==(-8));
s(ind0(161),:);
%%                                           s1  dataset 

s1=s(ind1,:);
ita1=ita(ind1);
lamda1=lamda(ind1);
miuu1=miuu(ind1);
%  wrong point  164  19
lamda1(164)=[];miuu1(164)=[];ita1(164)=[];ind1(164)=[];ind1(19)=[];
lamda1(19)=[];miuu1(19)=[];ita1(19)=[];
data1=[lamda1;miuu1;ita1]';
data1=abs(data1);
find(lamda1==max(lamda1))

plot3(data1(:,1),data1(:,2),data1(:,3),'.'),hold on
plot(lamda,'.');

data=zscore(data1);
data_mean=mean(data1,1);
data_std=std(data1);
[center,U,obj_fcn]=fcm(data,6,[2 300 1e-8,1]);
cluster=center.*repmat(data_std,size(center,1),1)+repmat(data_mean,size(center,1),1); %%   cluster center 


maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2, :) == maxU);
index3 = find(U(3, :) == maxU);
index4 = find(U(4, :) == maxU);
index5 = find(U(5, :) == maxU);
index6 = find(U(6, :) == maxU);
index7 = find(U(7, :) == maxU);
index8 = find(U(8, :) == maxU);
index9 = find(U(9, :) == maxU);



plot3(data1(index1,1),data1(index1, 2),data1(index1,3),'linestyle','none',...
'marker','o','color','g'), hold on
plot3(data1(index2,1),data1(index2, 2),data1(index2,3),'linestyle','none',...
'marker','x','color','r'),hold on
plot3(data1(index3,1),data1(index3, 2),data1(index3,3),'linestyle','none',...
'marker','*','color','k'),hold on
plot3(data1(index4,1),data1(index4, 2),data1(index4,3),'linestyle','none',...
'marker','*','color','y'),hold on
plot3(data1(index5,1),data1(index5, 2),data1(index5,3),'linestyle','none',...
'marker','*','color','g'),hold on
plot3(data1(index6,1),data1(index6, 2),data1(index6,3),'linestyle','none',...
'marker','*','color','b'),hold on
plot3(data1(index7,1),data1(index7, 2),data1(index7,3),'linestyle','none',...
'marker','*','color','y'),hold on



plot3(center(1,1),center(1,2),center(1,3),'kpentagram','markersize',15,'LineWidth',2),hold on
plot3(center(2,1),center(2,2),center(2,3),'kpentagram','markersize',15,'LineWidth',2),hold on
plot3(center(3,1),center(3,2),center(3,3),'kpentagram','markersize',15,'LineWidth',2),hold on
plot3(center(4,1),center(4,2),center(4,3),'kpentagram','markersize',15,'LineWidth',2),hold on
grid on
xlabel('\lamda','fontname','times','fontsize',14), hold on
ylabel('\miu','fontname','times','fontsize',14), hold on
zlabel('\ita','fontname','times','fontsize',14), hold on

%%  only for testting
bds=[1.154 -0.333 13.491;1.511 -0.270 12.083; 2.187 -0.207 10.677; 1.221 -0.250 5.657; 1.628 -0.188 4.243; 2.442 -0.125 2.828; 4.884 -0.063 1.414; 1.297 -0.168 2.449; 1.765 -0.105 3.742; 2.765 -0.043 5.099;
    6.731 0.020 6.481; 1.077 -0.148 8.832;  1.382 -0.086 10.198; 1.928 -0.023 11.576; 3.185 -0.039 12.961;];
[center,U,obj_fcn]=my_fcm(bds,4);

maxU = max(U);
index1 = find(U(1,:) == maxU);index2 = find(U(2, :) == maxU);index3 = find(U(3, :) == maxU);
index4 = find(U(4, :) == maxU);index5 = find(U(5, :) == maxU);index6 = find(U(6, :) == maxU);
index7 = find(U(7, :) == maxU);index8 = find(U(8, :) == maxU);index9 = find(U(9, :) == maxU);


line(bds(index1,1),bds(index1, 2),bds(index1, 3),'linestyle','none',...
'marker','o','color','g');
line(bds(index2,1),bds(index2, 2),bds(index2, 3),'linestyle','none',...
'marker','x','color','r');
line(bds(index3,1),bds(index3, 2),bds(index3, 3),'linestyle','none',...
'marker','*','color','g');
line(bds(index4,1),bds(index4, 2),bds(index4, 3),'linestyle','none',...
'marker','*','color','r');
hold on
plot3(center(1,1),center(1,2),center(1,3),'kpentagram','markersize',15,'LineWidth',2), hold on
plot3(center(2,1),center(2,2),center(2,3),'kpentagram','markersize',15,'LineWidth',2), hold on
plot3(center(3,1),center(3,2),center(3,3),'kpentagram','markersize',15,'LineWidth',2), hold on
plot3(center(4,1),center(4,2),center(4,3),'kpentagram','markersize',15,'LineWidth',2), hold on

%%     inertial weight 
ws = 1.2;
we = 0.3;
maxgen = 300;
subplot(1,2,1),
hold on;
for k = 1:maxgen
    w(k) = ws - (ws-we)*(k/maxgen);
end
plot(w,'linewidth',1.5);

for k = 1:maxgen
    w(k) = ws - (ws-we)*(k/maxgen)^2;
end
plot(w,'k-.','linewidth',1.5);

for k = 1:maxgen
    w(k) = (log(2.92+k/maxgen))^(-1.51);

end
plot(w,'r-.','linewidth',1.5);

legend('L-PSO','S-PSO','LOG-PSO');
xlabel('\ititeration','fontname','times','fontsize',14), hold on
ylabel('\itw','fontname','times','fontsize',14), hold on
grid on

subplot(1,2,2),

hold on;
for k = 1:1000
    w(k) = ws - (ws-we)*(k/1000);
end
plot(w,'linewidth',1.5);

for k = 1:1000
    w(k) = ws - (ws-we)*(k/1000)^2;
end
plot(w,'k-.','linewidth',1.5);

for k = 1:1000
    w(k) = (log(2.92+k/1000))^(-1.51);

end
plot(w,'r-.','linewidth',1.5);

legend('L-PSO','S-PSO','LOG-PSO');
xlabel('\ititeration','fontname','times','fontsize',14), hold on
ylabel('\itw','fontname','times','fontsize',14), hold on
grid on


for k = 1:maxgen
    w(k) = ws - (ws-we)*(2*k/maxgen-(k/maxgen)^2);
end
plot(w,'g:','linewidth',1.5);

for k = 1:maxgen
    w(k) = we * (ws/we)^(1/(1+10*k/maxgen));
end
plot(w,'y--','linewidth',1.5);

legend('Rule-1','Rule-2','Rule-3','Rule-4')
xlabel('迭代次数')
ylabel('速度更新权重W')

%%      iteration curves

figure % 300
plot(yy_lpsofcm,'linewidth',1.5),grid on ,hold on
xlabel('generation ','fontname','times','fontsize',14);ylabel('fitness function f=J','fontname','times','fontsize',14);
plot(yy_logpsofcm,'r','linewidth',1.5),hold on
plot(yy_spsp_fcm,'k','linewidth',1.5),hold on
plot(obj_fcn1(1:300),'m','linewidth',1.5),hold on
legend('L-PSO-FCM','LOG-PSO-FCM','S-PSO-FCM','FCM');
figure % 1000
plot(yy_lpsofcm_1000,'linewidth',1.5),grid on ,hold on
xlabel('generation ','fontname','times','fontsize',14);ylabel('fitness function f=J','fontname','times','fontsize',14);
plot(yy_logpsofcm_1000,'r','linewidth',1.5),hold on
plot(yy_spsofcm_1000,'k','linewidth',1.5),hold on
plot(obj_fcn1,'m','linewidth',1.5),hold on
legend('L-PSO-FCM','LOG-PSO-FCM','S-PSO-FCM','FCM');

figure % 600-1000
plot(600:1000,yy_lpsofcm_1000(600:1000),'linewidth',2),grid on ,hold on
xlabel('generation ','fontname','times','fontsize',14);ylabel('fitness function f=J','fontname','times','fontsize',14);
plot(600:1000,yy_logpsofcm_1000(600:1000),'r','linewidth',2),hold on
plot(600:1000,yy_spsofcm_1000(600:1000),'k','linewidth',2),hold on
plot(600:1000,obj_fcn1(600:1000),'m','linewidth',2),hold on
%%  results comparison
 %    gbest--center--indice
data_mean=mean(data1,1);
data_std=std(data1);
cluster=zbest.*repmat(data_std,size(zbest,1),1)+repmat(data_mean,size(zbest,1),1); %%   cluster center 
% cv 
dist = my_distfcm(center, data);       % fill the distance matrix
tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
U = tmp./(ones(c, 1)*sum(tmp));
mf = U.^expo; 
cd = sum(sum((dist.^2).*mf))/size(data,1);  % objective function
sd=sum(pdist(center))/(c*(c-1)/2)   ;
cv=0.6*cd+0.4/sd;
% pbm
clear dis
dc=max(pdist(center));
tmp1=dist.^(-2/(1.5-1)); 
U1= tmp1./(ones(c, 1)*sum(tmp1));
mf1 = U1.^expo; 
jm = sum(sum((dist.^2).*mf1)); 
dis(1, :) = sqrt(sum(((data-ones(size(data, 1), 1)*data_mean).^2), 2));
dis=ones(9,1)*dis;
e1=sum(sum(dis.*U));
pbf=e1*dc/(c*jm);
% fcm
[center,U,obj_fcn]=fcm(data,6,[2 300 1e-15 1]);
%%  clustering center

maxU = max(U);
index1 = find(U(1,:) == maxU);index2 = find(U(2, :) == maxU);index3 = find(U(3, :) == maxU);
index4 = find(U(4, :) == maxU);index5 = find(U(5, :) == maxU);index6 = find(U(6, :) == maxU);
index7 = find(U(7, :) == maxU);index8 = find(U(8, :) == maxU);index9 = find(U(9, :) == maxU);
center=center.*repmat(data_std,size(center,1),1)+repmat(data_mean,size(center,1),1); %%   cluster center 

scatter3(abs(data1(index1,1)),data1(index1, 2),data1(index1, 3),...
'markerfacecolor',[1 0 1],'markerfacealpha',0.8), hold on   % 


scatter3(abs(data1(index6,1)),data1(index6, 2),data1(index6, 3),...
'markerfacecolor',[0.5 0.16 0.16],'markerfacealpha',0.8), hold on % 


scatter3(abs(data1(index5,1)),data1(index5, 2),data1(index5, 3),...
'markerfacecolor','b','markerfacealpha',0.8), hold on  %%

% 
% scatter3(abs(data1(index7,1)),data1(index7, 2),data1(index7, 3),...
% 'markerfacecolor','r','markerfacealpha',0.8), hold on

scatter3(abs(data1(index2,1)),data1(index2, 2),data1(index2, 3),...
'markerfacecolor',[0.49 0.99 0],'markerfacealpha',0.8), hold on % 


scatter3(abs(data1(index3,1)),data1(index3, 2),data1(index3, 3),...
'markerfacecolor','k','markerfacealpha',0.8), hold on  %  


scatter3(abs(data1(index4,1)),data1(index4, 2),data1(index4, 3),...
'markerfacecolor','r','markerfacealpha',0.8), hold on %% 

scatter3(abs(data1(index8,1)),data1(index8, 2),data1(index8, 3),...
'markerfacecolor',[0.63 0.13 0.94],'markerfacealpha',0.8), hold on

scatter3(abs(data1(index9,1)),data1(index9, 2),data1(index9, 3),...
'markerfacecolor',[0.49 0.99 0],'markerfacealpha',0.8), hold on

grid on
xlabel('\lambda','fontsize',14), hold on
ylabel('\partial_{\itc}','fontname','times','fontsize',14), hold on
zlabel('\eta','fontname','times','fontsize',14), hold on
title('FCM','fontname','times');

plot3(abs(center(1,1)),center(1,2),center(1,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(abs(center(2,1)),center(2,2),center(2,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(abs(center(3,1)),center(3,2),center(3,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(4,1),center(4,2),center(4,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(5,1),center(5,2),center(5,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(6,1),center(6,2),center(6,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(7,1),center(7,2),center(7,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(8,1),center(8,2),center(8,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(9,1),center(9,2),center(9,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on

set(gca,'XLim',[-20 20]);

legend('cluster 1','cluster 2','cluster 3','cluster 4','cluster 5','cluster 6');

%% validation Iris

data1=iris(:,1:4);
data1=table2array(data1);
data_mean=mean(data1,1);
data_std=std(data1);
data=zscore(data1);
[center,U,obj_fcn]=fcm(data,3,[2 1000 1e-15 1]);
center=center.*repmat(data_std,size(center,1),1)+repmat(data_mean,size(center,1),1); %%   cluster center 
maxU = max(U);
index1 = find(U(1,:) == maxU);index2 = find(U(2, :) == maxU);index3 = find(U(3, :) == maxU);

scatter3(abs(data1(index1,1)),data1(index1, 2),data1(index1, 3),...
'markerfacecolor','r','markerfacealpha',0.8), hold on

scatter3(abs(data1(index2,1)),data1(index2, 2),data1(index2, 3),...
'markerfacecolor','k','markerfacealpha',0.8), hold on

scatter3(abs(data1(index3,1)),data1(index3, 2),data1(index3, 3),...
'markerfacecolor','y','markerfacealpha',0.8), hold on

grid on
xlabel('Petal Length','fontname','times','fontsize',14), hold on
ylabel('Petal Width','fontname','times','fontsize',14), hold on
zlabel('Sepal Length','fontname','times','fontsize',14), hold on
title('FCM','fontname','times');
plot3(center(1,1),center(1,2),center(1,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(2,1),center(2,2),center(2,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(3,1),center(3,2),center(3,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on

%  pso

dist = my_distfcm(center, data);       % fill the distance matrix
tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
U = tmp./(ones(c, 1)*sum(tmp));
maxU = max(U);
index1 = find(U(1,:) == maxU);index2 = find(U(2, :) == maxU);index3 = find(U(3, :) == maxU);
center=center.*repmat(data_std,size(center,1),1)+repmat(data_mean,size(center,1),1); %%   cluster center 

scatter3(abs(data1(index1,1)),data1(index1, 2),data1(index1, 3),...
'markerfacecolor','r','markerfacealpha',0.8), hold on

scatter3(abs(data1(index2,1)),data1(index2, 2),data1(index2, 3),...
'markerfacecolor','k','markerfacealpha',0.8), hold on

scatter3(abs(data1(index3,1)),data1(index3, 2),data1(index3, 3),...
'markerfacecolor','y','markerfacealpha',0.8), hold on

grid on
xlabel('Petal Length','fontname','times','fontsize',14), hold on
ylabel('Petal Width','fontname','times','fontsize',14), hold on
zlabel('Sepal Length','fontname','times','fontsize',14), hold on
title('S-PSO-FCM','fontname','times');
plot3(center(1,1),center(1,2),center(1,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(2,1),center(2,2),center(2,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on
plot3(center(3,1),center(3,2),center(3,3),'h','markersize',20,'markerfacecolor',[0.12 0.56 1],'LineWidth',2), hold on









