function epipolarGeometry(img1, img2, peak_t, match_t, ransac_t)
%epipolar lines
% draw epipolar lines in img 1
    [fa, da] = vl_sift(img1, 'peakthresh', peak_t);
    [fb, db] = vl_sift(img2, 'peakthresh', peak_t);
    [matches_ab, ~] = vl_ubcmatch(da, db, match_t);
    
    xa = makehomogeneous(fa(1:2,matches_ab(1,:)));
    xb = makehomogeneous(fb(1:2,matches_ab(2,:)));
    
    [F, ~] = ransacfitfundmatrix(xa, xb, ransac_t);
    
    figure(10)
    subplot(1,2,1);
    % display image
    imshow(img1, []);
    hold on
    % plot matches
    plot(xa(1,:),xa(2,:), '*r');
    % draw epipolar lines in img 1
    for k = 1:size(xa,2)
        drawEpipolarLines(F'*xa(:,k), img1, 'b');
    end
    
    subplot(1,2,2);
    % display image
    imshow(img2, []);
    hold on
    % plot matches
    plot(xb(1,:),xb(2,:), '*r');
    % draw epipolar lines in img 2
    for k = 1:size(xb,2)
        drawEpipolarLines(F*xb(:,k), img2, 'b');
    end
end

