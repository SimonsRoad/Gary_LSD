% function [lines, w, p, n] = flsd(img_64)
function [xxx,yyy] = flsd(img_64)
%default parameter
ANG_TH = 22.5;  
QUANT = 2.0;                %Bound to the quantization error on the gradient norm;
SCALE = 0.8;
SIGMA_SCALE = 0.6;


%Angle tolerance
prec = degtorad(ANG_TH);
p = ANG_TH / 180;
rho = QUANT / sin(prec);  % Gradient magnitude threshold

%Gaussian smoothing and resize
if SCALE ~= 1
    %Gaussian blur 
    if SCALE < 1
        sigma = SIGMA_SCALE / SCALE;
    else
        sigma = SCALE;
    end
    sprec = 3;
    h = (ceil(sigma * sqrt(2 * sprec * log(10.0))));
    n = 1 + 2 * h;
    G = fspecial('gaussian', [n n], sigma);
    gaussian_img = imfilter(img_64,G,'same');
%     a = gaussian_img;
%     figure, imshow(gaussian_img);
      scaled_image = imresize(gaussian_img, SCALE, 'bilinear', 'AntiAliasing', false);
%     b = scaled_image;
%     figure, imshow(scaled_image);
%     
end
% [modgrad, angles] = imgradient(scaled_image);

%get the gradient and orientation of each pixel and sort them
[angles, modgrad, ordered_points] = ll_angle(scaled_image,5.2,1024 );

[height, width, dim] = size(scaled_image);
LOG_NT = 5 * (log10(width) + log10(height)) / 2 + log10(11.0);
min_reg_size= int16(-LOG_NT/log10(p));
used = zeros(size(scaled_image));
rec_list = zeros(0,12);
%search for line segments
[ordered_point_size, ordered_point_] = size(ordered_points);
for i = 1 : ordered_point_size
    %point = ordered_points(i, :); %[y, x, gradient]
    if used(ordered_points(i,1), ordered_points(i,2)) == 0 && angles(ordered_points(i,1), ordered_points(i,2)) ~= -1024
        [reg, reg_angle, updated_used] = region_grow(ordered_points, used, angles, modgrad, prec);
        %update used
        used = updated_used;
        
        %ignore small regions
        [reg_height, reg_width] = size(reg);
        if reg_height < min_reg_size
            continue;
        end
        
        %construct rectangular approximation for the region
        %region2rect(reg, reg_angle, prec, p rec);
        rec = region2rect(reg, reg_angle, prec, p);
        
        %add the offset
        rec(1) = rec(1) + 0.5;
        rec(2) = rec(2) + 0.5;
        rec(3) = rec(3) + 0.5;
        rec(4) = rec(4) + 0.5;
        
        %scale the result values if a sub-sampling was performed
        if SCALE ~= 1
            rec(1) = rec(1) / SCALE;
            rec(2) = rec(2) / SCALE;
            rec(3) = rec(3) / SCALE;
            rec(4) = rec(4) / SCALE;
            rec(5) = rec(5) / SCALE;
        end
        rec_list = [rec_list, rec];
    end
xxx = rec_list;
yyy = used;
end





end











% resize_img(img_64, scale);
%resize_img();
%ll_angle();
% search_line_segment{region_grow(); region2rect(); computeNFA(); 
%                     refine();  storeDATA();}
