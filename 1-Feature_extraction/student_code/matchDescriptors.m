% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - 2 x w matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, thresh)
    [~,n] = size(descr1);
    [~,m] = size(descr2);
    matches = [];
    for i = 1:n
        for j = 1:m
            if(sum((descr1(:,i)-descr2(:,j)).^2) < thresh)
                matches = [matches,[i j]']; 
                % matches = cat(2, matches, [i j]');
            end
        end
    end
end