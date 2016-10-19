
s = dir;
letter_image = {s.name};
outputsize = [30, 20];
for i = 4:length(letter_image)
im = imread(letter_image{i});
new_image = imresize(im, outputsize);
imwrite(new_image, letter_image{i});
end