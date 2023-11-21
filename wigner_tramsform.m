function [d,t,f] = wigner_tramsform(signal,Fs)
%%Параметры преобразования
%%smoothedPseudo- окно сглаживания. Выходное изображение
%%становится более чётким
%%MinThreshold = 0 - обнуляются все значения меньше нуля. Необходимо для
%%дальнейшей работы алгоритма
%%NumFrequencyPoints - размер окна по частоте
%%NumTimePoints - размер окна по времени

L = 2*ceil((length(signal)/2));
FWIN = L/4;
window_FR = 2*ceil((FWIN+1)/2);
[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',length(signal));
end