%һ���޸ĺ��PCA��������ʶ���Matlab����

% calc xmean,sigma and its eigen decomposition
allsamples=[];%����ѵ��ͼ��
for i=1:16
      a=imread(strcat('C:\Myself\example\matlab\Picture_homework2\',num2str(i),'.jpg'));
      b=rgb2gray(a);
      c=b(1:150*100); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������
      c=double(c);
      allsamples=[allsamples; c];  % allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��200
end

   samplemean=mean(allsamples); % ƽ��ͼƬ��1 �� N
   for i=1:16 
      xmean2(i,:)=allsamples(i,:)-samplemean; % xmean��һ��M �� N����xmeanÿһ�б���������ǡ�ÿ��ͼƬ����-ƽ��ͼƬ��
  end;
 % 
  sigma=xmean2*xmean2';   % M * M �׾���
  [v d]=eig(sigma);
  d1=diag(d);
  [d2 index]=sort(d1); %����������
  cols=size(v,2);% �����������������
  for i=1:cols
      vsort2(:,i) = v(:, index(cols-i+1) ); % vsort ��һ��M*col(ע:colһ�����M)�׾��󣬱�����ǰ��������е���������,ÿһ�й���һ����������
      dsort2(i)   = d1( index(cols-i+1) );  % dsort ������ǰ��������е�����ֵ����һά������
  end  %��ɽ�������
 %����ѡ��90%������
  dsum = sum(dsort2);
      dsum_extract = 0;
      p = 0;
      while( dsum_extract/dsum < 0.98)
          p = p + 1;
          dsum_extract = sum(dsort2(1:p));
      end
 
  i=1;
  % (ѵ���׶�)�����������γɵ�����ϵ
  while (i<=p && dsort1(i)>0)
      base2(:,i) = dsort2(i)^(-1/2) * xmean2' * vsort2(:,i);   % base��N��p�׾��󣬳���dsort(i)^(1/2)�Ƕ�����ͼ��ı�׼�������������PCA������ʶ���㷨�о���p31
      i = i + 1;
 end
 % 
 % add by wolfsky �����������д��룬��ѵ������������ϵ�Ͻ���ͶӰ,�õ�һ�� M*p �׾���allcoor
  allcoor = allsamples * base2;
  accu = 0;
 % 
 % ���Թ���
    % for j=1:1 %����40 x 5 ������ͼ��
         a=imread(strcat('C:\Myself\example\matlab\Picture_homework2\17.jpg'));
        b=rgb2gray(a);
        figure; imshow(b);hold on;title('ԭͼ');
        c=b(1:150*100); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������
        c=double(c);
         tcoor= c * base2; %�������꣬��1��p�׾���
         for k=1:16 
                 mdist2(k)=norm(tcoor-allcoor(k,:));
         end;
         %���׽��� 
         [dist,index2]=sort(mdist2);
         figure;
         for i=1:14
            if dist(i)<1.0e+004*0.9 
                
                b=imread(strcat('C:\Myself\example\matlab\Picture_homework2\',num2str(index2(i)),'.jpg'));
                 name= sprintf('%d.jpg',index2(i));
                 subplot(1,3,i);imshow(b);title(name);
            end
         end
         
%          class1=floor( index2(1)/5 )+1;
%          class2=floor(index2(2)/5)+1;
%          class3=floor(index2(3)/5)+1;
%          if class1~=class2 && class2~=class3
%              class=class1;
%          elseif class1==class2
%              class=class1;
%          elseif class2==class3
%              class=class2;
%          end;
%          
%          if class==i
%              accu=accu+1;
%          end;