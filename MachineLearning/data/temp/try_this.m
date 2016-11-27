original = imread('A_composite.png');
PSF = fspecial('gaussian',60,10);
edgesTapered = edgetaper(original,PSF);
figure, imshow(original,[]);
figure, imshow(edgesTapered,[]);

bwmorph
