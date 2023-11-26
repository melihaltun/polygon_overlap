
function polygons = createRandomPolygons(numPolygons)

%minDist = 4;  % TBD
centerSigma = 3;
polygons = {};
centers = [];
for k = 1:numPolygons

    numVertices = randi([3, 8]);
    poly = [];

    center = [centerSigma*randn, centerSigma*randn];

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
    