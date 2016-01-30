function [ PQ ] = quatProd( P, Q )
%QUATPROD Summary of this function goes here
%   Detailed explanation goes here
PQ=zeros(4,1);

p=P(2:4,:);
q=Q(2:4,:);

p0=P(1,:);
q0=Q(1,:);

PQ(1)=p0*q0-dot(p,q);

PQ(2:4,1)=p0*q + q0*p + cross(p,q);

end

