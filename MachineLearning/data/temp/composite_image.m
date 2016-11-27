function composite_image(foldername)

%% show all images
% get list of all images that will be displayed
s = dir('*.png');
all_images = {s.name};

figure
% create 7 by 7 grid of images
for i = 1:47
  this_image = imread(all_images{i});
  subplot(7,7,i); 
  imshow(this_image);
  fig = gcf;
  fig.Color = 'white';
end
this_folder = foldername;
figureTitle = strcat(this_folder, '_composite');
print(char(figureTitle), '.png');
close gcf;
end