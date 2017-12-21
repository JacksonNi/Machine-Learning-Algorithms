%M_Step
function [cparams]=M_Step(N,K,data,N_f,mean_z,threshold)
sum1=sum(mean_z,1)/N;   %Here, sum1 is a 1*K matrix
for j=1:K
    cparams(j).prior=sum1(j);
    sum2=zeros(1,N_f);
    for i=1:N
        sum2=sum2+mean_z(i,j)*data(i,:);
    end
    cparams(j).mu=sum2/(N* cparams(j).prior);
    sum3=zeros(N_f,N_f);
    for i=1:N
        sum3=sum3+mean_z(i,j)*(data(i,:)-cparams(j).mu)'*...
            (data(i,:)-cparams(j).mu);
    end
    cparams(j).cov=sum3/(N*cparams(j).prior);
    
    % singular solution£¬ if this solution is not good,
    tol= N_f*norm(cparams(j).cov)*eps*4;
    for i=1:N_f
        if  cparams(j).cov(i,i)<=threshold
            cparams(j).cov=cparams(j).cov+eye(N_f)*max(threshold,tol)*3;
            break;
        end
    end
    
end
end