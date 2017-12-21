function [data,labels,N,ClassIndex,d_MSE,r_c]=K_M_clustering2(AllData,K,r)
% K is the no. of clusters, r is the no. of times that algorithm runs
% N is the no. of Samples,N_iteration is the no. of iteration during one algorithm,
% ClassIndex is the id of class----classification, a column vector
sz=size(AllData);
N=sz(1);
if sz(end)<=2
    N_feature=sz(end);
    labels=zeros(N,1);
else
    N_feature=sz(end)-1;
    labels=AllData(:,sz(end));
end
data=AllData(:,1:N_feature);
data_initial=zeros(K,N_feature);
data_mean=zeros(K,N_feature);
ClassIndex=zeros(N,1);
N_ClassIndex=zeros(K,1);
r_c=0;
%R=unidrnd(N-r)+r;
% K-mean starts, first initialize the begining K means
for i=1:K
    data_initial(i,:)=data(10+round(N./(12*K))*i,:);
    data_mean(i,:)=data_initial(i,:);
end
d=zeros(K,1);
d_test=zeros(N,K);
sum_data=zeros(K,N_feature);
d_MSE=zeros(r,1);
AllClassIndex=zeros(N,r);
for iteration=1:r
    for i=1:N
        for j=1:K
            d_temp=zeros(K,1);
            for f=1:N_feature
                d_temp(j,1)=d_temp(j,1)+(data_mean(j,f)-data(i,f))^2;
            end
            d(j,1)=d_temp(j,1);
            d_test(i,j)=d(j,1);
            %d_test(2,1)=(data_mean(1,1)-data(2,1))^2+(data_mean(1,end)-data(2,end))^2;
            if j==1                  %Here, to find the index corresponding to the shortest d(j,1)
                d_min(i,1)=d(1,1);
            else
                if d_min(i,1)>=d(j,1)
                    d_min(i,1)=d(j,1);
                end
            end
        end
        for k=1:K
            if d_min(i,1)==d(k,1)
                AllClassIndex(i,r)=k-1;
                N_ClassIndex(k,1)=N_ClassIndex(k,1)+1;
                sum_data(k,:)=sum_data(k,:)+data(i,:);
            end
        end
    end
    for i_aver=1:K
        data_mean(i_aver,:)=sum_data(i_aver,:)/N_ClassIndex(i_aver,:);
    end
    d_MSE(iteration,1)=sum(d_min)/N;
end
for iteration_choose=1:r
    if d_MSE(iteration_choose,1)==min(d_MSE)
        ClassIndex(:,1)=AllClassIndex(:,iteration_choose);
        r_c=iteration_choose;
    end
end
end
