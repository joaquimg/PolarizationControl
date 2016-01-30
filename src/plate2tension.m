function [ Va , Vc ] = plate2tension( delta , alpha , Vpi , V0 , Vab , Vcb )
%PLATE2TENSION convert plate parameters into necessary input voltages
%
%   implementes the eospace input equation
%   convert plate parameters into necessary input voltages to achieve the
%   linear rotation plate uniquellly determined by delta and alpha
%   
%   Input:
%         delta: retardation (in wavelengths)
%         alpha: is the orientaion angle (0 to 2pi)
%         Vpi:   voltage required to rotate 180 degree phase shift between
%         modes
%         V0:    voltage required to rotate all power from TE to TM in one
%         stage
%         Vab:   bias voltage to achieve zero birefringence
%         Vcb:   bias voltage to achieve zero birefringence
%   Output:
%         Va:    voltage to be applied in terminal a
%         Vc:    voltage to be applied in terminal c
%
%   Refs:
%        [1] datasheet of eospace
%

Va = 2*V0*delta*sin(2*alpha) - Vpi*delta*cos(2*alpha) + Vab;
Vc = 2*V0*delta*sin(2*alpha) + Vpi*delta*cos(2*alpha) + Vcb;

end

