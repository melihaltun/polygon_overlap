clear; clc; close all;

n1 = 2; n2 = 3;
polyGroup1 = createRandomPolygons(n1);

polyGroup2 = createRandomPolygons(n2);


figure(1);
for i = 1:n1
    poly = polyGroup1{i};
    x = poly(:,1);
    y = poly(:,2);
    x = [x;x(1)];
    y = [y;y(1)];
    plot(x, y, 'b-', 'LineWidth', 2, 'MarkerFaceColor', 'b', 'MarkerSize', 8)
    if i == 1
        hold on;
    end
end

figure(1);
for i = 1:n2
    poly = polyGroup2{i};
    x = poly(:,1);
    y = poly(:,2);
    x = [x;x(1)];
    y = [y;y(1)];
    plot(x, y, 'r-', 'LineWidth', 2, 'MarkerFaceColor', 'r', 'MarkerSize', 8)
end

overlaps = polygonOverlap(polyGroup1, polyGroup2);




figure(1);
for i = 1:length(overlaps)
    poly = overlaps{i};
    x = poly(:,1);
    y = poly(:,2);
    x = [x;x(1)];
    y = [y;y(1)];
    plot(x, y, 'm-', 'LineWidth', 2, 'MarkerFaceColor', 'm', 'MarkerSize', 8)
end
xlabel('x'); ylabel('y');

hold off;
