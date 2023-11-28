
function polygons = createRandomPolygons(numPolygons)

minDist = 2;
centerSigma = 3;
max_iter = 200;
polygons = {};
centers = [];
for k = 1:numPolygons

    numVertices = randi([3, 8]);
    poly = [];
    i = 0;
    while i < max_iter
        center = [centerSigma*randn, centerSigma*randn];
        if isempty(centers) || all(pdist2(center,centers) >= minDist)
            break;
        end
        i = i+1;
    end
    centers = [centers; center];

    r = 2.5;
    cornerSigma = 0.2;
    theta = linspace(0, 2*pi, numVertices+1);
    theta = theta(1:end-1);

    for i = 1:numVertices 
        x = center(1) + r * cos(theta(i)) + randn*cornerSigma;
        y = center(2) + r * sin(theta(i)) + randn*cornerSigma;
        poly = [poly;[x,y]];
    end

    polygons{k} = poly;
end
    