function [axis,theta]=FindRotation(inputPol,targetPol)

s1 = [1;0;0];
s2 = [0;1;0];
s3 = [0;0;1];

ortoDirection = targetPol - inputPol;
ortoDirection = ortoDirection/norm(ortoDirection);

antigo = 1;

%% Jeito novo de determinar o eixo de rotação:
if antigo == 0
    axisVec(:,1) = cross(ortoDirection,s3);
    
    axisVec2 = cross(ortoDirection,s1);
    axisVec3 = cross(ortoDirection,s2);
    
    axisVec(:,2) = cross(axisVec2,s3);
    axisVec(:,3) = cross(axisVec3,s3);
    
    
    %axisVec(3,2:5) = 0*axisVec(3,2:5); 
    
    NormAxis(1,1) = norm(axisVec(:,1));
    NormAxis(1,2) = norm(axisVec(:,2));
    NormAxis(1,3) = norm(axisVec(:,3));

    [Norm,PosMax] = max(NormAxis);
    PosMax
    axis    = axisVec(:,PosMax);
    axis    = axis/Norm;
elseif antigo == 2
    %gustavo
    axisVec(:,1) = cross(ortoDirection,s3);
    
    axisVec(:,2) = cross(ortoDirection,inputPol);
    axisVec(:,3) = cross(ortoDirection,targetPol);

    axisVec(:,4) = cross(ortoDirection,s1);
    axisVec(:,5) = cross(ortoDirection,s2);
    
    axisVec(3,2:5) = 0*axisVec(3,2:5); 
    
    NormAxis(1,1) = norm(axisVec(:,1));
    NormAxis(1,2) = norm(axisVec(:,2));
    NormAxis(1,3) = norm(axisVec(:,3));
    NormAxis(1,4) = norm(axisVec(:,4));
    NormAxis(1,5) = norm(axisVec(:,5));

    [Norm,PosMax] = max(NormAxis);
    axis    = axisVec(:,PosMax);
    axis    = axis/Norm;
elseif antigo == 1
%% Jeito antigo de determinar o eixo de rotação:
    axis1 = cross(ortoDirection,s3);
    axis2 = cross(ortoDirection,inputPol);
    axis3 = cross(ortoDirection,targetPol);
    axis4 = cross(ortoDirection,s1);
    
    if norm(axis1)>1E-2
        axis = axis1/norm(axis1);
        %1
    elseif norm(axis2)>1E-2
        axis = axis2/norm(axis2);
        %2
    elseif norm(axis3)>1E-2
        axis = axis3/norm(axis3);
        %3
    else
        axis = axis4/norm(axis4);
        %4
    end
end

%%
c1=dot(axis,inputPol);
c2=dot(axis,targetPol);

c=(c1+c2)/2;

rotationCentre = axis*c;

%clock pointers
pointer1=inputPol - rotationCentre;
pointer2=targetPol - rotationCentre;


cosTheta = dot(pointer1,pointer2)/(norm(pointer1)*norm(pointer2));
theta=real(acos(cosTheta));

axis2=cross(pointer1,pointer2);

if dot(axis,axis2)<0
    theta=-theta;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if theta<0
    theta=-theta;
    axis=-axis;
end

end