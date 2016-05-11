function result=easySolvingForThirdRoundV2(order,k_0,r,h_2)

startPoint = 4;
endPoint = 6.0;
real_s = 0.01;

img_start = 0.0;
img_end = -2.0;
img_s = -0.001;

delta = zeros(1,15300);
f_list = zeros(1,15300);
n2_list = zeros(1,15300);

index = 0;
for j=startPoint:real_s:endPoint
    for jj=img_start:img_s:img_end

        n2 = j+jj*1i;
        index = index+1;

        calculated_value = evalEquation2(n2,order,k_0,h_2);
        
        f_list(index) = calculated_value;
        delta(index) = calculated_value-r;
        n2_list(index) = n2;

    end
end

figure
subplot(311)
plot(real(delta));
subplot(312)
plot(imag(delta));
subplot(313)
plot(abs(delta));

%[dminimum, min_index] = min(abs(delta));
[dminimum, min_index] = findMin(delta);

result = [n2_list(min_index),dminimum];