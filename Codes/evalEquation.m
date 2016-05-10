%   evalEquation.m
%   A function that plugs in the variable values into Zac's formula
%   Input:
%       n2: coefficient of refraction
%       order: how many times that the waves reflected in the medium
%       h_2: thinkness of the medium
%   Output:
%       The result of the pluging everything into our formula
%       In other word, the value of the left part of the equation that we 
%       are solving. 

%   The equations can be visualized in sum_up.pptx PAGE 3-7


function result=evalEquation(n2,order,k_0,h_2)  
    %setting up parameters
    theta_1_deg = 57; % Given by Wenwei [degrees]
    e_1 = 3.42; % Si permitivity check it on riken.jp/Thzdatabase [unitless]
    %h_2 = 15E-6; % Nominal thickness of the sample [
    
    %Calculated parameters
    theta_1_rad = theta_1_deg /180 * pi;
    n_1 = sqrt(e_1);
    p_1 = n_1*cos(theta_1_rad);

    %block1:    p_refl2^-1
    p_2 = n2*sqrt(1-n_1^2*(sin(theta_1_rad)^2)/(n2^2));
    p_refl2 = (p_2-p_1)/(p_1+p_2)*[1,0;0,1];
    block1 = p_refl2^(-1);

    %block2:    sum(G)
    r_refl2 = (p_2-p_1)/(p_1+p_2);
    cos_theta22 = (1-n_1^2*(sin(theta_1_rad)^2)/(n2^2));
    g_unit = -r_refl2*[1,1i*k_0*h_2*n2^2;1i*k_0*h_2*cos_theta22,1]^2;
    block2 = [0,0;0,0];
    for iii = 1:order
        block2 = block2 + g_unit^iii;
    end

    %block3:    [A1+R1;P1(A1-R1)]
    A_1 = 1;
    R_1 = A_1*(p_1-p_2)/(p_1+p_2);
    block3 = [A_1+R_1;p_1*(A_1-R_1)];

    %block4:    [R1;p1R1]
    block4 = [R_1;p_1*R_1];
    
    result_matrix = block1*block2*block3+block4;
    result = result_matrix(1);
