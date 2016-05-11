function [dmin,index]=findMin(delta)

c1 = 1;
c2 = 1;

abs_d = abs(delta);

ang_d = angle(delta);

ER = c1*abs(abs_d) + c2*abs(ang_d);

[dmin,index] = min(ER);

disp(num2str(min(ER)));