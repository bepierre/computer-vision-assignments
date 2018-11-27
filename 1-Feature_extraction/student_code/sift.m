% Basic matching
figure(2);
Ia = im2double(imread('images/I1.jpg'));
Ib = im2double(imread('images/I2.jpg'));
imshow([Ia, Ib], []); 

Ia = single(rgb2gray(Ia));
Ib = single(rgb2gray(Ib));
[fa, da] = vl_sift(Ia, 'peakthresh', 0.04) ;
[fb, db] = vl_sift(Ib, 'peakthresh', 0.04) ;
[matches, scores] = vl_ubcmatch(da, db) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;
