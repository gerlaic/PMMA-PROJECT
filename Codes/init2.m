close all;
result = zeros(5000,1);

c = 299792458;
k_0 = 2*pi* 1.0 * 1E12/c;
h_2 = 30E-6;

k = 0;
for real = 1:0.01:2
    for img = 0.01:0.01:0.5
        k = k+1;
        result(k) = evalEquation4(real+1i*img,k_0,h_2);
    end
end

fig = figure;
plot(abs(result));
title(['absolute value of difference @ 1.0THz and 30us']);
xlabel('iteration from 1~2 and 0.01i~1i');
ylabel('absolute value of difference');

saveas(gcf,'..\160606report\example2_4.fig');
print(fig,'..\160606report\example2_4','-dpng');

% subplot(211)
% real_r = real(result);
% plot(real_r);
% imag_r = imag(result);
% subplot(212)
% plot(imag_r);
