function particles = propagate(particles, sizeFrame, params)
    if params.model == 0
        A = eye(2);
        particles = (A*particles' + normrnd(0,params.sigma_position,size(particles))')';
    else
        dt = 1;
        A = [1,0,dt,0;
             0,1,0,dt;
             0,0,1,0;
             0,0,0,1];
        particles = (A*particles' + [normrnd(0,params.sigma_position,[(size(particles,1)),2]), normrnd(0,params.sigma_velocity,[(size(particles,1)),2])]')'; 
    end
    particles(:,1) = min(particles(:,1), sizeFrame(2));
    particles(:,2) = min(particles(:,2), sizeFrame(1));
    particles(:,1) = max(particles(:,1), 1);
    particles(:,2) = max(particles(:,2), 1);
end