function[axis,NumIterations] = RaffleDrift(SOPin,DriftSpeed)
    
    SOPDriftEnd = randn(3,1);
    SOPDriftEnd = SOPDriftEnd/norm(SOPDriftEnd);
    
    [axis, theta] = FindRotation(SOPin, SOPDriftEnd);
    
    NumIterations = floor(theta/DriftSpeed);