function O=phi(I)

O=[I,... %r,g,b
    I(:,1).*I(:,2),I(:,1).*I(:,3),I(:,2).*I(:,3),... %rg,rb,gb
    I.*I,... %r2,g2,b2
    I(:,1).*I(:,2).*I(:,3),... %rgb
    ones(size(I,1),1)]; %1
end