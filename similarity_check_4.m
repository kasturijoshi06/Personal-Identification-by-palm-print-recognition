clc;
clear;
close all;

%%
myFolder_ref_L = 'C:\Users\kastu\Documents\UIC\Projects\Palm_print\Left';
filePattern_ref_L = fullfile(myFolder_ref_L, '*.bmp');
bmpFiles_ref_L = dir(filePattern_ref_L);

myFolder_ref_R = 'C:\Users\kastu\Documents\UIC\Projects\Palm_print\Right';
filePattern_ref_R = fullfile(myFolder_ref_R, '*.bmp');
bmpFiles_ref_R = dir(filePattern_ref_R);

gar=0.00000; 
C=0.00000;
far=0.00000;
far_percent=0.00000;
gar_percent=0.00000;
frr_percent=0.00000;

for a=1:1380
%% TAKING REFERENCE LEFT PALM IMAGE
baseFileName_ref_L = bmpFiles_ref_L(a).name;
fullFileName_ref_L = fullfile(myFolder_ref_L, baseFileName_ref_L);
imageArray_ref_L = imread(fullFileName_ref_L);
BW_ref_L = edge(imageArray_ref_L,'sobel');

%% TAKING REFERENCE RIGHT PALM IMAGE
baseFileName_ref_R = bmpFiles_ref_R(a).name;
fullFileName_ref_R = fullfile(myFolder_ref_R, baseFileName_ref_R);
imageArray_ref_R = imread(fullFileName_ref_R);
BW_ref_R = edge(imageArray_ref_R,'sobel');

%% RIGHT AND RIGHT COMPARISON OF SAME PERSON 
count_RR_same=0;
for i=1:size(BW_ref_R,1)
    for j=1:size(BW_ref_R,2)
        if BW_ref_R(i,j)==BW_ref_R(i,j)
           count_RR_same=count_RR_same+1;
        end   
    end
end

%% LEFT AND LEFT COMPARISON OF SAME PERSON 
count_LL_same=0;
for i=1:size(BW_ref_L,1)
    for j=1:size(BW_ref_L,2)
        if BW_ref_L(i,j)==BW_ref_L(i,j)
           count_LL_same=count_LL_same+1;
        end   
    end
end
    
%% LEFT AND RIGHT COMPARISON OF SAME PERSON 
count_LR_same=0;
for i=1:size(BW_ref_L,1)
    for j=1:size(BW_ref_L,2)
        if BW_ref_L(i,j)==BW_ref_R(i,j)
           count_LR_same=count_LR_same+1;
        end   
    end
end

%% TOTAL SCORE OF SAME PERSON
scoreCount = count_RR_same + count_LL_same + count_LR_same;

%% COMPARING REFERENCE LEFT AND USER RIGHT PALM IMAGES; STORING THEIR SCORES IN SCOREARRAY_LR
myFolder_r = 'C:\Users\ROHINI GODBOLE\Documents\MATLAB\pictures\Right';
filePattern_r = fullfile(myFolder_r, '*.bmp');
bmpFiles_LR = dir(filePattern_r);

for k=1:1380
    baseFileName_r = bmpFiles_LR(k).name;
    fullFileName_r = fullfile(myFolder_r, baseFileName_r);
    imageArray_r = imread(fullFileName_r);
    BW_user_R = edge(imageArray_r,'sobel');
    
    count_LR=0;
    for i=1:size(BW_user_R,1)
        for j=1:size(BW_user_R,2)
            if BW_user_R(i,j)==BW_ref_L(i,j)
                count_LR=count_LR+1;
            end   
        end
    end
    
    scoreArray_LR(k)=count_LR;
end

%% COMPARING REFERENCE LEFT AND USER LEFT PALM IMAGES; STORING THEIR SCORES IN SCOREARRAY_LL
myFolder_l = 'C:\Users\ROHINI GODBOLE\Documents\MATLAB\pictures\Left';
filePattern_r = fullfile(myFolder_l, '*.bmp');
bmpFiles_LL = dir(filePattern_r);

for k=1:1380
    baseFileName_r = bmpFiles_LL(k).name;
    fullFileName_r = fullfile(myFolder_l, baseFileName_r);
    imageArray_r = imread(fullFileName_r);
    BW_user_L = edge(imageArray_r,'sobel');
    
    count_LL=0;
    for i=1:size(BW_user_L,1)
        for j=1:size(BW_user_L,2)
            if BW_user_L(i,j)==BW_ref_L(i,j)
                count_LL=count_LL+1;
            end   
        end
    end
    
    scoreArray_LL(k)=count_LL;
end

%% COMPARING REFERENCE RIGHT AND USER RIGHT PALM IMAGES; STORING THEIR SCORES IN SCOREARRAY_RR
myFolder_r = 'C:\Users\ROHINI GODBOLE\Documents\MATLAB\pictures\Right';
filePattern_r = fullfile(myFolder_r, '*.bmp');
bmpFiles_RR = dir(filePattern_r);

for k=1:1380
    baseFileName_r = bmpFiles_RR(k).name;
    fullFileName_r = fullfile(myFolder_r, baseFileName_r);
    imageArray_r = imread(fullFileName_r);
    BW_user_R = edge(imageArray_r,'sobel');
    
    count_RR=0;
    for i=1:size(BW_user_R,1)
        for j=1:size(BW_user_R,2)
            if BW_user_R(i,j)==BW_ref_R(i,j)
                count_RR=count_RR+1;
            end   
        end
    end
    
    scoreArray_RR(k)=count_RR;
end

%% TOTAL SCORES ARE STORED IN SCOREARRAY_1
scoreArray = scoreArray_LR + scoreArray_LL + scoreArray_RR;

%% IDENTIFICATIONS OF LEFT AND RIGHT PALM COMPARISONS

baseFileName_ref_R = bmpFiles_ref_R(a).name;
fullFileName_ref_R = fullfile(myFolder_ref_R, baseFileName_ref_R);

baseFileName_ref_L = bmpFiles_ref_L(a).name;
fullFileName_ref_L = fullfile(myFolder_ref_L, baseFileName_ref_L);

disp('Reference Images');
disp(fullFileName_ref_R);
disp(fullFileName_ref_L);

for i=1:1380
    if scoreArray(i)==scoreCount
        baseFileName_LR = bmpFiles_LR(i).name;
        fullFileName_LR = fullfile(myFolder_r, baseFileName_LR);
        
        baseFileName_LL = bmpFiles_LL(i).name;
        fullFileName_LL = fullfile(myFolder_l, baseFileName_LL);
        
        disp('Identified');
        disp(fullFileName_LR);
        disp(fullFileName_LL);
        
        C=C+1;
        
        if i<=(i+6)
            gar=gar+1;
            gar_percent=(gar/C)*100.00000;
            frr_percent=100.00000-gar_percent;
        end
       
        if C>gar
            far=(C-gar)/C;
            far_percent=far*100.00000;
        end
        
        fprintf('Percent GAR = %d  Percent FRR = %d  Percent FAR = %d\n',gar_percent,frr_percent,far_percent);
    
    end
end
end