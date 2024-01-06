function [object,coordinate] = bw_boundaries (border_detection)

    find_broad = border_detection;
    [H,W] = size(find_broad);
    column_zero = zeros(H+2,1);
    line_zero = zeros(1,W);
    find_broad = [line_zero;find_broad;line_zero];
    find_broad = [column_zero,find_broad,column_zero];
    [rows,columns] = size(find_broad);
    k = 0;
        while true
            signal_broad = zeros(rows,columns);
            form = [0,-1;-1,-1;-1,0;-1,1;0,1;1,1;1,0;1,-1];
            step = [1,2,3,4,5,6,7,8];
            a = 0;
                for i = 1:rows 
                    for j = 1:columns  
                        if find_broad(i,j) > 0     
                            signal_broad(i,j) = 2;
                            first_pixel = [i,j];
                            k = k + 1;
                            a = 1;
                            
                         break
                        end
                        if a==1
                        break
                        end
                    end
                end
            if i == rows && j == columns 
            break;
            else
                i = 0;
                j = 0;
            end
        ii = first_pixel(1,1);
        jj = first_pixel(1,2) - 1;
        pixel(1,1) = first_pixel(1,1);
        pixel(1,2) = first_pixel(1,2);
        i_last = 0;
        j_last = 0; 
            while true
                step = circshift(step,-1);
                er = form(step(1,1),:);
                i_last = ii;
                j_last = jj;
                ii = pixel(1,1) + er(1,1); 
                jj = pixel(1,2) + er(1,2); 
                    if find_broad(ii,jj) > 0
                        signal_broad(ii,jj) = 2;
                             if ii == first_pixel(1,1) && jj == first_pixel(1,2)
                             break;
                                
                            end
        pixel(1,1) = ii;
        pixel(1,2) = jj;
        ii = i_last;
        jj = j_last;
       step = circshift(step,+2);          
    end
    if a==2
        break;
    end
end
signal_broad_1 = signal_broad;
signal_broad_1(1,:)=[];
signal_broad_1(H+1,:)=[];
signal_broad_1(:,1)=[]; 
signal_broad_1(:,W+1)=[];

object(1,k) = {signal_broad_1};
signal_broad = imfill(signal_broad,'holes');
[x,y] = find(signal_broad_1>0);

coordinate.freq_low{1,k} = min(x);
coordinate.freq_high{1,k} = max(x);

coordinate.time_start{1, k} = min(y);
coordinate.time_stop{1, k} = max(y);


find_broad = find_broad - signal_broad;


        end