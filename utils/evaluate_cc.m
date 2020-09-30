function varargout = evaluate_cc(corrected, gt, color_chart_area, opt)
%Calculate errors between the corrected image and the ground truth image.
%
%Input:
%   -corrected: image A (corrected image).
%   -gt: image B (ground-truth image).
%   -color_chart_area: If there is a color chart in the image (that is
%   masked out from both images, this variable represents the number of
%   pixels of the color chart. (default color_chart_area = 0).
%   -opt: determines the required error metric(s) to be reported. 
%         Options: 
%           opt = 1 delta E 2000 (default).
%           opt = 2 delta E 2000 and mean squared error (MSE)
%           opt = 3 delta E 2000, MSE, and mean angular eror (MAE)
%           opt = 4 delta E 2000, MSE, MAE, and delta E 76
%
%Output:
%   -f: the mean square error between image A and image B.
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

if nargin == 2
    color_chart_area = 0;
    opt = 1;
elseif nargin == 3
    opt = 1;
end
switch opt
    case 1
        varargout{1} = calc_deltaE2000(corrected,gt,color_chart_area);
    case 2
        varargout{1} = calc_deltaE2000(corrected,gt,color_chart_area);
        varargout{2} =calc_mse(corrected,gt,color_chart_area);
    case 3
        varargout{1} = calc_deltaE2000(corrected,gt,color_chart_area);
        varargout{2} =calc_mse(corrected,gt,color_chart_area);
        varargout{3} =calc_m_angular_error(reshape(corrected,[],3),reshape(gt,[],3),...
            color_chart_area);
    case 4
        varargout{1} = calc_deltaE2000(corrected,gt,color_chart_area);
        varargout{2} =calc_mse(corrected,gt,color_chart_area);
        varargout{3} =calc_m_angular_error(reshape(corrected,[],3),reshape(gt,[],3),...
            color_chart_area);
        varargout{4} = calc_deltaE(corrected,gt,color_chart_area);
    otherwise
        error('Error in evaluate_cc function');
end
end