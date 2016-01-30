function [ Qc ] = quatConj( Q )
%CONJQUAT obtain conjugate of a quaternion
%   
%   quaternion conjugate is simply its negative
%   
%   Input:
%         Q: some quaternion
%   Output:
%         Qc: Q's conjugate
%
%   Refs:
%        [1] thesis
%

Q(2:4,:)=-Q(2:4,:);
Qc=Q;


end

