function [x_fft,freq_vec,df,x_power] = td2fd(t,a)

fs = 1/(t(2)-t(1));

x = a;

x_fft = fft(x);
x_fft = x_fft(1:length(x)/2+1)/length(x);
x_abs = abs(x_fft);
x_power = x_abs.*conj(x_abs);
df = fs/length(x);

len = floor(5/df);
freq_end = df*(len-1);

freq_vec = 0:df:freq_end;
x_fft = x_fft(1:len);
x_power = x_power(1:len);


figure
plot(freq_vec,x_power);
axis([0 5 0 3E-6]);
xlabel('freq');
ylabel('power');
title('power from fft');
