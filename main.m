%%
clear
clc
close all
%%
file_path = get_file_path();
[signal,fs] = get_signal_and_fs(file_path);
SNR = 100;
L_signal = 5000;
half_of_L = floor(L_signal/2);
signal = signal(1 : L_signal * 3 + half_of_L);
[noise_signal] = add_noise(signal, SNR);
[main_signal, overlap_signal, count_of_signal] = cut_signal(noise_signal,L_signal, half_of_L);
all_signals_massive_main = [];
all_signals_massive_overlap = [];
for i= 1:count_of_signal
    [all_signals_massive_main(:,:,i),t,f] = wigner_tramsform(main_signal(i,:),fs);
end
for i= 1:(count_of_signal - 1)
    [all_signals_massive_overlap(:,:,i),t,f] = wigner_tramsform(overlap_signal(i,:),fs);
end
srez = 500;
all_signals_massive = array_gluing(all_signals_massive_main, all_signals_massive_overlap,count_of_signal,L_signal,srez);
size_of_filt = 5;
all_signals_massive_filt = medfilter(all_signals_massive,size_of_filt);
[estimation] = step (all_signals_massive_filt, fs,t,f);
params = struct2table(estimation);
disp(params);
disp('#########');


 
 