function [threshold_max,threshold_min] = treshhold_Transform(d)%Otsu method

[Frequency,bins] = imhist(d);
%[Frequency,bins] = hist(d(:), 256);
%Frequency = Frequency';
[M,N,~] = size(d);
probably_P1 = Frequency(:)/(M*N);
global_mean = sum((1:256)* probably_P1);
global_var = sum(((1:256) - global_mean).^2 * probably_P1);
%global_var = var(probably_P1(:));
T = (1 :1:257);
for k = 1:length(T)-1
P1 = sum(probably_P1(1:k));%накопленные суммы
P2 = 1 - P1;
m1 = sum((probably_P1(1:k) .* (1:k)'))/P1;%накопленна€ сумма до уровн€ €ркости  
m2 = sum((probably_P1(k+1:length(T)-1) .* (k+1:length(T)-1)'))/P2;
razdelimost(k) = P1*P2*(m1-m2)^2;%межклассова€ дисперси€
end
[x y] = min(find(razdelimost==max(razdelimost)));
%max_T =  T(razdelimost==max(razdelimost));
bins = bins';
threshold_max = bins(y,x);
threshold_min = threshold_max/3;
end