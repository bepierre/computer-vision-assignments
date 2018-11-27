function [] = siftMatching(Ia, Ib, thresh, fig)
    % Basic matching
    % run('C:\vlfeat\toolbox\vl_setup');
    figure(fig);
    imshow([Ia, Ib], []); 

    % convert to b&w
    Ia = single(rgb2gray(Ia));
    Ib = single(rgb2gray(Ib));
    
    % compute the keyframes
    [fa, da] = vl_sift(Ia, 'peakthresh', thresh) ;
    [fb, db] = vl_sift(Ib, 'peakthresh', thresh) ;
    
    % get the matches
    [matches, ~] = vl_ubcmatch(da, db) ;
    
    % connect the matches with a line
    xa = fa(1,matches(1,:)) ;
    xb = fb(1,matches(2,:)) + size(Ia,2) ;
    ya = fa(2,matches(1,:)) ;
    yb = fb(2,matches(2,:)) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'b') ;

    %plot matches
    vl_plotframe(fa(:,matches(1,:))) ;
    fb(1,:) = fb(1,:) + size(Ia,2) ;
    vl_plotframe(fb(:,matches(2,:))) ;
    axis image off ;
    
end

