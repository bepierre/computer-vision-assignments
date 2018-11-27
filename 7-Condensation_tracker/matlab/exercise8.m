%load paramters
load('data\params.mat');

myvideo = true;

if myvideo
    params.model = 1;
    params.sigma_position = 3;
    params.initial_velocity = [-10,-1];
    params.sigma_observe = 0.2;
    params.alpha = 0.1;
else
    %change some parameters if wanted
    % params.model = 1;
    % params.num_particles = 300;
    % params.hist_bin = 64;
    % params.sigma_position = 3;
    % params.initial_velocity = [-10,-1];
    % params.sigma_velocity = 1;
    % params.sigma_observe = 0.2;
    % params.alpha = 0.1;
end

%call video
condensationTracker('myOwnVideo',params);