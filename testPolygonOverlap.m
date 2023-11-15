clear; clc; close all;

n1 = 2; n2 = 3;
polyGroup1 = createRandomPolygons(n1);
polyGroup2 = createRandomPolygons(n2);

draw_polygons(polyGroup1, 1, 'b-', 2, 'b', 8, 1);
draw_polygons(polyGroup2, 1, 'r-', 2, 'r', 8, 1);

overlaps = polygonOverlap(polyGroup1, polyGroup2);

draw_polygons(overlaps, 1, 'm-', 2, 'm', 8, 0);


function draw_polygons(polygons, figureNum, colorAndStyle, lineWidth, markerColor, markerSize, holdOn)
%function to draw multiple polygons
figure(figureNum);
for i = 1:length(polygons)
    poly = polygons{i};
    x = poly(:,1);
    y = poly(:,2);
    x = [x;x(1)];
    y = [y;y(1)];
    plot(x, y, colorAndStyle, 'LineWidth', lineWidth, 'MarkerFaceColor', markerColor, 'MarkerSize', markerSize)
    if holdOn && i == 1
        hold on;
    end
end
xlabel('x'); ylabel('y');
if ~holdOn
    hold off;
end
end