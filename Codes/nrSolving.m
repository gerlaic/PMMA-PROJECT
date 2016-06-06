% nrSolving.m
% A solver that uses the Newton-Raphson method to fast solve a equation.
% Set the initial guess and the step before solving.

% The accuracy of the solver can be found in sun_up.pptx PAGE 8-10
% Update: Checked again with easy solver. Confirmed to be correct. 

%   Issue: 
%       Facing the limit of Newton Raphson method (multiple roots)
%       Trapped inside local minima
%       Getting huge jumps after large iteration times (Angle problem)
%   
%   Plan to do:
%       Rather using the method from the paper. Try using another NR
%       method. (Using REAL&IMG rather than ABS&ANG)

function result = nrSolving(k_0,r,h_2)

%disp(['Current R = ',num2str(r)]);

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

i = 1;

abs_r = abs(r);
angle_r = angle(r);


%n2_list = [];
%d_list = [];

while ((abs(abs_d) > abs_threshold) || (abs(ang_d) > ang_threshold)) && (i<40001)
    n2 = abs_old*exp(1i*ang_old);
    %n2_list(i) = n2;
    
    calculated_value = evalEquation4(n2,k_0,h_2);

    %delta = calculated_value - r;
    %d_list(i) = delta;


    abs_d = abs(calculated_value)-abs_r;
    ang_d = unwrap(angle(calculated_value)-angle_r);
    
    abs_old = abs_old + step1*ang_d;
    ang_old = ang_old + step2*abs_d;
    
    i = i+1;
end

disp(['Iterate times: ',num2str(i)]);
delta = calculated_value - r;

%if i ~= 40001
    n2 = abs_old*exp(1i*ang_old);
    %calculated_value = evalEquation3(n2,order,k_0,h_2);

    disp(['delta = ',num2str(delta),'   r = ',num2str(r)]);
%end

result = [n2,delta];

% figure
% subplot(411);
% plot(real(n2_list));
% title(['Iterations of NR solving for n2 REAL with thickness of ',num2str(h_2)]);
% legend(['Step Size: ',num2str(step1)],'location','SouthEast');
% 
% subplot(412);
% plot(imag(n2_list));
% title(['Iterations of NR solving for n2 IMAGE with thickness of ',num2str(h_2)]);
% legend(['Step Size: ',num2str(step2)],'location','SouthEast');
% 
% subplot(413);
% plot(real(d_list));
% title(['Iterations of NR solving for delta REAL with thickness of ',num2str(h_2)]);
% 
% subplot(414);
% plot(imag(d_list));
% title(['Iterations of NR solving for delta IMAGE with thickness of ',num2str(h_2)]);