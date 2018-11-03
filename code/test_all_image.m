% %lsd and draw
% img_path = './undistortedImage/25.png';
% %img_path = 'chairs.pgm';
% a= detect(img_path);% a is the image
% %[e, f] = flsd(a);
% % x = ll_angle(a, 0,1);
% % G = fspecial('gaussian', [3 3], 0.75);
% % a = imfilter(a,G,'same');
% % [x, y] = imgradient(a,'prewitt');
% % figure, imshow(x);
% % figure, imshow(y);
% % [angles, modgrad, list] = ll_angle(a, 5.2, 1024);
% % figure, imshow(modgrad);
% % figure, imshow(angles);
% lines_list = flsd(a);
% img = imread(img_path);
% figure,
% hold on
% imagesc(img);
% colormap bone;
% for i = 1: size(lines_list,1)
%     plot([lines_list(i,2),lines_list(i,4)],[lines_list(i,1),lines_list(i,3)],'red','linewidth',1.5);
% end
% axis ij
% hold off


% lsd  and draw
output = './undistortedImage/';
img_path = strcat(output, '%d.png');
line_path = strcat(output, 'line_%d.txt');
for j = 1:29
    img_file = sprintf(img_path,j);
    line_file = sprintf(line_path,j);
    
    a = detect(img_file);
    lines_list = flsd(a);
    lines_list = lines_list(:,1:4);
    swap = lines_list(:,1);
    lines_list(:,1) = lines_list(:,2);
    lines_list(:,2) = swap;
    swap = lines_list(:,3);
    lines_list(:,3) = lines_list(:,4);
    lines_list(:,4) = swap;
    % lines_list = and;
    fusion_lines = mergeLine(lines_list,5,5,10,180);
    % minAngleDis = 5; minDis = 5; minLen = 20; minGap = 180;


    img = imread(img_file);
    line = fusion_lines;
    figure,
    hold on
    imagesc(img);
    colormap bone;
    for i = 1: size(line,1)
         plot([line(i,1),line(i,3)],[line(i,2),line(i,4)],'red');
    end
    axis ij
    hold off
end

% % lsd store and draw
% output = './undistortedImage/';
% img_path = strcat(output, '%d.png');
% line_path = strcat(output, 'line_%d.txt');
% for j = 1:29
%     img_file = sprintf(img_path,j);
%     line_file = sprintf(line_path,j);
%     
%     a = detect(img_file);
%     lines_list = flsd(a);
%     lines_list = lines_list(:,1:4);
%     swap = lines_list(:,1);
%     lines_list(:,1) = lines_list(:,2);
%     lines_list(:,2) = swap;
%     swap = lines_list(:,3);
%     lines_list(:,3) = lines_list(:,4);
%     lines_list(:,4) = swap;
%     lines_list = lines_list';
%     lines_list = lines_list -1;
%     fileID = fopen(line_file,'w');
%     fprintf(fileID,'%d %d %d %d\n',lines_list);
%     fclose(fileID);
% 
%     img = imread(img_file);
%     line = dlmread(line_file);
%     figure,
%     hold on
%     imagesc(img);
%     colormap bone;
%     for i = 1: size(line,1)
%          plot([line(i,1)+1,line(i,3)+1],[line(i,2)+1,line(i,4)+1],'red');
%     end
%     axis ij
%     hold off
% end

% 
% % 
% % path = '/home/rpl/Downloads/jiaweit/ipol-matlab/lsd_1.6/Matlab/undistorted/';
% % path1 = strcat(path, '1.png');
% % path2 = strcat(path, 'line_1.txt');
% % img = imread(path1);
% % line = dlmread(path2);
% % figure,
% % hold on
% % imagesc(img);
% % colormap bone;
% % for i=1:size(line,1)
% %     plot([line(i,1)+1,line(i,3)+1],[line(i,2)+1,line(i,4)+1],'red');
% % end
% % axis ij
% % hold off
% 
