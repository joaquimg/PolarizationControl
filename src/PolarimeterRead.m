function[ActualSOP] = PolarimeterRead(SOPin,Va,Vc,RealParameters)

    [ delta , alpha ] = tension2plate( Va, Vc, RealParameters(1),...
                                       RealParameters(2), RealParameters(3),... 
                                       RealParameters(4) );

    [ Q ] = quatLinRetarder( alpha , 2*pi*delta );

    [ ActualSOP ] = rotBquat( SOPin , Q );
