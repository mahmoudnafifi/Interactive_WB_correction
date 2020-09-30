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

%% input image dir info.
input_dir = 'input_images';
input_image_ext = '.jpg';

%% output image dir info.
output_dir = 'results';

if exist(output_dir,'dir') == 0
    mkdir(output_dir);
end

images = dir(fullfile(input_dir,['*' input_image_ext]));

images = {images(:).name};

%% loading our model
load(fullfile('models','model.mat'));

for i = 1 : length(images)
    fprintf('processing %s ... \n',images{i});
    imageName = fullfile(input_dir,images{i});
    
    %% reading image
    I = im2double(imread(imageName));
    sz = size(I);
    
    %% gray-world estimation and correction
    ill = illumgray(I); ill = ill./norm(ill); %estimate illuminant using GW
    D = ill(2)./ill; %diagonal correction matrix
    
    %% our post-processing
    d = pdist2(ill,model.C,'cosine');
    [~,cids] = sort(d); cid = cids(1);
    M = reshape(D * reshape(model.B(cid,:),[3,33]),[11,3]);
    I_corr = out_of_gamut_clipping(...
        reshape(PHI(reshape(I,[],3)) * M,[sz(1),sz(2),sz(3)]));
    
    imwrite(I_corr,fullfile(output_dir,images{i}));
end
