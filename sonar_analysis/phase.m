%% Load files
filenames = {'mic1.aif', 'mic2.aif'};
nf = length(filenames);

channel = cell(1, nf);
for i = 1:nf
    channel{i} = aiffread(filenames{i});
end

%% Water calculations etc.
%
%
%  Theta
%  \    |
%   \   |
%    \  |
%     \ | 
%       @
%      @@@ Hydrophone 1
%       @  
%           
%
%  @           @ 
% @@@         @@@ Hydrophone 2
%  @           @

% Spacing in inches
hydrophone_spacing = 0.96;

