%% Get a list of all files and folders in this folder.
% files = dir;
files = dir('data/complete_forms');
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

%% Print folder names to command window.
% for k = 1 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
% end

for i = 3:length(subFolders)
    image_folder = subFolders(i).name;
    images_in_folder = strcat('data/complete_forms/', image_folder, '/*.png');
    all_images_in_folder = dir(images_in_folder);
    for ii = 1:length(all_images_in_folder)
        image_path = strcat('data/complete_forms/', image_folder,'/', all_images_in_folder(ii).name);
        letter = all_images_in_folder(ii).name(1);
        sys_command = ['./GenData ' image_path ' ' letter];
        system(sys_command);
    end
end