function doesMatch = sift(baseDir, baseFile, compDir, compFile)
    peakThresh = 4;
    edgeThresh = 10;
    matchThresh = 15;
    N = 1;

    if exist('vl_sift', 'file') == 0
        disp('Please select folder containing vl_setup.m file');
        siftDir = uigetdir;
        run(fullfile(siftDir, 'vl_setup'));
    end

    % Feature detection for card image
    baseImg = imread(fullfile(baseDir, baseFile));
    baseSingle = single(rgb2gray(baseImg));
    [f1, d1] = vl_sift(baseSingle, 'PeakThresh', peakThresh, 'edgethresh', edgeThresh);
    
    % Feature detection for set image
    compImg = imread(fullfile(compDir, compFile));
    compSingle = single(rgb2gray(compImg));
    [f2, d2] = vl_sift(compSingle, 'PeakThresh', peakThresh, 'edgethresh', edgeThresh);
    
    % Compare features
    [matches, scores] = vl_ubcmatch(d1, d2, matchThresh);
    doesMatch = (size(matches, 2) >= N);
    
%     doesMatch = [];
%     for i = 1:length(baseFile)
%         baseImg = imread(fullfile(baseDir, baseFile(i).name));
%         baseGray = rgb2gray(baseImg);
%         baseSingle = single(baseGray);
%         [f1, d1] = vl_sift(baseSingle, 'PeakThresh', peakThresh, 'edgethresh', edgeThresh);
% 
%         for j = 1:length(compFile)
%             compImg = imread(fullfile(compDir, compFile(j).name));
%             compGray = rgb2gray(compImg);
%             compSingle = single(compGray);
%             [f2, d2] = vl_sift(compSingle, 'PeakThresh', peakThresh, 'edgethresh', edgeThresh);
% 
%             [matches, scores] = vl_ubcmatch(d1, d2, matchThresh);
%             doesMatch(i, j) = (size(matches, 2) >= N);
%             disp(sprintf('Finished evaluating card #%d on Kingdom #%d.',i,j)); 
%         end
%     end
end