% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% Yu will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1s, x2s)

% %normalize points
% [x1s, T1] = normalizePoints2d(x1s);
% [x2s, T2] = normalizePoints2d(x2s);
% nE = T2'\E/T1; %normalize E to go with the normalized points


%E decomposition
[U,~,V] = svd(E);
W = [0, -1, 0;
     1,  0, 0;
     0,  0, 1];

%R matrices
R1 = U * W * V';
R1 = det(R1) * R1; % make sure  det(R1) = 1
R2 = U * W' * V';
R2 = det(R2) * R2; % make sure  det(R2) = 1

%t
t = U(:,end);
t = t/norm(t);

%Four P matrix guesses
P1 = [R1,t];
P2 = [R1,-t];
P3 = [R2,t];
P4 = [R2,-t];

Pstruct = {P1,P2,P3,P4};
Pstruct2 = {[P1;0 0 0 1],[P2;0 0 0 1],[P3;0 0 0 1],[P4;0 0 0 1]};

%fig = figure(6);
%showCameras(Pstruct2,fig);

%linear triangulation
XS = -ones(3,1);
xy_B = -ones(3,1);
i = 1;
%find the projection matrix where all the z's are positive (no point
%"behind" the camera
while ~isempty(find(XS(3,:)<0)) && ~isempty(find(xy_B(3,:)<0))
    P = Pstruct{i};
    [XS, ~] = linearTriangulation([eye(3), zeros(3,1)],x1s,P,x2s);
    xy_B = P*XS;
    i = i+1;
end
fig = figure(5);
plot3(XS(1,:),XS(2,:),XS(3,:),'x');
grid on;
%axis([-1 1 -1 1 0 1])
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
showCameras({eye(4),[P;0 0 0 1]},fig);
%showCameras(Pstruct2,fig);
end