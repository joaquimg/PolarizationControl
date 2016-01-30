clc;
clear;
close all;

record = 0

N = 1000;
movingFrameWidth = 200;

RealParameters = [-10.5; 9.5; -0.5; 0.5];
EstimatedParameters = RealParameters + 1E-1*(randn(4,1)-0.5);

SOPin     = [0;0;1];
TargetSOP = [0;1;0];
SOPin     = SOPin/norm(SOPin);
TargetSOP = TargetSOP/norm(TargetSOP);
SOPout    = SOPin;
Va = 0;
Vc = 0;

TargetSOPList = [1 0 0; 0 1 0; -1 0 0; 0 -1 0]';

HistSOPin     = zeros(3,N);
HistSOPout    = zeros(3,N);
HistSOPtarget = zeros(3,N);

HistVa   = zeros(1,N);
HistVc   = zeros(1,N);
HistERRO = zeros(1,N);

ERRO            = 0;
Switch          = 20;
i_actualSwitch  = -Switch+1;
Drift           = 5;
i_actualDrift   = -Drift+1;
DriftIteration  = 0;
axis            = [1;0;0];
DriftSpeed      = 2*pi/200;

clf('reset') 
figure('units','normalized','outerposition',[0 0 1 1])
%plot sphere
subplot(5,2,[1 3 5 7 9]);
[x,y,z] = sphere;
surf(x,y,z,'EdgeColor','none')
colormap hsv
alpha(0.3)
ylabel('y')
xlabel('x')
zlabel('z')
plot3(x,y,z,'k')
%inout and outputs
hold on;
%circles
[x,y,z]=circle(1);
plot3(x,y,z)
plot3(y,z,x)
plot3(z,x,y)

if record == 1
    writerObj = VideoWriter('out20','MPEG-4');% Name it.
writerObj.FrameRate = 30; % How many frames per second.
writerObj.Quality = 10;
open(writerObj);
end
t = 1:length(HistSOPtarget(1,:));
t = t/1E6;

for i = 1:N
    
    NumSwitch2Drift = i - i_actualSwitch;
    if NumSwitch2Drift == Switch
        [TargetSOP] = SOPTargetSwitch( TargetSOPList );
        i_actualSwitch = i;
    end
    
    NumIter2Drift = i - i_actualDrift;
    if NumIter2Drift == Drift
        [SOPin,DriftIteration,axis] = SOPinRandomDrift( SOPin, DriftIteration, axis, DriftSpeed, RealParameters );
        i_actualDrift = i;
    end
    
    [SOPout,Va,Vc,ERRO] = ControlIteration(SOPin,TargetSOP,Va,Vc,EstimatedParameters,RealParameters);
    
    %inout and outputs
    subplot(5,2,[1 3 5 7 9]);
    scatter3(SOPin(1),SOPin(2),SOPin(3),20,'filled','g')
    scatter3(TargetSOP(1),TargetSOP(2),TargetSOP(3),100,'filled','k')
    scatter3(SOPout(1),SOPout(2),SOPout(3),20,'filled','r')
    if record == 1
    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);
    end
    
    HistSOPin(:,i) = SOPin;
    HistSOPtarget(:,i) = TargetSOP;
    HistSOPout(:,i) = SOPout;
    HistVa(1,i) = Va;
    HistVc(1,i) = Vc;
    HistERRO(1,i) = ERRO;
    
    subplot(5,2,2);
    plot(t,HistSOPtarget(1,:),t,HistSOPout(1,:),'b');
    ylim([-1 1]);
    
    if i <= movingFrameWidth
        xlim([0 i/(1E6)]);
    else
        xlim([(i-movingFrameWidth)/(1E6) i/(1E6)]);
    end
    
    subplot(5,2,4);
    plot(t,HistSOPtarget(2,:),t,HistSOPout(2,:),'b');
    ylim([-1 1]);
    if i <= movingFrameWidth
        xlim([0 i/(1E6)]);
    else
        xlim([(i-movingFrameWidth)/(1E6) i/(1E6)]);
    end
    
    subplot(5,2,6);
    plot(t,HistSOPtarget(3,:),t,HistSOPout(3,:),'b');
    ylim([-1 1]);
    if i <= movingFrameWidth
        xlim([0 i/(1E6)]);
    else
        xlim([(i-movingFrameWidth)/(1E6) i/(1E6)]);
    end
    
    subplot(5,2,8);
    plot(t,HistERRO,t,(0*t+1)*1E-1,'b');
    ylim([0 2]);
    if i <= movingFrameWidth
        xlim([0 i/(1E6)]);
    else
        xlim([(i-movingFrameWidth)/(1E6) i/(1E6)]);
    end
    
    subplot(5,2,10);
    plot(t,HistERRO,'b');
    ylim([0 0.1]);
    if i <= movingFrameWidth
        xlim([0 i/(1E6)]);
    else
        xlim([(i-movingFrameWidth)/(1E6) i/(1E6)]);
    end
    
    disp(i);
end

hold off;
if record ==1
close(writerObj); % Saves the movie.
end
Origin(:,1) = t';
Origin(:,2) = HistSOPtarget(1,:)';
Origin(:,3) = HistSOPout(1,:)';
Origin(:,4) = HistSOPtarget(2,:)';
Origin(:,5) = HistSOPout(2,:)';
Origin(:,6) = HistSOPtarget(3,:)';
Origin(:,7) = HistSOPout(3,:)';
Origin(:,8) = HistERRO';