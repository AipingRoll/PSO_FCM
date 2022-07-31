function U = my_initfcm(cluster_n, data_n)


U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);
