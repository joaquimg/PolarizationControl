function[ EstimatedSOPin ] = StateEstimator(ActualSOP, Va, Vc, eVpi, eV0, eVab, eVcb )

    [ delta , alpha ] = tension2plate( Va , Vc  , eVpi , eV0 , eVab , eVcb );
     
    [ Q ] = quatLinRetarder(  alpha , 2*pi*(1-delta) );

    [ EstimatedSOPin ] = rotBquat( ActualSOP , Q );

