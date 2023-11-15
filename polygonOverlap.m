function overlaps = polygonOverlap(polyGroup1, polyGroup2)

overlaps = {};
overlapCount = 0;

% Iterate through each polygon in group 1
for i = 1:numel(polyGroup1)
    polygon1 = polyGroup1{i}; % Get polygon from group 1

    % Iterate through each polygon in group 2
    for j = 1:numel(polyGroup2)
        polygon2 = polyGroup2{j}; % Get polygon from group 2

        % Check for overlap
        overlap = twoPolyOverlap (polygon1, polygon2);
        if ~isempty(overlap)
            overlapCount = overlapCount+1;
            overlaps{overlapCount} = overlap;
        end
    end
end
end


function overlap = twoPolyOverlap (polygon1, polygon2)
% check if two polygons intersect and find the overlap
% by checking each corner of one polygon against the other polygon
% adding corner points inside the other polygon to the intersection
% finally if there is overlap add points where edges of polygons intersect each other

sz1 = size(polygon1,1);
sz2 = size(polygon2,1);
overlap = [];

for i = 1:sz1
    x = polygon1(i,1);
    y = polygon1(i,2);
    if (ptInsidePolygon(polygon2, x, y))
        overlap = [overlap; [x, y]];        
    end
end
for i = 1:sz2
    x = polygon2(i,1);
    y = polygon2(i,2);
    if (ptInsidePolygon(polygon1, x, y))
        overlap = [overlap; [x, y]];
    end
end
if ~isempty(overlap)
    for i = 1:sz1
        x = polygon1(i,1);
        y = polygon1(i,2);
        if (i < sz1)
            xn = polygon1(i+1,1);
            yn = polygon1(i+1,2);
        else
            xn = polygon1(1,1);
            yn = polygon1(1,2);
        end
        intersection = getLinePolyIntersection(x, y, xn, yn, polygon2);
        overlap = [overlap; intersection];
    end
    overlap = orderPolyCorners(overlap);
end
end


function res = ptInsidePolygon (polygon, x, y)
    % check if a point is inside a polygon using simple ray tracing
    line1 = [0, y];
    sz = size(polygon,1);
    intersections = [];
    for i = 1:sz
        x1 = polygon(i,1);
        y1 = polygon(i,2);
        if i ~= sz
             x2 =  polygon(i+1,1);
             y2 =  polygon(i+1,2);
        else
             x2 =  polygon(1,1);
             y2 =  polygon(1,2);
        end
        [slp2, intr2] = getLineEqn(x1, y1, x2, y2);
        line2 = [slp2, intr2];
        [xi, yi] = getLineIntersections(line1, x, y, 100, y, line2, x1, y1, x2, y2);
        intersections = [intersections; [xi, yi]];
    end
    res = 0;
    if mod(size(intersections,1),2) == 1
        res = 1;
    end
end


function polygon = orderPolyCorners(polygon)
% remove any duplicates and order corners counter-clockwise
tolr = 1e-6;
sz = size(polygon,1);
polygon = sortrows(polygon,1);
for i = sz-1:-1:1
   if abs(polygon(i,1)-polygon(i+1,1)) < tolr && abs(polygon(i,2)-polygon(i+1,2)) < tolr
       polygon(i+1,:) = [];
   end
end
sz = size(polygon,1);
m_ply = mean(polygon);
cntr_x = m_ply(1);
cntr_y = m_ply(2);

polygon = [polygon,zeros(sz,1)];
polygon(:,3) = atan2(polygon(:,2) - cntr_y, polygon(:,1) - cntr_x);

polygon = sortrows(polygon,3);
polygon = polygon(:,1:2);
end


function [slp, intr] = getLineEqn(x1, y1, x2, y2)
% get slope and intercept from two points
tolr = 1e-6;
if abs(x1 - x2) < tolr   %(x1 == x2)
    slp = Inf;
else
    slp = (y1-y2)/(x1-x2);
end
intr = y1 - slp*x1;
end


function intersections = getLinePolyIntersection(x1, y1, xn1, yn1, polygon)
% given a line segment and a polygon, find all points on the polygon edges that the line segment instersects
intersections = [];
sz = size(polygon,1);
for i = 1:sz
    x2 = polygon(i,1);
    y2 = polygon(i,2);
    if (i < sz)
        xn2 = polygon(i+1,1);
        yn2 = polygon(i+1,2);
    else
        xn2 = polygon(1,1);
        yn2 = polygon(1,2);
    end
    [slp1, intr1] = getLineEqn(x1, y1, xn1, yn1);
    line1 = [slp1, intr1];
    [slp2, intr2] = getLineEqn(x2, y2, xn2, yn2);
    line2 = [slp2, intr2];
    [xi, yi] = getLineIntersections(line1, x1, y1, xn1, yn1, line2, x2, y2, xn2, yn2);
    intersections = [intersections; [xi, yi]];
end
end


function [x, y] = getLineIntersections(line1, x11, y11, x12, y12, line2, x21, y21, x22, y22)
    % Calculate the intersection of two line segments  
    tolr = 1e-6;
    % Calculate the slopes and intercepts of the two lines
    m1 = line1(1);
    b1 = line1(2);
    m2 = line2(1);
    b2 = line2(2);

    % Check if the lines are parallel
    if abs(m1-m2) < tolr %m1 == m2
        x = [];
        y = [];
        return;
    end

    % Calculate the x and y coordinates of the intersection point
    x = (b2 - b1) / (m1 - m2);
    y = m1 * x + b1;

    % Check if the intersection point lies within the line segments
    if x < min(x11, x12) || x > max(x11, x12) || y < min(y11, y12) || y > max(y11, y12) || ...
            x < min(x21, x22) || x > max(x21, x22) || y < min(y21, y22) || y > max(y21, y22)
        x = [];
        y = [];
    end
end
