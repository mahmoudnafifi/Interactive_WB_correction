function f = calc_m_angular_error(source, target,color_chart_area)
%Calculate mean angular error between source and target images.
%
%Input:
%   -source: image A
%   -target: image B 
%   -color_chart_area: If there is a color chart in the image (that is
%   masked out from both images, this variable represents the number of
%   pixels of the color chart.
%
%Output:
%   -f: the mean angular error between image A and image B.
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
if size(source,1)<=color_chart_area
    error('Color chart area should be less than the image area');
end
source=double(source);
target=double(target);
target_norm = sqrt(sum(target.^2,2));
source_mapped_norm = sqrt(sum(source.^2,2));
angles=dot(source,target,2)./(source_mapped_norm.*target_norm);
angles(angles>1)=1;
f=acosd(angles);
f(isnan(f))=0;
f=sum(f)/(size(source,1)-color_chart_area);
end