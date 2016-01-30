function [alpha,delta]=genrot2plate(axis,theta)

delta = theta/(2*pi);
if delta<0
    delta=1+delta;
end


alpha = atan2(axis(2),axis(1));

%if delta>0.5
%    delta=1-delta;
%    alpha=-alpha;

end








