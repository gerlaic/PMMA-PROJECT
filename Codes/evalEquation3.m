% Eval the equation under TE
% Equation Checked with Zac

function result = evalEquation3(n2,k_0,h_2)
    %setting up parameters
    theta_1_deg = 57; % Given by Wenwei [degrees]¡¡% INPUT PARAMETER
    %h_2 = 15E-6; % Nominal thizckness of the sample [
    
    %Calculated parameters
    theta_1_rad = theta_1_deg /180 * pi;
    n_1 = 3.4168; % Silicon¡¡% INPUT PARAMETER
%     e_1 = n_1^2; % Silicon
%     e_2 = n2^2; % Test Material
    p_1 = n_1*cos(theta_1_rad);
    
    %block1: N11 and N12
    p_2 = n2*sqrt(1-n_1^2*(sin(theta_1_rad)^2)/(n2^2));
    a = k_0*n2*h_2*sqrt(1-n_1^2*(sin(theta_1_rad)^2)/n2^2);
    %M = [cos(a), -1i*sin(a)/p_2;-1i*p_2*sin(a), cos(a)]; % from Zac's write up and I believe this is from the book.
    N = [cos(a), 1i*sin(a)/p_2; 1i*p_2*sin(a), cos(a)] ; % calculated by hand; Checked to be correct.
    
    block1 = N(1,:);
    
    %block2:    [A1+R1;P1(A1-R1)]
    A_1 = 1;
    R_1 = A_1*(p_1-p_2)/(p_1+p_2);
    block2 = [A_1+R_1;p_1*(A_1-R_1)];
    
    result = block1*block2;