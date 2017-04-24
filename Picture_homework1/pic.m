clc;
clear;
RGB = imread('1.jpg');
figure;imshow(RGB);title('原图');
metric1=test;

I = rgb2gray(RGB);
threshold = graythresh(I);
bw = im2bw(I,threshold);
bw=~bw;
bw = bwareaopen(bw,30);
se = strel('disk',2);
bw = imclose(bw,se);
bw = imfill(bw,'holes');
[B,L] = bwboundaries(bw,'noholes');
figure;imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
stats = regionprops(L,'Area','Centroid');
threshold=0.005;
for k = 1:length(B)
    boundary = B{k};
    delta_sq = diff(boundary).^2;
    %周长
    perimeter = sum(sqrt(sum(delta_sq,2)));
    %面积
    area = stats(k).Area;
    %圆形度
    metric = 4*pi*area/perimeter^2;
    metric_string = sprintf('%2.3f',metric);
    if   (metric1-threshold<metric)&&(metric <metric1+threshold)
      centroid = stats(k).Centroid;
      plot(centroid(1),centroid(2),'kh','LineWidth',12, 'MarkerEdgeColor','r','MarkerFaceColor','w','MarkerSize',13);
    end
    text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','w',...
       'FontSize',10,'FontWeight','bold');
end

title('结果'); 


