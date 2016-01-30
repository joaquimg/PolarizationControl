function [ Q ] = quatLinRetarder( axisAngle , retardation )
%QUATLINRETARDER Summary of this function goes here
%   Detailed explanation goes here

Q=zeros(4,1);

Q(1)=cos(retardation/2);

Q(2)=sin(retardation/2)*cos(2*axisAngle);

Q(3)=sin(retardation/2)*sin(2*axisAngle);

end

