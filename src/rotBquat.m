function [ w ] = rotBquat( v , Q )
%ROTBQUAT Summary of this function goes here
%   Detailed explanation goes here

V=[0;v];

W=quatProd(Q,V);

W=quatProd(W,quatConj(Q));

w=W(2:4,1);

if abs( W(1,1) ) > 1e-1
    print(' ')
    aaa= 'erro'
    bbb=W(1,1)
end

end

