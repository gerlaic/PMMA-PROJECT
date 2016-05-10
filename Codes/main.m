%   main.m
%   This is the main script for solving for n2 of the material

% The program structure can be found in the sum_up.pptx PAGE 2

function result = main(testDataFile, refDataFile)

close all;

c = 3E8;% Speed of light m/s

real_threshold = 0.00001; 
img_threshold = 0.000001;% maximum allowable error
max_order = 25;%max levels of iteration 

%   Import Data
[time, amplitude] = importData(testDataFile);
[timeR,amplitudeR] = importData(refDataFile);

%   Convert TD -> FD
[x_fft,freq,df,x_power] = td2fd(time,amplitude);
[x_fftR,~,~,x_powerR] = td2fd(timeR,amplitudeR);

%   Normalize
x_fft = x_fft./x_fftR;
x_power = x_power./x_powerR;

%   Show how the normalized data look like
% figure;
% plot(freq,x_power);
% title('freq vs power after normalize');

%   freq range we are going to use :
%   0.7THz ~ 1.0THz
start_point = floor(0.7/df);
end_point = floor(1.0/df);
s = 2;% step

%   thickness test list
%   10micron to 30 micron
h2_list = (10:5:30)*1E-6;

%   init stuffs for output
n_2plot = zeros(size(h2_list,2),size(freq,2));

max_reached_times = 0;

%   Start solving
for h_index = 1:size(h2_list,2) % for multiple thicknesses
    h_2 = h2_list(h_index);

    for ii = start_point:s:end_point % for different frequency
        %   DEBUG OUTPUT
        disp(['CURRENT FREQ: ',num2str(ii*df)]);

        r = x_fft(ii);

        %A = 1; %Just a reminder that the data is normalized

        k_0 = freq(ii) * 1E12/c;

        order = 0;
        n_2 = 0;
        n_diff = inf;

        while ((abs(real(n_diff)) > real_threshold)|| ...
                (abs(imag(n_diff))>img_threshold)) && ...
                (order < max_order)
            %   Handle previous loop's values
            order = order+1;
            n_prev = n_2;

            %DEBUG OUPTUT
            %disp(['Solving for ORDER ',num2str(order),' of height ',num2str(h_2),'...']);

            %Solving Equation
            result = nrSolving(order,k_0,r,h_2);

            n_2 = result(1);  
            n_diff = (n_2 - n_prev);

            if (abs(imag(n_diff)) < img_threshold)
                disp('img threshold reached');
            end

            if (abs(real(n_diff)) < real_threshold)
                disp('real threshold reached');
            end

            if order==max_order
                disp('max order reached');
                max_reached_times = max_reached_times + 1;
            end
        end
            
        n_2plot(h_index,ii) = n_2;
        disp(n_2);

    end
end

result = n_2plot;

%   Plot and Save
%   Color List for plot line
r_list = [1,0,0,1,1];
g_list = [0,0,1,1,0];
b_list = [0,1,0,0,1];

figure;
title(testDataFile);
%plot(freq, n_2plot,'ro');
subplot(211);
for i = 1:size(h2_list,2)
    n2_real = n_2plot(i,:);
    n2_real = real(n2_real(n2_real~=0));
    plot(freq(start_point:s:end_point),n2_real,'Color',[r_list(i),g_list(i),b_list(i)]);
    %title('real of n2');
    %axis([0 2.5 0 2]);
    xlabel('frequency');
    ylabel('real of n2');
    hold on;
end
legend('10¦Ìm','15¦Ìm','20¦Ìm','25¦Ìm','30¦Ìm');

subplot(212);
for i = 1:size(h2_list,2)
    n2_img = n_2plot(i,:);
    n2_img = imag(n2_img(n2_img~=0));    
    plot(freq(start_point:s:end_point),n2_img,'Color',[r_list(i),g_list(i),b_list(i)]);
    %title('image of n2');
    %axis([0 2.5 0 0.1]);
    xlabel('frequency');
    ylabel('image of n2');
    hold on;
end
legend('10¦Ìm','15¦Ìm','20¦Ìm','25¦Ìm','30¦Ìm');

saveas(gcf,strcat(testDataFile,'.fig'));
