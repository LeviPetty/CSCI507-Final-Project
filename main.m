% bool = exist('baseDir', 'var') & exist('baseFiles', 'var') &
% exist('compDir', 'var') & exist('compFiles', 'var')
bool = exist('baseDir', 'var') & exist('compDir', 'var');

if ~bool
    disp('Please select the Card Images folder');
    baseDir = uigetdir;
    if baseDir == 0
        return
    end
    % baseFiles = dir(fullfile(baseDir, '*.jpg'));
    
    disp('Please select the Kingdoms folder');
    compDir = uigetdir;
    if compDir == 0
        return
    end
    % compFiles = dir(fullfile(compDir, '*.jpg'));
else
    if input('Does the Card Images folder have the same path as before? (y/n) ', 's') ~= 'y'
        disp('Please select the Card Images folder');
        baseDir = uigetdir;
        % baseFiles = dir(fullfile(baseDir, '*.jpg'));
    end
    if input('Does the Kingdoms folder have the same path as before? (y/n) ', 's') ~= 'y'
        disp('Please select the Kingdoms folder');
        compDir = uigetdir;
        % compFiles = dir(fullfile(compDir, '*.jpg'));
    end
end

baseFile = input('Please input name of first file: ', 's');
compFile = input('Please input name of second file: ', 's');
doesMatch = sift(baseDir, baseFile, compDir, compFile);
houghImg = hough(compDir, compFile);

found = 'No';
if doesMatch
    found = 'Yes';
end

cardName = extractBetween(baseFile, "", ".jpg");
finalImg = insertText(houghImg, [0 0], sprintf('Card %s in image: %s', baseFile, found), 'FontSize', 64, 'BoxColor', 'white');
imshow(finalImg);