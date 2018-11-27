function [updated_particles, updated_w] = resample(particles, particles_w)
    N = size(particles,1);
    i = 1;
    r = rand()*N^-1;
    c = particles_w(1);
    updated_particles = zeros(size(particles));
    updated_w = zeros(size(particles_w));
    for m = 1:N
        u = r + (m-1)*N^-1;
        while u > c
            i = i + 1;
            if i > N
                i = 1;
            end
            c = c + particles_w(i);
        end
    updated_particles(m,:) = particles(i,:);
    updated_w(m) = particles_w(i);
    end
    updated_w = updated_w/sum(updated_w);
end
