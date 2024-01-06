function [d,t,f] = wigner_tramsform(signal,Fs)
L = 2*ceil((length(signal)/2));
FWIN = L/4;
window_FR = 2*ceil((FWIN+1)/2);
[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',length(signal));
end