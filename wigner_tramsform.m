function [d,t,f] = wigner_tramsform(signal,Fs)
%%Параметры преобразования
%%smoothedPseudo- окно сглаживания. Выходное изображение
%%становится более чётким
%%MinThreshold = 0 - обнуляются все значения меньше нуля. Необходимо для
%%дальнейшей работы алгоритма
%%NumFrequencyPoints - размер окна по частоте
%%NumTimePoints - размер окна по времени
%%если мне не изменяет память, методики рассчёта этих окон были взяты из
%%какой то статьи


L = 2*ceil((length(signal)/2));
TWIN = 2*L/10;
FWIN = L/4;
window_FR = 2*ceil((FWIN+1)/2);
window_T = 2*(ceil(2*TWIN)+1);
%[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',window_T);
%[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',[]);
[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',length(signal));
end