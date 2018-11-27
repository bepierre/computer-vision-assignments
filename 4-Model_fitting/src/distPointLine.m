function d = distPointLine( point, line )
% d = distPointLine( point, line )
% point: inhomogeneous 2d point (2-vector)
% line: 2d homogeneous line equation (3-vector)
distanceP2L = @(x0,y0,a,b,c) abs(a*x0 + b*y0 + c)/sqrt(a^2 + b^2);
d = distanceP2L(point(1),point(2),line(1),line(2),line(3));


