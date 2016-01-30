function[TargetSOP] = SOPTargetSwitch( TargetSOPList )

    sel = randi(4);
    
    TargetSOP = TargetSOPList(:,sel);