function [signal, fs] = get_signal_and_fs(signal_file_path)
if exist(signal_file_path, 'file') ==0
    msg='В указанной директории отсутствует файл';
    error(msg)
end
[ ~ , ~ , ext ] = fileparts(signal_file_path);
if ext ~= ".mat"
    msg = 'Сигнал неверного формата. Поддерживается расширение .mat';
    error(msg)
end
file = load(signal_file_path);
%signal = file.s;
%fs = file.Fs;
signal = file.smatrf(:,3);
fs = 306000000;
end 