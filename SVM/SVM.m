%主函数
clear all;
clc;
C = 100;
kertype = 'linear';
%训练样本
n =50;
randn('state',5);%可以保证每次每次产生的随机数一样
x1 = randn(2,n);    %2行N列矩阵
y1 = ones(1,n);       %1*N个1第一个类别
x2 = 5+randn(2,n);   %2*N矩阵
y2 = -ones(1,n);      %1*N个-1第二个类别

figure;
plot(x1(1,:),x1(2,:),'x',x2(1,:),x2(2,:),'k.'); %分别画出x1和x2所有的点
axis([-2 8 -2 8]);  %坐标的范围
xlabel('x轴');
ylabel('y轴');
hold on;

X = [x1,x2];        %训练样本d*n矩阵，n为样本个数，d为特征向量个数，在这里，X为一个2*100的数组
Y = [y1,y2];        %训练目标1*n矩阵，n为样本个数，值为+1或-1，在这里，Y为一个1*100的数组
svm = svmTrain(X,Y,kertype,C);
plot(svm.Xsv(1,:),svm.Xsv(2,:),'ro');%画出支持向量

%测试
[x1,x2] = meshgrid(-2:0.1:8,-2:0.1:8);  %用于绘制分隔线
[rows,cols] = size(x1);   %返回x1的行数和列数
nt = rows*cols;                  
Xt = [reshape(x1,1,nt);reshape(x2,1,nt)];  %将x1,x2，变成1*nt
Yt = ones(1,nt);
result = svmTest(svm, Xt, Yt, kertype);

Yd = reshape(result.Y,rows,cols);
contour(x1,x2,Yd,'m');

