function[SOPin,DriftIteration,axis] = SOPinRandomDrift( SOPin, DriftIteration, axis, DriftSpeed, RealParameters )

    if DriftIteration == 0
        [axis,DriftIteration] = RaffleDrift(SOPin,DriftSpeed);
    end
    
    [Alpha, delta] = genrot2plate(axis, DriftSpeed);
    
    [ Va , Vc ] = plate2tension( delta , Alpha/2 , RealParameters(1),...
                                     RealParameters(2), RealParameters(3),...
                                     RealParameters(4) );
                                 
    %inside EOSpace
    [ delta2 , alpha2 ] = tension2plate( Va , Vc , RealParameters(1),...
                                         RealParameters(2), RealParameters(3),...
                                         RealParameters(4) );
    
    [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );

    [ SOPin ] = rotBquat( SOPin , Q );
    
    DriftIteration = DriftIteration - 1;