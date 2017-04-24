function metric1=test
RGB = imread('2.jpg');
I = rgb2gray(RGB);
threshold = graythresh(I);
bw = im2bw(I,threshold);
bw=~bw;
bw = bwareaopen(bw,30);
se = strel('disk',2);
bw = imclose(bw,se);
bw = imfill(bw,'holes');
[B,L] = bwboundaries(bw,'noholes');
figure;imshow(bw);title('����ͼ');
hold on 

  boundary = B{1};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)

stats = regionprops(L,'Area','Centroid');
    boundary = B{1};
    delta_sq = diff(boundary).^2;
    %�ܳ�
    perimeter = sum(sqrt(sum(delta_sq,2)));
    %���
    area = stats.Area;
    %Բ�ζ�
    metric1 = 4*pi*area/perimeter^2;

