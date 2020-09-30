function deltaE00=calc_deltaE2000(source,target,color_chart_area)
%Calculate Delta E2000 between source and target images.
%
%Input:
%   -source: image A
%   -target: image B 
%   -color_chart_area: If there is a color chart in the image (that is
%   masked out from both images, this variable represents the number of
%   pixels of the color chart.
%
%Output:
%   -deltaE: the value of Delta E2000 between image A and image B.
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
source=double(rgb2lab(source));
target=double(rgb2lab(target));
source = reshape(source,[],3); %l,a,b
target = reshape(target,[],3); %l,a,b
deltaE00 = deltaE2000(source , target)';
deltaE00=sum(deltaE00)/(size(deltaE00,1)-color_chart_area);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%References:
% [1] The CIEDE2000 Color-Difference Formula: Implementation Notes, Supplementary Test Data, and Mathematical Observations,", G. Sharma, W. Wu, E. N. Dalal, Color Research and Application, vol. 30. No. 1, pp. 21-30, February 2005.