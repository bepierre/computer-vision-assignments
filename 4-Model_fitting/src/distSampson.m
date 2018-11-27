function d = distSampson( p1, F,  p2)
% d = distSampson( point1, F,  point2)
d = distPointLine(p2,F*p1) + distPointLine(p1,F'*p2);


