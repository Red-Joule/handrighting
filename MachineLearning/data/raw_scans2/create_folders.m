for i=1:26
    foldername = char(i+65);
    mkdir(foldername);
end

for i = 97:122
    foldername = strcat(char(i), 'small');
    mkdir(foldername);
end