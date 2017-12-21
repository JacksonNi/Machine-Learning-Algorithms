function [Q_vector,N_f,N,R_real,aaaa,p_set]=EM_function(K,R,Data,Label)
%R=100;      % the maximum iteration times
             % here, we cannot copy with data, which is unlabeled

[data,~,~,N,N_f,~]=GetData(Data,Label);
% Here, to get BIC, we set # of samples as K_vari, so we won't get real K
% by the function GetData



%then, initialization of cparams, including prior,mean,covariance

[p,p1]=K_Mean(data,N,K,3);
%Here, p is indexes decided by K_Means after 3 iterations
%      p1 is random indexes,like p1=randperm(N,K);
p_set=p;
for j=1:K
    cparams(j).prior=1/K;
    cparams(j).mu=data(p_set(j),:);
    cparams(j).cov=eye(N_f);   %initialization of covariance = identity matrix
end

very_small = mean(std(data))*(1/K)*0.0001;
% very_small is the threshold to solve singular problem based on one web, but it really
% depends.Here is the web http://www.cs.tut.fi/~tohkaj/matlab_code/emclustering.m

%Start EM
for iteration=1:R
    [Q,mean_z,p1]=E_Step(N,K,data,cparams);
    [cparams]=M_Step(N,K,data,N_f,mean_z,very_small);
    Q_vector(iteration,1)=Q;                    %Q_vector save the value of Q for many times
    % Use if to limit the value of iteration
    if iteration>1&&(Q-Q_vector(iteration-1,1))<=0.001*abs(Q_vector(iteration-1,1))
        aaaa=0.00000001;
        R_real=iteration;
        break;
    end
    R_real=R;
    aaaa=0.1;
end
end