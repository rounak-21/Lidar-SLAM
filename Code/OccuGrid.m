% Create an occupancy grid map from points
function gridmap = OccuGrid(pts, pixelSize)

% Grid size
minXY = min(pts) - 3 * pixelSize;%min(pts)
maxXY = max(pts) + 3 * pixelSize;% +3*pixelSize
Sgrid = round((maxXY - minXY) / pixelSize) + 1;%Sgrid(1)
N = size(pts, 1);

hits = round( (pts-repmat(minXY, N, 1)) / pixelSize ) + 1;
idx = (hits(:,1)-1)*Sgrid(2) + hits(:,2);
grid  = false(Sgrid(2), Sgrid(1));

grid(idx) = true;

gridmap.occGrid = grid;
gridmap.metricMap = min(bwdist(grid),10);

gridmap.pixelSize = pixelSize;
gridmap.topLeftCorner = minXY;
% top left corner