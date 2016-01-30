function [ delta , alpha ] = tension2plate( Va , Vc  , Vpi , V0 , Vab , Vcb )
%TENSION2PLATE Summary of this function goes here
%   Detailed explanation goes here

A=2*V0;
B=-Vpi;
C=Va-Vab;
D=Vc-Vcb;

delta=sqrt( ( (C+D)/(2*A) )^2 + ( (C-D)/(2*B) )^2 );

if delta==0
    value1 = 0;
    value2 = 0;
else
    value1 = (C+D)/(2*A*delta);
    value2 = (C-D)/(2*B*delta);
end

alpha=atan2( value1,value2 )/2;

end

