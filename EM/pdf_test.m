% %mvnpdf(data(i,:),cparams(j).mu,cparams(j).cov)

function [pdf_G]=pdf_test(data,K,cparams)
dim=size(cparams(1).mu,2);
N=size(data,1);
for i=1:N
    for j=1:K
    cov=cparams(j).cov;
    mu=cparams(j).mu;
    pdf_G(i,j)=exp(-0.5*(data(i,:)-mu)*inv(cov)*(data(i,:)-mu)')...
               /((2*pi)^(0.5*dim)*(det(cov))^(0.5));
    end
    % Here, we can use mvnpdf here, the result is the same
end
end
