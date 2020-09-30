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

function [I,map] = out_of_gamut_clipping(I)

    sz = size(I);
    
    I = reshape(I,[],3);

     map = ones(size(I,1),1);
     map(I(:,1)>1 | I(:,2)>1 | I(:,3)>1 | I(:,1)<0 | I(:,2)<0 | I(:,3)<0)=0;
     map = reshape(map,[sz(1),sz(2)]);
    
     I(I>1)=1; 
     I(I<0)=0; 

     I = reshape(I,[sz(1),sz(2),sz(3)]);

end

