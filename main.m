bool = exist('baseDir', 'var') & exist('baseFiles', 'var') & exist('compDir', 'var') & exist('compFiles', 'var');

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

matchmat = [4 16 13 24 26 14 21 19 15 12];
matchmat = [matchmat; 1 3 6 7 9 10 17 20 23 24];
matchmat = [matchmat; 1 2 3 5 7 8 20 22 25 26];
truematch = zeros(26, 3);
for i = 1:size(matchmat, 1)
    for j = 1:size(matchmat, 2)
        cardid = matchmat(i, j);
        truematch(cardid, i) = 1;
    end
end
truematch = [truematch truematch];
doesMatch = sift(baseDir, baseFiles, compDir, compFiles);

acc = 0;
for i = 1:size(doesMatch, 1)
    for j = 1:size(doesMatch, 2)
        if doesMatch(i, j) == truematch(i, j)
            acc = acc + 1;
        end
    end
end
acc = (acc / (26*6)) * 100;
acc