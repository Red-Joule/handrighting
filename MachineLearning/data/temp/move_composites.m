% Find composites
s = dir('**/*_composite.png');
mkdir composite_files;
endFolder = 'composite_files';
for i = 1:length(s)
    newFolder = s(i).folder;
    oldFolder = cd(newFolder);
    I = imread(s(i).name);
    cd(oldFolder);
    oldFolder = cd(endFolder);
    imwrite(I, s(i).name);
    cd(oldFolder);
end

