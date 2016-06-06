% Solve for the simple equation I got on May. 23rd
% using Newton Raphson Solver Logic

clc;clear all; close all;

%   Constants
c = 299792458;

%   thickness test list
%   10micron to 30 micron
h2_list = (10:5:30)*1E-6;

%   freq range we are going to use :
%   0.7THz ~ 1.0THz
start_point = 0.5;
end_point = 1.5;
s = 0.01;% step

%   init output saving
output_matrix = zeros((end_point-start_point)/s+1,3,size(h2_list,2));

j = 0;
for h_index = 1:size(h2_list,2) % for multiple thicknesses
    j = j + 1;
    h_2 = h2_list(h_index);    
    i = 0;
    for freq = start_point:s:end_point
        i = i + 1;
        k_0 = 2*pi* freq * 1E12/c; %confirmed with write-up

        %   Setting initial guess and step
        abs_old = 1.601;
        ang_old = 0;

        abs_threshold = 0.01;
        ang_threshold = 0.01;

        step1 = 0.001;
        step2 = 0.0001;

        %   Init stuffs that we need
        abs_d = inf;
        ang_d = inf;

        ii = 1;

        abs_r = abs(0);
        angle_r = angle(0);

        while ((abs(abs_d) > abs_threshold) || (abs(ang_d) > ang_threshold)) && (ii<40001)
            n2 = abs_old*exp(1i*ang_old);
            %n2_list(i) = n2;

            calculated_value = evalEquation3(n2,k_0,h_2);

            %delta = calculated_value - r;
            %d_list(i) = delta;


            abs_d = abs(calculated_value)-abs_r;
            ang_d = unwrap(angle(calculated_value)-angle_r);

            abs_old = abs_old + step1*ang_d;
            ang_old = ang_old + step2*abs_d;

            ii = ii+1;
        end

        disp(['Iterate times: ',num2str(ii)]);
        delta = calculated_value - 0;

        %if i ~= 40001
            n2 = abs_old*exp(1i*ang_old);
            %calculated_value = evalEquation3(n2,order,k_0,h_2);

            disp(['delta = ',num2str(delta),'   r = ',num2str(0)]);
        %end

        %result = [n2,delta];
        output_matrix(i,:,j) = [freq,n2,delta];
    end
end