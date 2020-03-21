clear
clc
close all;

training_data = 'data';  % 'none'; %use none if you have not computed illuminants 
%and mapping functions yet. Otherwise, write the .mat filename. This file
%should be a structure named data and has the following fields: 1) ills 
%(nx3 matrix) contains the estimated illuminants and 2) mapping_Funcs (nx33
%matrix) contains the polynomial mapping functions.

trainingImgsDir = [];%'data'; %leave it empty if you computed the training data. 
%Otherwise, it should contain training images directory. Filenames of
%training images should be in this format Z_X_XX.png and filenames of 
%ground truth images should be in this format Z_G_AS.png. Be sure that
%filenames of input training images have the same part of the corresponding
%ground truth image filenames (i.e., Z). For example, if input image is
%named image001_X_Y.png, the ground truth image should be named
%image001_G_AS.png (with the same extension). 
%Ground truth images should be located in the same directory with input 
%training imgaes. 

outputModel = 'model.mat'; %name of output model, it will be saved in 
%directory named 'models'

if strcmpi(training_data,'none') == 0
    disp('Loading training data...');
    load(training_data); %load training data
else
    disp('Generating training data...');
    data = generate_training_data(trainingImgsDir); %generate training data
    %data will be automatically saved in 'data.mat' file in the same
    %direcotyr of this source code file.
end

%clustering and computing B
disp('Computing rectification functions...');
k = 50;
[idx, C] = kmeans(data.ills,k,'Distance','cosine','MaxIter',10000); %kmean clustering
ids = unique(idx); %get cluster ids
B = zeros(max(ids),size(data.ills,2),size(data.mapping_Funcs,2)); %B functions (H functions in our paper)
for i = ids'
    id = idx  == i ;
    M = data.mapping_Funcs(id,:);
    ills = data.ills(id,:); ills = ills./sqrt(ills(:,1).^2 + ...
        ills(:,2).^2 + ills(:,3).^2);
    D =  ills(:,2)./ills;
    B(i,:,:) = D\M;
end


model.C = C; %cluster centers
model.B = B; %rectifcation  functions (refered as H in our paper)


% saving the model
disp('Saving computed model...');
if exist('models','dir') == 0
    mkdir('models');
end

save(fullfile('models',outputModel),'model','-v7.3');

