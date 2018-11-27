function [map, peak] = meanshiftSeg(img)
    %put img in type double
    img = double(img);
    
    %get all points X in a good format
    [m, n, ~] = size(img);
    L = m*n;
    img_L = img(:,:,1);
    img_a = img(:,:,2);
    img_b = img(:,:,3);
    X = [img_L(:)'; img_a(:)'; img_b(:)'; ones(1,L)];
    
    %normalize points
    [Xn, T] = normalise3dpts(X);
    
    %initialize stuff
    r = 3;
    map = zeros(m,n);
    
    %create first peak
    peaksn = [find_peak(Xn,Xn(:,1),r)];
    
    %iterate
    for p = 2:L
        peakn = find_peak(Xn,Xn(:,p),r);
        dists = sqrt(sum(((peaksn - repmat(peakn, [1,size(peaksn,2)])).^2)));
        similarPeakn = find(dists<r/2,1);
        if isempty(similarPeakn)
            peaksn = [peaksn, peakn];
            map(p) = size(peaksn,2);
        else
            map(p) = similarPeakn;
        end
    end
    peak = T\peaksn;
    peak = peak(1:3,:)';
end