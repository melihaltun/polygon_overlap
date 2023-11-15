
function polygons = createRandomPolygons(numPolygons)

minDist = 4;
polygons = {};
centers = [];
for k = 1:numPolygons

    numVertices = randi([3, 8]);
    poly = [];

    center = [3*randn, 3*randn];

    while (size(centers,1) > 1)
        for i = 1:size(centers,1) 
            if sqrt((center(1)-centers(i,1))^2+(center(2)-centers(i,2))^2) < minDist 
                center = [4*randn, 4*randn];
                continue;
            end
        end
        break;
    end

    r = 2.5;
    theta = linspace(0, 2*pi, numVertices+1);
    theta = theta(1:end-1);

    for i = 1:numVertices 
        x = center(1) + r * cos(theta(i)) + randn/5;
        y = center(2) + r * sin(theta(i)) + randn/5;
        poly = [poly;[x,y]];
    end

    polygons{k} = poly;
end
    