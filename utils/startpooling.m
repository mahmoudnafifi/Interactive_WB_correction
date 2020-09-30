function  startpooling(NUM_WORKERS)
%Start parallel pool using the given number of cores (requires Parallel
%Computing Toolbox).
%
%Input:
%   -NUM_WORKERS: number of cores.
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

po = gcp('nocreate');
if ~isempty(po)
    if po.NumWorkers ~= NUM_WORKERS
        delete(po);
        pc=parcluster('local');
        pc.NumWorkers=NUM_WORKERS;
        po = parpool(NUM_WORKERS);
    end
else
    pc=parcluster('local');
    pc.NumWorkers=NUM_WORKERS;
    po = parpool(NUM_WORKERS);
end
end