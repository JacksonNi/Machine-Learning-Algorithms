% Compute BIC scores
% M is no. of free parameter,here K_var is a variable
clc;  
clear;  
close all;  

load('a3geyser.mat'); 
Label='0';
K_max=10;
BIC_vector=zeros(K_max,1);
R=50;
for K_var=1:K_max
    [Q_vector,d,N,R_real,aaaa,p_set]=EM_function(K_var,R,a3geyser,Label);
    M=K_var-1+K_var*d+K_var*d*(d+1)/2; 
    BIC_vector(K_var,1)=max(Q_vector)-0.5*M*log(N);
end
i=1:1:K_max;
plot(i, BIC_vector);
%title('BIC scores with K changing');
xlabel("Cluster Size");
ylabel("BIC");


% a=0.001*eye(5);
%  cov_dig=diag(a);
%  for j=1:K
% 
%         if cov_dig(i)<=0.01
%             a(i,i)=0.01;
%         end
%     end


