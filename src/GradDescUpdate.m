function[ Va , Vc ] = GradDescUpdate( SOPin, TargetSOP, Va , Vc , rVpi , rV0 , rVab , rVcb , ERRO)
    
    step = 10*ERRO+0.1;
    dd   = 0.2;
    N=1;
    errA1=0;
    for i = 1:N
        Va2=Va+dd;
        Vc2=Vc;
        [ delta2 , alpha2 ] = tension2plate( Va2 , Vc2  , rVpi , rV0 , rVab , rVcb );
        [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );
        [ outputPol ] = rotBquat( SOPin , Q );
        errA1=errA1+norm(TargetSOP-outputPol)/dd;
    end
    errA2=0;
    for i = 1:N
        Va2=Va-dd;
        Vc2=Vc;
        [ delta2 , alpha2 ] = tension2plate( Va2 , Vc2  , rVpi , rV0 , rVab , rVcb );
        [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );
        [ outputPol ] = rotBquat( SOPin , Q );
        errA2=errA2-norm(TargetSOP-outputPol)/dd;
    end
    errC1=0;
    for i = 1:N
        Va2=Va;
        Vc2=Vc+dd;
        [ delta2 , alpha2 ] = tension2plate( Va2 , Vc2  , rVpi , rV0 , rVab , rVcb );
        [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );
        [ outputPol ] = rotBquat( SOPin , Q );
        errC1=errC1+norm(TargetSOP-outputPol)/dd;
    end
    errC2=0;
    for i = 1:N
        Va2=Va;
        Vc2=Vc-dd;
        [ delta2 , alpha2 ] = tension2plate( Va2 , Vc2  , rVpi , rV0 , rVab , rVcb );
        [ Q ] = quatLinRetarder( alpha2 , 2*pi*delta2 );
        [ outputPol ] = rotBquat( SOPin , Q );
        errC2=errC2-norm(TargetSOP-outputPol)/dd;
    end
    dVa=(errA1+errA2)/(2*N);
    dVc=(errC1+errC2)/(2*N);
    
    Va=Va-step*dVa;
    Vc=Vc-step*dVc;