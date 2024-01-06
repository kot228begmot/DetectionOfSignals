function [whole_signal] = array_gluing(main_signal, overlap_signal, signal_number,signal,srez,fs)
overlap = [];
whole_signal =  main_signal(:,1:length(main_signal(:,:,1)) - srez, 1);
main = [];
for i=1:signal_number - 1
    main = main_signal(:,srez:length(main_signal(:,:,i + 1)) - srez - 1, i + 1);
    [~, weig] = size(overlap_signal(:,:,i));
    overlap = overlap_signal(:,floor(weig/2)-srez:floor(weig/2)+srez - 1,i);
    whole_signal = [whole_signal,overlap, main,];
end




