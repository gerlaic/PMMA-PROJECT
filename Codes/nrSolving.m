% nrSolving.m
% A solver that uses the Newton-Raphson method to fast solve a equation.
% Set the initial guess and the step before solving.

% The accuracy of the solver can be found in sun_up.pptx PAGE 8-10

function result = nrSolving(order,k_0,r,h_2)

%disp(['Current R = ',num2str(r)]);

%   Setting initial guess and step
abs_old = 1.8;
ang_old = 0;

abs_threshold = 0.001;
ang_threshold = 0.0001;

step1 = 0.001;
step2 = 0.0001;

%   Init stuffs that we need
abs_d = inf;
ang_d = inf;

i = 1;

abs_r = abs(r);
angle_r = angle(r);

while ((abs_d > abs_threshold) || (ang_d > ang_threshold)) && (i<20000)
    n2 = abs_old*exp(1i*ang_old);
    
    calculated_value = evalEquation2(n2,order,k_0,h_2);

    delta = calculated_value - r;

    abs_d = abs(calculated_value)-abs_r;
    ang_d = unwrap(angle(calculated_value)-angle_r);

    abs_old = abs_old + step1*ang_d;
    ang_old = ang_old + step2*abs_d;
    
    i = i+1;
end

n2 = abs_old*exp(1i*ang_old);
calculated_value = evalEquation(n2,order,k_0,h_2);
delta = calculated_value - r;

result = [n2,delta];