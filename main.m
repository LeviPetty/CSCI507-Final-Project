bool = exist('baseDir', 'var') == exist('baseFiles', 'var') == exist('compDir', 'var') == exist('compFiles', 'var') == 1;

if ~bool
    disp('Please select folder containing the first image');
    baseDir = uigetdir;
    if baseDir == 0
        return
    end
    baseFiles = dir(fullfile(baseDir, '*.jpg'));
    
    disp('Please select folder containing the second image');
    compDir = uigetdir;
    if compDir == 0
        return
    end
    compFiles = dir(fullfile(compDir, '*.jpg'));
else
    if input('Is the folder containing the first image the same as before? (y/n) ', 's') ~= 'y'
        disp('Please select folder containing the first image');
        baseDir = uigetdir;
        baseFiles = dir(fullfile(baseDir, '*.jpg'));
    end
    if input('Is the folder containing the second image the same as before? (y/n) ', 's') ~= 'y'
        disp('Please select folder containing the second image');
        compDir = uigetdir;
        compFiles = dir(fullfile(compDir, '*.jpg'));
    end
end

doesMatch = sift(baseDir, baseFiles, compDir, compFiles);