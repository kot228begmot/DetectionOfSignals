function [d,t,f] = wigner_tramsform(signal,Fs)
%%��������� ��������������
%%smoothedPseudo- ���� �����������. �������� �����������
%%���������� ����� ������
%%MinThreshold = 0 - ���������� ��� �������� ������ ����. ���������� ���
%%���������� ������ ���������
%%NumFrequencyPoints - ������ ���� �� �������
%%NumTimePoints - ������ ���� �� �������
%%���� ��� �� �������� ������, �������� �������� ���� ���� ���� ����� ��
%%����� �� ������


L = 2*ceil((length(signal)/2));
TWIN = 2*L/10;
FWIN = L/4;
window_FR = 2*ceil((FWIN+1)/2);
window_T = 2*(ceil(2*TWIN)+1);
%[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',window_T);
%[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',[]);
[d,f,t] = wvd(signal,Fs,'smoothedPseudo','MinThreshold',0,'NumFrequencyPoints',window_FR,'NumTimePoints',length(signal));
end