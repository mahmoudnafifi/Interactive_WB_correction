function data = generate_training_data(TrDir)

images = imageDatastore(TrDir);
images = images.Files;
 

startpooling (6); %comment it if you do not have parallel computing toolbox

ills = zeros(length(images),3);
mfs = zeros(length(images),33); 
parfor i = 1 : length(images) %use for instead of parfor if you do not have parallel computing toolbox
    [~,basename,ext] = fileparts(images{i});
    currname = [basename ext];
    parts = strsplit(currname,'_');
    parts = parts(1:end-2);
    basename = '';
    for p = 1 : length(parts)
        basename = [basename parts{p} '_'];
    end
    gtname = [basename 'G_AS.png'];
    
    I = im2double(imread(fullfile(TrDir,currname)));
    GT = im2double(imread(fullfile(TrDir,gtname)));
    
    ills(i,:) = illumgray(I); %grayworld estimation (you can replace it with other ill estimation 
	%methods, but be sure that you will use the same method in the testing phase).
	
    mfs(i,:) = reshape(PHI(reshape(I,[],3))\reshape(GT,[],3),1,[]); %compute polynomial mapping function
    
end

data.mapping_Funcs = mfs;
data.ills = ills;

save('data.mat','data','-v7.3');


