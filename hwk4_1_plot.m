% AllData=xx';%gauss2_dataset;
% K=2;
% r=100;
% [Data_1,Labels_1,N_1,ClassIndex_1,d_MSE,r_c]=K_M_clustering2(AllData,K,r)
% for i=1:N_1
%     if ClassIndex_1(i,1)==0
%         subplot(1,3,1);
%         xlabel("The value of x1");
%         ylabel("The value of x2");
%         scatter(Data_1(i,1),Data_1(i,2),'+','r');
%         grid on;
%         hold on;
%     end
%     if ClassIndex_1(i,1)==1
%         scatter(Data_1(i,1),Data_1(i,2),'*','b');
%         hold on;
%     end
%     if ClassIndex_1(i,1)==2
%         scatter(Data_1(i,1),Data_1(i,2),'o','g');
%         hold on;
%     end
%     title('Scatter plot based on k-mean');
% end
% for i=1:N_1
%     if Labels_1(i,1)==1
%         subplot(1,3,2);
%         xlabel("The value of x1");
%         ylabel("The value of x2");
%         scatter(Data_1(i,1),Data_1(i,2),'+','r');
%         grid on;
%         hold on;
%     end
%     if Labels_1(i,1)==2
%         scatter(Data_1(i,1),Data_1(i,2),'*','b');
%         hold on;
%     end
%     if Labels_1(i,1)==3
%         scatter(Data_1(i,1),Data_1(i,2),'o','g');
%         hold on;
%     end
%     title('Scatter plot based on real condition');
% end
% A=1:1:r
% subplot(1,3,3);
% plot(A,d_MSE(:,1));
% title('MSE of iteration number in K-means');
% grid on;
% xlabel("The value of iterations");
% ylabel("The value of MSE");
% %axis([0,25,0.4,2]);


AllData=xx';%gauss2_dataset;
K=10;
r=100;
[Data_1,Labels_1,N_1,ClassIndex_1,d_MSE,r_c]=K_M_clustering2(AllData,K,r)
symbol=['+','*','o','x','s','d','>','<','p','h'];
color=['r','b','g','c','m','y','k','w','r','b'];
for i=1:N_1
    for j=1:K
        if ClassIndex_1(i,1)==j-1
            subplot(1,2,1);
            xlabel("The value of x1");
            ylabel("The value of x2");
            scatter(Data_1(i,1),Data_1(i,2),symbol(j),color(j));
            grid on;
            hold on;
        end
    end
    title('Scatter plot based on k-mean');
end

A=1:1:r
subplot(1,2,2);
plot(A,d_MSE(:,1));
title('MSE of iteration number in K-means');
grid on;
xlabel("The value of iterations");
ylabel("The value of MSE");
%axis([0,25,0.4,2]);