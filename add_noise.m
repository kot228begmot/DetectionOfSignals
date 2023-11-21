function [noise_signal] = add_noise(signal, SNR)
signal_power = 10 * log10(mean(abs(signal).^2));
noise_signal = awgn(signal, SNR, signal_power);
end