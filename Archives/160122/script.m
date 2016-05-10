close all;

data = xlsread('Sample02_A_357kN_132ps_TD.xlsx');
data2 = xlsread('Sample02_A_357kN_132ps_power.xlsx');
sample_f = data2(:,1);
sample_a = data2(:,2);

t=data(:,1);

fs = 1/(t(2)-t(1));

x = data(:,2);
x_fft = fft(x);
x_fft = x_fft(1:length(x)/2+1)/length(x);
x_abs = abs(x_fft);
x_power = x_abs.*conj(x_abs);
df = fs/length(x);
freq_vec = 0:df:fs/2;

figure;
subplot(2,1,1);
plot(sample_f, sample_a);
axis([0 5 0 3E-6]);
xlabel('freq');
ylabel('power');
title('data from Sample02 A 357kN 132ps power')

subplot(2,1,2);
plot(freq_vec,x_power);
axis([0 5 0 3E-6]);
xlabel('freq');
ylabel('power');
title('power from fft');

figure;
plot(sample_f, sample_a);
hold;
plot(freq_vec,x_power,'r');
axis([0 5 0 3E-6]);
xlabel('freq');
ylabel('power');
title('Both Power_s in one Plot');