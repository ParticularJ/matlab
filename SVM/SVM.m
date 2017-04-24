%������
clear all;
clc;
C = 100;
kertype = 'linear';
%ѵ������
n =50;
randn('state',5);%���Ա�֤ÿ��ÿ�β����������һ��
x1 = randn(2,n);    %2��N�о���
y1 = ones(1,n);       %1*N��1��һ�����
x2 = 5+randn(2,n);   %2*N����
y2 = -ones(1,n);      %1*N��-1�ڶ������

figure;
plot(x1(1,:),x1(2,:),'x',x2(1,:),x2(2,:),'k.'); %�ֱ𻭳�x1��x2���еĵ�
axis([-2 8 -2 8]);  %����ķ�Χ
xlabel('x��');
ylabel('y��');
hold on;

X = [x1,x2];        %ѵ������d*n����nΪ����������dΪ�������������������XΪһ��2*100������
Y = [y1,y2];        %ѵ��Ŀ��1*n����nΪ����������ֵΪ+1��-1�������YΪһ��1*100������
svm = svmTrain(X,Y,kertype,C);
plot(svm.Xsv(1,:),svm.Xsv(2,:),'ro');%����֧������

%����
[x1,x2] = meshgrid(-2:0.1:8,-2:0.1:8);  %���ڻ��Ʒָ���
[rows,cols] = size(x1);   %����x1������������
nt = rows*cols;                  
Xt = [reshape(x1,1,nt);reshape(x2,1,nt)];  %��x1,x2�����1*nt
Yt = ones(1,nt);
result = svmTest(svm, Xt, Yt, kertype);

Yd = reshape(result.Y,rows,cols);
contour(x1,x2,Yd,'m');

