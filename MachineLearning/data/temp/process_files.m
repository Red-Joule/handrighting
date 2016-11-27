
s = dir;
letter_image = {s.name};
outputsize = [20, 30];
for i = 3:length(letter_image)
im = imread(letter_image{i});
new_image = imresize(im, outputsize);
imwrite(new_image, letter_image{i});
end