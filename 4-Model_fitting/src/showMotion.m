function showMotion(img,corner1,corner2,F)
figure(F), imshow(img, []);    
hold on, plot(corner1(1,:), corner1(2,:), '+r');
hold on, plot(corner2(1,:), corner2(2,:), '+r');    
hold on, plot([corner1(1,:); corner2(1,:)], [corner1(2,:); corner2(2,:)], 'b');    
end

