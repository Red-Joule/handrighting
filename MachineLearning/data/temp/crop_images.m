%% Crop images and then create composite image    
% Create array of image names
    s = dir('*.png');
    form_image = {s.name};
    no_of_forms = length(form_image);
    
% store values of the rectangles specifying crop dimensions in MAT file    
load crop_vals;

% one-time creation of folders to save images into

% lowercase
for i = 27:length(crop_data.character_vals)
    mkdir(strcat(crop_data.character_vals{i}, 'small'));
end
% uppercase
for i = 1:26
    mkdir(crop_data.character_vals{i})
end
% *****MANUALLY CREATE 0-9*******



% preallocate dimensions of rects and chr
rects = zeros(62,4);
chr = char(ones(62,1));
% create vector of characters and 
% matrix of rectangle crop dimensions
for i = 1:length(crop_data.crop_rect_vals)
rects(i,:) = str2num(crop_data.crop_rect_vals{i});
chr(i) = crop_data.character_vals{i};
end



%% loop through each letter, and within that loop go through each form to get that letter
for i = 1:no_of_forms
    orig_image = imread(form_image{i});

    for ii = 1:52   %length(chr)
    % In form specified above, loop through each letter and create
    % image with just that letter.
    cropped_image = imcrop(orig_image, rects(ii,:));
    image_name = strcat(chr(ii), string(i), '.png');
    
    % find appropriate folder depending on character you cropped
    if ii < 27
        newFolder = chr(ii);
    elseif ii < 53
        newFolder = strcat(chr(ii),'small');
    else
        newFolder = string(crop_data.character_vals{ii});
    end
    
    % change into folder to save image, then return previous folder
    oldFolder = cd(char(newFolder));
    imwrite(cropped_image, char(image_name));
    cd(oldFolder);
    end
end


% A = [325.5 314.5 252 260]
% B = [609.5 310.5 252 260]
% C = [889.5 318.5 252 260]
% D = [1177.5 314.5 252 260]
% E = [1465.5 306.5 252 260]
% F = [1745.5 318.5 252 260]
% G = [2032.5 301.5 252 260]
% H = [325.5 614.5 252 260]
% I = [604.5 614.5 252 260]
% J = [896.5 614.5 252 260]
% K = [1184.5 614.5 252 260]
% L = [1463.5 610.5 252 260]
% M = [1747.5 610.5 252 260]
% N = [2031.5 610.5 252 260]
% O = [326.5 898.5 252 260]
% P = [326.5 898.5 252 260]
% Q = [901.5 898.5 252 260]
% R = [1181.5 898.5 252 260]
% S = [1465.5 902.5 252 260]
% T = [1749.5 898.5 252 260]
% U = [2028.5 902.5 252 260]
% V = [323.5 1190.5 252 260]
% W = [602.5 1190.5 252 260]
% X = [906.5 1182.5 252 260]
% Y = [1181.5 1182.5 252 260]
% Z = [1469.5 1182.5 252 260]
% a = [1753.5 1182.5 252 260]
% b = [2028.5 1186.5 252 260]
% c = [331.5 1490.5 252 260]
% d = [615.5 1498.5 252 260]
% e = [894.5 1498.5 252 260]
% f = [1182.5 1498.5 252 260]
% g = [1461.5 1486.5 252 260]
% h = [1753.5 1494.5 252 260]
% i = [2032.5 1498.5 252 260]
% j = [331.5 1782.5 252 260]
% k = [619.5 1782.5 252 260]
% l = [894.5 1774.5 252 260]
% m = [1194.5 1778.5 252 260]
% n = [1469.5 1786.5 252 260]
% o = [1753.5 1778.5 252 260]
% p = [2037.5 1778.5 252 260]
% q = [327.5 2070.5 252 260]
% r = [615.5 2074.5 252 260]
% s = [899.5 2070.5 252 260]
% t = [1187.5 2062.5 252 260]
% u = [1466.5 2074.5 252 260]
% v = [1754.5 2078.5 252 260]
% w = [2025.5 2078.5 252 260]
% x = [328.5 2370.5 252 260]
% y = [612.5 2362.5 252 260]
% z = [896.5 2370.5 252 260]
% 0 = [1180.5 2362.5 252 260]
% 1 = [1468.5 2358.5 252 260]
% 2 = [1747.5 2362.5 252 260]
% 3 = [2043.5 2362.5 252 260]
% 4 = [338.5 2650.5 252 260]
% 5 = [609.5 2654.5 252 260]
% 6 = [905.5 2675.5 252 260]
% 7 = [1184.5 2667.5 252 260]
% 8 = [1476.5 2679.5 252 260]
% 9 = [1751.5 2675.5 252 260]
