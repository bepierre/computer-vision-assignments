function hist = color_histogram( xMin, yMin, xMax, yMax, frame, hist_bin )

    xMin = round(max(1,xMin));
    yMin = round(max(1,yMin));
    xMax = round(min(xMax,size(frame,2)));
    yMax = round(min(yMax,size(frame,1)));

    %Split into RGB Channels
    R = frame(yMin:yMax,xMin:xMax,1);
    G = frame(yMin:yMax,xMin:xMax,2);
    B = frame(yMin:yMax,xMin:xMax,3);

    %Get histValues for each channel
    [hR, x] = imhist(R, hist_bin);
    [hG, ~] = imhist(G, hist_bin);
    [hB, ~] = imhist(B, hist_bin);
%     figure(2)
%     plot(x, hR, 'r', x, hG, 'g', x, hB, 'b')

    %normalize
    hist = [hR; hG; hB];
    hist = hist/sum(hist);
%     figure(3)
%     plot(hist)
end

