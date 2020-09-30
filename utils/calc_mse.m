function mse=calc_mse(source,target,color_chart_area)
%Calculate mean squared error between source and target images.
%
%Input:
%   -source: image A
%   -target: image B 
%   -color_chart_area: If there is a color chart in the image (that is
%   masked out from both images, this variable represents the number of
%   pixels of the color chart.
%
%Output:
%   -f: the mean squared error between image A and image B.
%
%%
% Copyright (c) 2020-present, Mahmoud Afifi
% 
% Please, cite the following paper if you use this code:
%
% Mahmoud Afifi and Michael S. Brown. Interactive White Balancing for
% Camera-Rendered Images. In Color and Imaging Conference (CIC), 2020.
%
% Email: mafifi@eecs.yorku.ca | m.3afifi@gmail.com
%%

if nargin==2
    color_chart_area=0;
end
if size(source,1)*size(source,2)<=color_chart_area
    error('Color chart area should be less than the image area');
end
source=double(source);
target=double(target);
diff=(source(:)-target(:)).^2;
mse=sum(diff)/(length(diff)-color_chart_area);
end