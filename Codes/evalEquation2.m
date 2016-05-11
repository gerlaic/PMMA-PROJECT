%   evalEquation.m
%   A function that plugs in the variable values into Zac's formula
%   Use an earlier form of G in the formula. This can be find in the
%   writeup Page 5.
%   Input:
%       n2: coefficient of refraction
%       order: how many times that the waves reflected in the medium
%       h_2: thinkness of the medium
%   Output:
%       The result of the pluging everything into our formula
%       In other word, the value of the left part of the equation that we 
%       are solving. 

function result = evalEquation2(n2,order,k_0,h_2)
    %setting up parameters
    theta_1_deg = 57; % Given by Wenwei [degrees]¡¡% INPUT PARAMETER
    %h_2 = 15E-6; % Nominal thickness of the sample [
    
    %Calculated parameters
    theta_1_rad = theta_1_deg /180 * pi;
    n_1 = 3.4168; % Silicon¡¡% INPUT PARAMETER
%     e_1 = n_1^2; % Silicon
%     e_2 = n2^2; % Test Material
    p_1 = n_1*cos(theta_1_rad);

    %block1:    p_refl2^-1
    p_2 = n2*sqrt(1-n_1^2*(sin(theta_1_rad)^2)/(n2^2));
    p_refl2 = (p_2-p_1)/(p_1+p_2)*[1,0;0,1];
    block1 = p_refl2^(-1);

    %block2:    sum(G)
    %   G = P_refl2*N2*(P_refl1^-1)*N2  
    a = k_0*n2*h_2*sqrt(1-n_1^2*(sin(theta_1_rad)^2)/n2^2);
    M = [cos(a), -1i*sin(a)/p_2;-1i*p_2*sin(a), cos(a)];
    N = M^-1;
    
    p_refl1 = -1*[1,0;0,1];
    
    g_unit = p_refl2*N*(p_refl1^-1)*N;
    if order == 0
        block2 = [1,0;0,1];
    else
        block2 = [0,0;0,0];
        for iii = 1:order
            block2 = block2 + g_unit^iii;
        end
    end

    %block3:    [A1+R1;P1(A1-R1)]
    A_1 = 1;
    R_1 = A_1*(p_1-p_2)/(p_1+p_2);
    block3 = [A_1+R_1;p_1*(A_1-R_1)];

    %block4:    [R1;p1R1]
    block4 = [R_1;p_1*R_1];
    
    result_matrix = block1*block2*block3+block4;
    result = result_matrix(1);
