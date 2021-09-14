clear; close all; clc;
cfig = figure(1);
%cfig = figure('Position', [10,10,1280,1080]);
lidar = SetLidarParameters();

borderSize      = 1;            
pixelSize       = 0.2;          
miniUpdated     = false;        
miniUpdateDT    = 0.1;          
miniUpdateDR    = deg2rad(5);    


fastResolution  = [0.05; 0.05; deg2rad(0.5)]; % [m; m; rad]
bruteResolution = [0.01; 0.01; deg2rad(0.1)]; % not used


lidar_data = load('horizental_lidar.mat');
%lidar_data = load('new_laser_data.mat');
N = size(lidar_data.timestamps, 1);


map.points = [];
map.connections = [];
map.keyscans = [];
pose = [0; 0; 0];%(x=0,y=0,theta=0)
path = pose;



saveFrame=0;
if saveFrame==1
    
    writerObj=VideoWriter('SLAMprocess.avi');    
    open(writerObj);                    
end

% Here we go!!!!!!!!!!!!!!!!!!!!
for scanIdx = 1 : 1 : N
    disp(['scan ', num2str(scanIdx)]);

    %[x1,y1; x2,y2; ...]
    %time = lidar_data.timestamps(scanIdx) * 1e-9;
    scan = ReadAScan(lidar_data, scanIdx, lidar, 24);
    
    
    if scanIdx == 1
        map = Initialize(map, pose, scan);
        miniUpdated = true;
        continue;
    end

    
    if miniUpdated
        localMap = ExtractLocalMap(map.points, pose, scan, borderSize);
        gridMap1 = OccuGrid(localMap, pixelSize);
        gridMap2 = OccuGrid(localMap, pixelSize/2);
    end

    
    if scanIdx > 2
        pose_guess = pose + DiffPose(path(:,end-1), pose);
    else
        pose_guess = pose;
    end

    
    if miniUpdated
        [pose, ~] = FastMatch(gridMap1, scan, pose_guess, fastResolution);
    else
        [pose, ~] = FastMatch(gridMap2, scan, pose_guess, fastResolution);
    end

    
    % gridMap = OccuGrid(localMap, pixelSize/2);
    [pose, hits] = FastMatch(gridMap2, scan, pose, fastResolution/2);

    
    dp = abs(DiffPose(map.keyscans(end).pose, pose));
    if dp(1)>miniUpdateDT || dp(2)>miniUpdateDT || dp(3)>miniUpdateDR
        miniUpdated = true;
        [map, pose] = AddAKeyScan(map, gridMap2, scan, pose, hits,...
                        pixelSize, bruteResolution, 0.1, deg2rad(3));
    else
        miniUpdated = false;
    end

    path = [path, pose];      

    % ===== Loop Closing =========================================
    % if miniUpdated
    %     if TryLoopOrNot(map)
    %         map.keyscans(end).loopTried = true;
    %         map = DetectLoopClosure(map, scan, hits, 4, pi/6, pixelSize);
    %     end
    % end
    %----------------------------------------------------------------------

    
    if mod(scanIdx, 30) == 0 
        PlotMap(cfig, map, path, scan, scanIdx);
        
        if saveFrame==1
            frame = getframe(cfig);
            writeVideo(writerObj, frame);
        end
    end
end
if saveFrame==1
    close(writerObj);  
end

figure(2);
subplot(1,2,1);
world = map.points;
plot(world(:,1), world(:,2), '+', 'MarkerSize', 1, 'color', [0,0,0]);
subplot(1,2,2);
plot(path(1,:),  path(2,:),  '-.', 'LineWidth', 1);