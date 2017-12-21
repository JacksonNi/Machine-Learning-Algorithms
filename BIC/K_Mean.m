function [p,p1]=K_Mean(data,N,K,iteration)
% K is the no. of clusters, r is the no. of times that algorithm runs
% N is the no. of Samples,iteration is the no. of iteration during one algorithm,
% ClassIndex is the id of class----classification, a column vector

p1=randperm(N,K);
%R=unidrnd(N-r)+r;
% K-mean starts, first initialize the begining K means
for j=1:K
    data_start(j,:)=data(p1(j),:);
    data_mean(j,:)=data_start(j,:);
end
for r=1:iteration
    for i=1:N
        for j=1:K
            distance(j)=norm(data(i,:)-data_mean(j,:));
        end
        index(i)=find(distance==min(distance),1);
    end
    for j=1:K
        index_cj=find(index==j);
        data_cj=data(index_cj,:);         %data_cj is size(index_cj)*N_f Matrix
        data_mean(j,:)=mean(data_cj,1);   %data_mean is K*N_f Matrix
    end
end
for j=1:K
    for i=1:N
        distance_1(i)=norm(data(i,:)-data_mean(j,:));
    end
    p(j)=find(distance_1==min(distance_1),1);
end
end
