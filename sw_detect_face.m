function [ patches,bbox_location ] = sw_detect_face( real_image,window_size, scale,stride )
% sw_multiscale_detect_face
% - This is a function to proposed the potential face images via moving the
% sliding window. 
%==========================================================================
% Output:
%   - patches: a cell to store every window_size proposed images. The size
%               of save images are H*W*N, where N is the number of sliding
%   - bbox_location: bounding box [x,y,height,width]
%--------------------------------------------------------------------------
% Input:
%   - real_image : The original images without resize
%   - window_size: The proposed sliding window size
%   - scale      : The scale of for each original image
%   - stride     : The steps between each save images
%==========================================================================

% single-scale sliding window
[irow, icol] = size(real_image);
window_r = window_size(1);
window_c = window_size(2);


single_patches = zeros(window_r, window_c, floor(irow/window_r) * floor(icol/window_c), 'uint8');
% single_patches = zeros(window_r, window_c,5, 'uint8');

% Iteratively save the patches.
% r = randi(irow-window_r,5,1);
% c = randi(icol-window_c,5,1);
for i = 1:irow/window_r
    for j = 1:icol/window_c
        single_patches(:,:,(i-1)*floor(irow/window_r) + j) = real_image(window_r *(i-1) + 1:window_r*(i-1)+window_size, window_c *(j-1)+1:window_c*(j-1)+window_size);
        single_bbox_location((i-1)*floor(irow/window_r) + j, :) = [(i-1)*window_r+1,(j-1)*window_c+1,window_r,window_c]; % top-left y,x, height, width
    end
end

patches{1} = single_patches;
bbox_location{1} = single_bbox_location;

end

