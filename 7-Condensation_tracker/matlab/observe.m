function particles_w = observe(particles, frame, H, W, hist_bin, hist_target, sigma)
    particles_w = zeros(size(particles,1),1);
    for p = 1:size(particles,1)
        hist = color_histogram(particles(p,1)-W/2, particles(p,2)-H/2, ...
                        particles(p,1)+W/2, particles(p,2)+H/2, ...
                        frame, hist_bin);
        dist = chi2_cost(hist, hist_target);
        particles_w(p) = (1/(sqrt(2*pi)*sigma))*exp(-(dist^2)/(2*sigma^2));
    end
    particles_w = particles_w/sum(particles_w);
end