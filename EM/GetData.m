function [data,label,data_all,N,N_f,K]=GetData(Data,Label)
%Here, Data is the original data, Label='exist'means the last column of
%      Data is label,otherwise label=label=zeros(N,1);
%      data_all is struct to save Ci,if there is no labels, only one
%      data_all.C will be here
%      data is the data without label;
%      N is # of samples, N_f is # of features, K is # of classes
if size(Data,1)<size(Data,2)
    Data=Data';
end
N=size(Data,1);
if Label=='1'                   % Label=='1'  means data is labeled, otherwise no labels
    N_f=size(Data,2)-1;
    label=Data(:,end);
    K=size(unique(label),1);
    data=Data(:,1:N_f);
    for j=1:K
        min_label=min(label);                    % Usually, min_label=0 or 1;
        %temp=Data(find(label==j-1+min_label),:);
        %data_all.Cj=data(find(label==j-1+min_label),:);
        eval(['data_all.C',num2str(j),'=Data(find(label==',num2str(j),'-1+min_label),:);']);
    end
else
    N_f=size(Data,2)
    label=zeros(N,1);
    K=0;                        %here, K=0 means we do not know the real value of K
    data=Data(:,1:N_f);
    data_all.C=data;
end
end