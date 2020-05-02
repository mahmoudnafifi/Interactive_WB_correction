%%
% Copyright (c) 2019-present, Mahmoud Afifi
% 
% Please, cite the following paper if you use this code:
%
% Mahmoud Afifi and Michael S. Brown. Interactive White Balancing for
% Camera-Rendered Images. In Color and Imaging Conference (CIC), 2020.
%
% Email: mafifi@eecs.yorku.ca | m.3afifi@gmail.com
%%

%% input image info.
imageName = 'IN.JPG';
GTName = 'GT.JPG'; %if no ground truth file, use GTName = [];


%% loading our model
load(fullfile('models','model.mat'));


%% reading image
I = im2double(imread(imageName));
if isempty(GTName) == 0
    I_gt = imread(GTName);
end
sz = size(I);

%% gray-world estimation and correction
ill = illumgray(I); ill = ill./norm(ill); %estimate illuminant using GW
D = ill(2)./ill; %diagonal correction matrix

I_gw = out_of_gamut_clipping(reshape(reshape(im2double(I),[],3) * ...
    diag(D),size(I))); %corrected using GW wo our post-processing
imwrite(I_gw,'GW_result.jpg'); %result of GW

%% our post-processing
d = pdist2(ill,model.C,'cosine');
[~,cids] = sort(d); cid = cids(1);
M = reshape(D * reshape(model.B(cid,:),[3,33]),[11,3]);
I_corr = out_of_gamut_clipping(...
    reshape(PHI(reshape(I,[],3)) * M,[sz(1),sz(2),sz(3)]));
imwrite(I_corr,'Our_result.jpg');

%% Evaluate and show images
if isempty(GTName) == 0 %if ground truth image is provided
    [deltaE2000,mse,mae,deltaE] = evaluate_cc(uint8(I_corr*255),I_gt,0,4);
    fprintf('MSE: %0.3f, MAE: %0.3f, DeltaE: %0.3f\n',mse,mae,deltaE2000);
    subplot(1,4,1); imshow(I); title('input');
    subplot(1,4,2); imshow(I_gw); title('GW');
    subplot(1,4,3); imshow(I_corr); title('Ours');
    subplot(1,4,4); imshow(I_gt); title('GT');
else %if there is no ground truth provided
    subplot(1,4,1); imshow(I); title('input');
    subplot(1,3,2); imshow(I_gw); title('GW');
    subplot(1,3,3); imshow(I_corr); title('Ours');
end

