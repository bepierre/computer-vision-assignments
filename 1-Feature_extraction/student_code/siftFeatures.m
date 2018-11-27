function [] = siftFeatures(I, thresh, fig)
    % Basic matching
    % run('C:\vlfeat\toolbox\vl_setup');
    figure(fig);
    imshow(I); 

    % convert to b&w
    I = single(rgb2gray(I));
    [f, d] = vl_sift(I, 'peakthresh', thresh);

    % SIFT frames
    h1 = vl_plotframe(f) ;
    set(h1,'color','b','linewidth',3) ;
    
    % descriptors
    h2 = vl_plotsiftdescriptor(d,f) ;
    set(h2,'color','g') ;
end

