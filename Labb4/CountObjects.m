function [IMG, noRice, noSmallMacs, noLargeMacs]=CountObjects(in)
%% Lab4, Task 3
%% Finds the number of rows of bricks
%
% Counts objects of different class and displays them in different colors. 
% Input images containing three classes of ojects: grains of rice, snall
% macaronis and large macaronis
%
%% Who has done it
%
% Author: Marcus Frankelius (marfr808)
% Co-author: Richard Gotthard (Ricgo595)
%
%
%% Syntax of the function
%      Input arguments:
%           in: the original input RGB color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output RGB color image, displaying the three
%           diffferent classes of objects in different colors
%           noRice: Number of grains of rice in the input image
%           noSmallMacs: Number of small macaromis in the input image
%           noLargeMacs: Number of large macaromis in the input image
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 11/12 2020
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) Often you must do something else between the given commands in the
%       template
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%

%% Make the input color image grayscale, 
% by choosing its most appropriate channel 

bgray =in(:,:,3); % The grayscale version of the input color image
    
%% Threshold your image
% to separate the objects from the backgroound

b_thresh =graythresh(bgray)>bgray; % The thresholded image
    
%% Clean up the binary image 
% Use morphological operations to clean up the binary image from noise. 
% Especially make syre that your cleaned image don't contain any false object
% (i.e. single foreground pixels, or groups of connected foreground pixels, 
% that do not belong to the object classes  
SE = strel('disk',4);
IM1 = imopen(b_thresh, SE);
IM2 = imclose(IM1, SE);
b_clean =IM2; % Cleaned up binary image


%% Labelling
%  Use labelling to assign every object a unique number

L =bwlabel(b_clean); % Labelled image
    
%% Object features
% Compute relevant object features that you can use to classify 
% the three classes of objects
S = regionprops(L,'Area');

for n=1:length(S)
    
    Area(n)=S(n).Area;
  
end
  
%% Object classification
% Based on your object features, classify the objects, i.e. for each
% labelled object: decide if it belongs to the three classes: Rice, SmallMacs, or LargeMacs 
% In case you didn't suceed in cleaining up all false objects, you should
% discard them here, so they don't count as the classes of objects

%Hittar de olika objecten beroende på dess storlek
Largeobjects = find(Area>7000);
Mediumobjects = find(Area<7000 & Area>2000);
Smallobjects = find(Area<2000);


%% Count the objects for each class.

%Length beräknar antalet object
noRice = length(Smallobjects);% Number of rices
noSmallMacs = length(Mediumobjects); % Number of small macoronis
noLargeMacs = length(Largeobjects);% Number of large macoronis

%% Create an RGB-image, IMG, displaying the different classes of objects in different colors
% Use for example: Colored objects on black background, colored objects on
% the original background, highlight the borders of the objects in the
% original image in different colors (or some other way of displayig the
% objects)
[x,y] = size(L);
zeromatrix = zeros(x,y);
RGB=zeros(x,y,3);

LargeO_Im = zeromatrix;
MediumO_Im = zeromatrix;
SmallO_Im = zeromatrix;

for n=1:length(Largeobjects)
    LargeO_Im(L==Largeobjects(n))=1;
end

for n=1:length(Mediumobjects)
    MediumO_Im(L==Mediumobjects(n))=1;
end

for n=1:length(Smallobjects)
    SmallO_Im(L==Smallobjects(n))=1;
end

RGB(:,:,1)=LargeO_Im;
RGB(:,:,2)=MediumO_Im;
RGB(:,:,3)=SmallO_Im;

IMG = RGB;  % Output RGB-image displaying the three classes of objects in different colors
IMG = [SmallO_Im, MediumO_Im, LargeO_Im];

imshow(IMG);

%% Test your code on the three test images
% % Your code is supposed to work for the three images:
%
% Image          noRice   noSmallMacs   noLargeMacs
% MacnRice1.tif  48       12            6
% MacnRice2.tif  60       14            6
% MacnRice3.tif  42       11            5



