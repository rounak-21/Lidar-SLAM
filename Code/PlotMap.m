function PlotMap(cfig, map, path, scan, scanIdx)
world   = map.points;
scan = Transform(scan, path(:,end));

worldColor = [0 0 0];
scanColor = [148/255 0 211/255];
pathColor = [0 0 1];
lidarColor=[205/255 38/255 38/255];
% Plot
cfig(1); clf; 
set(0,'defaultfigurecolor','w')
set(gca,'box','on')
set(gca, 'color', [1,1,1]);
hold on;  axis equal;
plot(world(:,1), world(:,2), '+', 'MarkerSize', 1, 'color', worldColor);
plot(scan(:,1),  scan(:,2),  '.', 'MarkerSize', 2, 'color', scanColor);
plot(path(1,:),  path(2,:),  '-.', 'LineWidth', 1, 'color', pathColor);
for i = 1:20:length(scan)
    line([path(1,end), scan(i,1)], [path(2,end), scan(i,2)], 'color', lidarColor);
end
title(['Scan: ', num2str(scanIdx)]);
drawnow