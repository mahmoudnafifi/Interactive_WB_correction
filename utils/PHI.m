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

function O=PHI(I)

O=[I,... %r,g,b
    I(:,1).*I(:,2),I(:,1).*I(:,3),I(:,2).*I(:,3),... %rg,rb,gb
    I.*I,... %r2,g2,b2
    I(:,1).*I(:,2).*I(:,3),... %rgb
    ones(size(I,1),1)]; %1
end