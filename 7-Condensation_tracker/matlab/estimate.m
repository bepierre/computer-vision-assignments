function meanState = estimate( particles, particles_w )
    meanState = zeros(1,size(particles,2));
    for i = 1:size(particles,2)
       meanState(i) = sum(particles_w .* particles(:,i)); 
    end
end

