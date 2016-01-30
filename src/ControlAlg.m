function [SOPout,Va,Vc,ERRO] = ControlAlg(SOPin,ActualSOP,TargetSOP,Va,Vc,EstimatedParameters,RealParameters)
    
    epsilon = 1e-1;
    
    ERRO = norm(TargetSOP-ActualSOP);

    if ERRO > epsilon

        [ EstimatedSOPin ] = StateEstimator(ActualSOP, Va, Vc, EstimatedParameters(1),...
                                            EstimatedParameters(2), EstimatedParameters(3),...
                                            EstimatedParameters(4) );

        [axis, theta] = FindRotation(EstimatedSOPin, TargetSOP);
        
        [Alpha, delta] = genrot2plate(axis, theta);

        [ Va , Vc ] = plate2tension( delta , Alpha/2 , EstimatedParameters(1),...
                                     EstimatedParameters(2), EstimatedParameters(3),...
                                     EstimatedParameters(4) );
                             
    else
        
        [ Va , Vc ] = GradDescUpdate( SOPin, TargetSOP, Va , Vc , RealParameters(1),...
                                      RealParameters(2), RealParameters(3),...
                                      RealParameters(4), ERRO );
    
    end

    %inside EOSpace
    [ delta2 , alpha2 ] = tension2plate( Va , Vc , RealParameters(1),...
                                         RealParameters(2), RealParameters(3),...
                                         RealParameters(4) );
    
    [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );

    [ SOPout ] = rotBquat( SOPin , Q );