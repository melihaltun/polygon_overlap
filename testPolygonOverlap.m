clear; clc; close all;

n1 = 2; n2 = 3;
polyGroup1 = createRandomPolygons(n1);
polyGroup2 = createRandomPolygons(n2);

h = [];
h = draw_polygons(polyGroup1, 1, 'b-', 2, 'b', 8, 1, h);
h = draw_polygons(polyGroup2, 1, 'r-', 2, 'r', 8, 1, h);

overlaps = polygonOverlap(polyGroup1, polyGroup2);

h = draw_polygons(overlaps, 1, 'm-', 2, 'm', 8, 0, h);
if ~isempty(overlaps)
    legend(h([1, length(polyGroup1)+1, length(polyGroup1)+length(polyGroup2)+1]),["polygon group 1", "polygon group 2", "overlaps"]);
else
    legend(h([1, length(polyGroup1)+1]),["polygon group 1", "polygon group 2"]);
end


function hh = draw_polygons(polygons, figureNum, colorAndStyle, lineWidth, markerColor, markerSize, holdOn, hh)
%function to draw multiple polygons
figure(figureNum);
lineHandles = 0;
for i = 1:length(polygons)
    poly = polygons{i};
    x = poly(:,1);
    y = poly(:,2);
    x = [x;x(1)];
    y = [y;y(1)];
    lineHandles = lineHandles+1;
    h(lineHandles) = plot(x, y, colorAndStyle, 'LineWidth', lineWidth, 'MarkerFaceColor', markerColor, 'MarkerSize', markerSize);
    if holdOn && i == 1
        hold on;
    end
    
end
if (length(polygons))
    hh = [hh, h];
end
xlabel('x'); ylabel('y');
if ~holdOn
    hold off;
end
end


