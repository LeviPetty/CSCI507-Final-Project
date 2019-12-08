function houghImg = hough(compDir, compFile)
    houghImg = imread(fullfile(compDir, compFile));
    gray = rgb2gray(houghImg);
    sigma = 1.5;
    [~, thresh] = edge(gray, 'canny', [], sigma);
    tHigh = 4.975*thresh(2);
    E = edge(gray, 'canny', [0.4*tHigh tHigh], sigma);
    
    for i=1:size(E, 1)
        for j = 1:size(E, 2)
            if E(i, j) == 1
                for k = i-2:i+2
                   for l = j-2:j+2
                       houghImg(k, l, 1) = 255;
                       houghImg(k, l, 3) = 255;
                   end
                end
            end
        end
    end
end