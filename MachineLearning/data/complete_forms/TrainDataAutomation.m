%% Get a list of all files and folders in this folder.
files = dir;
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

%% Print folder names to command window.
% for k = 1 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
% end

for i = 3:length(subFolders)
    newFolder = subFolders(i).name;
    oldFolder = cd(newFolder);
    s = dir('*.png');
    for ii = 1:length(s)
        form_image = {s.name};
        process_this_image = ['../../../GenData ' form_image{ii} ' ' form_image{ii}(1)];
        
        system(process_this_image);
        
        
    end
    cd(oldFolder);
end