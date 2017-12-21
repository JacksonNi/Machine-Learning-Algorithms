%E-Step
function [Q,mean_z,p1]=E_Step(N,K,data,cparams)
Q=0;

[p1]=pdf_test(data,K,cparams);%p1£º N*K
A=[];
for s=1:K
    A=[A;cparams(s).prior];  % A is K*1 matrix
end
p2=p1*A ;          % p2 is a N*1 matrix
for i=1:N
    %    p2=zeros(N,1);
    %     for s=1:K
    %         %         p1=p1+mvnpdf(data(i,:),cparams(s).mu,cparams(s).cov)*...
    %         %         cparams(s).prior;
    %         p2(i,1)=p2(i,1)+p1(i,s)*cparams(s).prior;
    %     end
    %p2=p1*A ;          % p2 is a N*1 matrix
    for j=1:K
        mean_z(i,j)=p1(i,j)*cparams(j).prior/p2(i,1);
        Q=Q+mean_z(i,j)*log(p1(i,j)*cparams(j).prior);
        %         [p2]=pdf_test(data(i,:),cparams(j).mu,cparams(j).cov);
        %         mean_z(i,j)=p2*cparams(j).prior/p1;
        %         a=a+mean_z(i,j)*log(p2*cparams(j).prior);
    end
end
end
