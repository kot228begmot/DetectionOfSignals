function [res] = medfilter(signal, size_of_med_filt)
res = medfilt2(signal,[size_of_med_filt,size_of_med_filt]);
end