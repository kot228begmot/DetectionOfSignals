function [main_signal, overlap_signal, count_of_signal_1] = cut_signal(signal,L_signal, half_of_L)
if (L_signal + half_of_L) >  length(signal)
    msg='Отсутствует необходимое количество отсчётов';
    error(msg)
end
count_of_signal_1 = floor((length(signal) - half_of_L)/L_signal);
count_of_signal_2 = count_of_signal_1 - 1;
signal_main = signal(1:length(signal) - half_of_L)';
main_signal = reshape(signal_main,  L_signal, count_of_signal_1)';
new_cut = signal(half_of_L:L_signal * count_of_signal_2 + half_of_L - 1)';
overlap_signal = reshape(new_cut,  L_signal, count_of_signal_2)';
end








