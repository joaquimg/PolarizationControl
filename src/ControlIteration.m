function [SOPout,Va,Vc,ERRO] = ControlIteration(SOPin,TargetSOP,Va,Vc,EstimatedParameters,RealParameters)

    [ActualSOP] = PolarimeterRead(SOPin,Va,Vc,RealParameters);
    
    [SOPout,Va,Vc,ERRO] = ControlAlg(SOPin,ActualSOP,TargetSOP,Va,Vc,EstimatedParameters,RealParameters);