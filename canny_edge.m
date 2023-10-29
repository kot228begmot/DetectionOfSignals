function [object,coordinate] = canny_edge(d,sigma,threshold_max,threshold_min)
option = 2; %1- новый, 2- старый
razr = 20;%промежуток устранения разрывов
matrix_filter = fspecial('gaussian', ceil(6*sigma)+1, sigma);
img_svertka = conv2(d,matrix_filter,'same');
[gx, gy] = gradient(img_svertka);
[H,W] = size(gx);
Gradient = zeros(size(gx));
for i = 1:H
    for ii = 1:W
       Gradient(i,ii) = sqrt(gx(i,ii)^2+gy(i,ii)^2);
    end
end
non_max = Gradient;
column_zero = zeros(H+2,1);
line_zero = zeros(1,W);
non_max = [line_zero;non_max;line_zero];
non_max = [column_zero,non_max,column_zero];
for i = 2:1:H-1
    for ii = 2:1:W-1
        if gx(i,ii) == 0
            tanget = 5;
        else
            tanget = (gy(i,ii)/gx(i,ii));
        end
        if (-0.4142<tanget & tanget<=0.4142)
            if (Gradient(i,ii)<Gradient(i,ii+1) | Gradient(i,ii)<Gradient(i,ii-1))
                non_max(i,ii) = 0;
            end       
        end
        if  (0.4142<tanget & tanget<=2.4142)
            if (Gradient(i,ii)<Gradient(i-1,ii+1) | Gradient(i,ii)<Gradient(i+1,ii-1))
                non_max(i,ii) = 0; 
            end
        end       
        if (abs(tanget)> 2.4142)
            if (Gradient(i,ii)<Gradient(i-1,ii) | Gradient(i,ii)<Gradient(i+1,ii))
                non_max(i,ii) = 0;   
            end
        end  
         if  (-2.4142<tanget & tanget<=-0.4142)
            if (Gradient(i,ii)<Gradient(i-1,ii-1) | Gradient(i,ii)<Gradient(i+1,ii+1))
                non_max(i,ii) = 0; 
            end
         end       
    end 
end
sravn_hysteresis = non_max;
for i = 2:1:H-1
    for ii = 2:1:W-1
        if sravn_hysteresis(i,ii)>= threshold_max
            sravn_hysteresis(i,ii) = 2;
        end
        if sravn_hysteresis(i,ii)>= threshold_min & sravn_hysteresis(i,ii)< threshold_max
            sravn_hysteresis(i,ii) = 1;
        end
        if sravn_hysteresis(i,ii)< threshold_min
            sravn_hysteresis(i,ii) = 0;
        end   
    end
end
for i = 2:1:H-1
    for ii = 2:1:W-1
        if sravn_hysteresis(i,ii)>0
            if sravn_hysteresis(i,ii) == 1
                if (sravn_hysteresis(i-1,ii-1)==2 | sravn_hysteresis(i-1,ii)==2 | sravn_hysteresis(i-1,ii+1)==2 | sravn_hysteresis(i,ii-1)==2 | sravn_hysteresis(i,ii+1)==2 | sravn_hysteresis(i+1,ii-1)==2 | sravn_hysteresis(i+1,ii)==2 | sravn_hysteresis(i+1,ii+1)==2)
                    sravn_hysteresis(i,ii) = 1;
                    ww=1;
                else
                    sravn_hysteresis(i,ii) = 0;
                end
                
            end
        end
    end
end

find_broad = sravn_hysteresis;
        
find_broad(:,1)=[]; %снять после трассиррвки границ
find_broad(:,W)=[];
find_broad(1,:)=[];
find_broad(H,:)=[];
        
        
if option == 1  
    [E,R] = size(sravn_hysteresis);
        for i = razr:1:E-razr%подумать как поправить принцип работы. Ухожу вверх
            for ii = razr:1:R-razr
                if sravn_hysteresis(i,ii) == 0%можно выкинуть проверку "вверх"
                    if   sum(sravn_hysteresis(i,ii+1:ii+razr)) >= 1 | sum(sravn_hysteresis(i,ii+1:ii-razr)) >= 1 |...
                            sum(sravn_hysteresis(i+1:i+razr,ii)) >= 1 | sum(sravn_hysteresis(i+1:i-razr,ii)) >= 1         
                        find_broad(i,ii) = 1;          
                    end
                end
            end
        end

        
se = strel('rectangle',[25,13]); %создали прямоугольный элемент структурирования
border_detection_1 = imerode(find_broad,se);
se = strel('rectangle',[15,15]);
border_detection = imopen(border_detection_1,se);
else 
    se = strel('rectangle',[20,20]);
    matrix_filter_column = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;];
    matrix_filter_line = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
    after_droad_1 = imdilate(find_broad,matrix_filter_column,1);
    after_droad_1 = imdilate(after_droad_1,matrix_filter_line,1);%new
    after_droad = imerode(after_droad_1,se,1);
    se = strel('rectangle',[15,15]);
    border_detection = imopen(after_droad,se);%сам процесс удаления 
end
% Отзеркалить изображения!
[object,coordinate] = bw_boundaries (border_detection);
end