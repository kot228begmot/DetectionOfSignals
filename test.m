%%
close all
clc
clear
x1 = sin(2 * pi * 10 * (0:255)' * 1/400);
x2 = sin(2 * pi * 50 * (0:255)' * 1/400);
res = x1 + x2;
figure();wvd(res, 400);
%%
close all
clc
clear
x1 = sin(2 * pi * 10 * (0:255)' * 1/400);
x2 = sin(2 * pi * 50 * (0:255)' * 1/400);
res = x1 + x2;
figure();wvd(hilbert(res), 400);
%%
close all
clc
clear
x1 = 1j * sin(2 * pi * 10 * (0:255)' * 1/400);
figure();wvd(x1, 400);
%%

x1 = -1j * sin(2 * pi * 10 * (0:255)' * 1/400);
x2 = cos(2 * pi * 50 * (0:255)' * 1/400);
res = x1 + x2;
figure();wvd(res, 400);
%%
close all
x1 = 1j * sin(2 * pi * (-10) * (0:255)' * 1/400);
x2 = cos(2 * pi * 50 * (0:255)' * 1/400);
res1 = imag(x1 + x2);
res2 = real(x1 + x2);
figure();wvd((res1), 400);
figure();wvd((res2), 400);
%%
close all
x1 = -1j * sin(2 * pi * (-50) * (0:255)' * 1/400)-1j * cos(2 * pi * (-100) * (0:255)' * 1/400);
x2 =  sin(2 * pi * 50 * (0:255)' * 1/400);
res1 = imag(x1);
res2 = real(x1);
figure();wvd((res1), 400);
figure();wvd((res2), 400);
figure();wvd((x2), 400);