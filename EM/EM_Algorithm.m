clc;
clear;
close all;

R=100;      % the maximum iteration times
symbol=['+','*','o','x','s','d','>','<','p','h'];
color=['r','b','g','c','m','y','k','w','r','b'];

load('gauss3_dataset.mat');                     % here, we cannot copy with data, which is unlabeled

Label='1';          % ¡®1¡¯means data is labeled, otherwise unlabeled
[data,label,data_all,N,N_f,K]=GetData(gauss3_dataset,Label);

if Label~='1';                %Label~='1', means data is not labeled
    K=4;                      %no labels, just guess the value of K
end

very_small = mean(std(data))*(1/K)*0.0001;
% very_small is the threshold to solve singular problem based on one web, but it really
% depends.Here is the web http://www.cs.tut.fi/~tohkaj/matlab_code/emclustering.m

%then, initialization of cparams, including prior,mean,covariance

[p,p1]=K_Mean(data,N,K,3);
%Here, p is indexes decided by K_Means after 3 iterations
%      p1 is random indexes,
p_set=p;
for i=1:K
    cparams(i).prior=1/K;
    cparams(i).mu=data(p_set(i),:);
    cparams(i).cov=eye(N_f)    %initialization of covariance = identity matrix
end
% Data is labeled,plot based on the initial parameter
for j=1:K
    xlabel("The value of x1");
    ylabel("The value of x2");
    subplot(1,3,1);
    %plot_gauss(data_all.Cj, cparams(j).mu, cparams(j).cov,1,2, symbol(j),color(j), 5, 1);
    if Label=='1'
        eval(['plot_gauss(data_all.C',num2str(j),', cparams(',num2str(j),').mu, cparams(',num2str(j),...
            ').cov,1,2, symbol(',num2str(j),'),color(',num2str(j),'), 5, 1);']);
    else
        %plot_gauss(data_all.C, cparams(j).mu, cparams(j).cov,1,2, symbol(1),color(1), 5, 1);
        eval(['plot_gauss(data_all.C, cparams(',num2str(j),').mu, cparams(',num2str(j),...
            ').cov,1,2, symbol(1),color(1), 5, 1);']);
    end
    grid on;
    hold on;
    title('Plot based on the initial parameter by EM');
end




%Start EM

for iteration=1:R
    [Q,mean_z,p1]=E_Step(N,K,data,cparams);
    [cparams]=M_Step(N,K,data,N_f,mean_z,very_small);
    Q_vector(iteration,1)=Q;                    %Q_vector save the value of Q for many times
    % Use if to limit the value of iteration
    if iteration>1&&abs(Q-Q_vector(iteration-1,1))<=0.001*abs(Q_vector(iteration-1,1))
        aaaa=0.00000001;
        R_real=iteration;
        break;
    end
    R_real=R;
end


for j=1:K
    xlabel("The value of x1");
    ylabel("The value of x2");
    subplot(1,3,2);
    %plot_gauss(data_all.Cj, cparams(j).mu, cparams(j).cov,1,2, symbol(j),color(j), 5, 1);
%     eval(['plot_gauss(data_all.C',num2str(j),', cparams(',num2str(j),').mu, cparams(',num2str(j),...
%         ').cov,1,2, symbol(',num2str(j),'),color(',num2str(j),'), 5, 1);']);
    
      if Label=='1'
        eval(['plot_gauss(data_all.C',num2str(j),', cparams(',num2str(j),').mu, cparams(',num2str(j),...
            ').cov,1,2, symbol(',num2str(j),'),color(',num2str(j),'), 5, 1);']);
    else
        %plot_gauss(data_all.C, cparams(j).mu, cparams(j).cov,1,2, symbol(1),color(1), 5, 1);
        eval(['plot_gauss(data_all.C, cparams(',num2str(j),').mu, cparams(',num2str(j),...
            ').cov,1,2, symbol(1),color(1), 5, 1);']);
    end
    
    
    
    grid on;
    hold on;
    title('Plot based on the final parameter by EM');
end
rr=1:1:R_real;
subplot(1,3,3);
plot(rr,Q_vector);
grid on;
xlabel("The value of iterations");
ylabel("The value of Q(logLikelihodd)");
title('Q based on iterations in EM');



