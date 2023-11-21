function [estimation] = step (d, fs,time_range,freq_range)
d = rescale(d,1,256);
d = log10(d);
sigma = 9;
[threshold_max,threshold_min] = treshhold_Transform(d);
if length(threshold_max) == 0  && length(threshold_min) == 0
    estimation.freq_low = 0;
    estimation.freq_high = 0;
    estimation.time_start = 0;
    estimation.time_stop = 0;
    return
end
min1=min(min(d));
max1=max(max(d));
d =(256 .* ((double(d)-double(min1))) ./ double(max1-min1));
[object,coordinate]  = canny_edge(d,sigma,threshold_max,threshold_min);
[H,W,~] = size(d);
only_broad = zeros(H,W);
for  k = 1:length(object) 
    only_broad = xor(only_broad,object{1,k});
end
[~,  time_r] = size(d);
time_range = (1 : time_r) * 1/fs;
figure()
imagesc(time_range,freq_range,d)
xlabel ('Time')
ylabel ('Frequency')
axis xy

figure()
imagesc(time_range,freq_range,only_broad)
xlabel ('Time')
ylabel ('Frequency')
axis xy

[freq_step,Time_step,~] = size(d);
 T_for_sample = Time_step/fs;
 F_for_sample = (fs*0.5)/freq_step;
for j = 1:length(object)
    estimation.freq_low(j,:) = coordinate.freq_low{1,j} * F_for_sample;
    estimation.freq_high(j,:) = coordinate.freq_high{1,j} * F_for_sample;
    estimation.time_start(j,:) = coordinate.time_start{1,j} * T_for_sample;
    estimation.time_stop(j,:) = coordinate.time_stop{1,j} * T_for_sample;  
end

end