function fitness= my_fitness(pop, data,c)


expo=2;
% for i=1:c
%     for j=1:in_n
%     center(i,j)=pop(1,i,j);
%     end
% end
dist = my_distfcm(pop, data);       % fill the distance matrix
tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
U = tmp./(ones(c, 1)*sum(tmp));
mf = U.^expo; 
obj_fcn = sum(sum((dist.^2).*mf));  % objective function

fitness=obj_fcn;
