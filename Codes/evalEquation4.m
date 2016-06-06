% Eval the equation under TM

function result = evalEquation4(n2,k_0,h_2)
    %setting up parameters
    theta_1_deg = 57; % Given by Wenwei [degrees]¡¡% INPUT PARAMETER
    %h_2 = 15E-6; % Nominal thizckness of the sample [
    
    %Calculated parameters
    theta_1_rad = theta_1_deg /180 * pi;
    n_1 = 3.4168; % Silicon¡¡% INPUT PARAMETER
%     e_1 = n_1^2; % Silicon
%     e_2 = n2^2; % Test Material
    q_1 = 1/n_1*cos(theta_1_rad);
    cos_theta_2 = sqrt(1-n_1^2*(sin(theta_1_rad)^2)/(n2^2));
    
    %block1: N11 and N12
    q_2 = 1/n2*cos_theta_2;
    a = k_0*n2*h_2*cos_theta_2;
    %M = [cos(a), -1i*sin(a)/p_2;-1i*p_2*sin(a), cos(a)]; % from Zac's write up and I believe this is from the book.
    N = [cos(a), 1i*sin(a)/q_2; 1i*q_2*sin(a), cos(a)] ; % calculated by hand; Checked to be correct.
    
    block1 = N(1,:);
    
    %block2:    [A1+R1;Q1(A1-R1)]
    A_1 = 1;
    R_1 = A_1*(q_1-q_2)/(q_1+q_2);
    block2 = [A_1+R_1;q_1*(A_1-R_1)];
    
    result = block1*block2;