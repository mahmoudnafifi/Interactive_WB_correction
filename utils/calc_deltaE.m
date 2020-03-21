function deltaE=calc_deltaE(source,target,color_chart_area)
%Calculate Delta E76 between source and target images.
%
%Input:
%   -source: image A
%   -target: image B 
%   -color_chart_area: If there is a color chart in the image (that is
%   masked out from both images, this variable represents the number of
%   pixels of the color chart.
%
%Output:
%   -deltaE: the value of Delta E76 between image A and image B.
%
% Copyright (c) 2018 Mahmoud Afifi
% Lassonde School of Engineering
% York University
% mafifi@eecs.yorku.ca
%
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files (the 
% "Software"), to deal in the Software with restriction for its use for 
% research purpose only, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
%
% Please cite the following work if this program is used:
% Mahmoud Afifi, Brian Price, Scott Cohen, and Michael S. Brown, "White Balance Correction for sRGB Rendered Images", ECCV 2018.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
deltaE = sqrt(sum((source - target).^2,2));
deltaE=sum(deltaE)/(size(deltaE,1)-color_chart_area);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%References:
%[1] http://zschuessler.github.io/DeltaE/learn/