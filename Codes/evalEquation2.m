function result = evalEquation2()
    %setting up parameters
    theta_1_deg = 57; % Given by Wenwei [degrees]
    %h_2 = 15E-6; % Nominal thickness of the sample [
    
    %Calculated parameters
    theta_1_rad = theta_1_deg /180 * pi;
    n_1 = 3.4168; % Silicon
    e_1 = n_1^2; % Silicon
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
