function output=eliminateobjects(im, q)
%
% function output=eliminateobjects(im, q)
%
%% LAB2, TASK 3
%
%% Eliminates objects smaller than those enclosed by a square of size q x q
%
% Eliminates objects smaller than (or equal to) those enclosed by a square
% of size q x q pixels by filtering the image by appropriate box kernel in
% one pass of the kernel over the image followed by thresholding the
% filtered result by an appropriate threshold value. In the input image,
% the background pixels have an intensity of B=0.1 and all objects have an
% average intensity value of Q=0.8. Suppose that we want to reduce the
% average intensity of those objects to one fourth of the average intensity
% of the objects (or less). That is, we want to reduce the average
% intensity to Q/4 or less.
%
%% Who has done it
%
% Authors: ricgo595 / marfr808
% You can work in groups of max 2 students
%
%% Syntax of the function
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1, containing a number of objects
%           q: The size that is specified in the task (all objects smaller
%              than (or equal to) those enclosed by a square of size q×q
%              pixels have to be eliminated)
%
%      Output argument:
%           output: is the input image, in which all objects smaller
%                   than q x q are eliminated
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 25.11.2020
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
Image = im;
%
%% Finding the size of the box filter
Q=0.8; %The average intensity of the objects
B=0.1; %The background pixel intensity

%
% we want to reduce the average intensity of the objects smaller than q x q
% to Q/4. Write the equation to calculate the size of the box filter (n xn) 
% based on B and Q.
% The equation here:
%S�tter in funktionen f�r average intensity med q/4
n_formula = q*sqrt((4*(Q-B))/(Q-4*B)); % The size of the required filter
    
%% Find the smallest (odd) size of the filter here:

% Avrundar mot n�rmaste integer (ned�t)
h = floor(n_formula); % the smallest odd size of the filter

% e �r resten av h delat p� tv� som justerar till n�rmast "udda" box
e = mod(h,2);
if(e == 0)
h = h+1;
else
h = h+2;
end
n = h;

%% Construct the box kernel here:

%skapar boxen fbox
fbox = ones(n)/(n*n); % the box filter kernel


%% Apply the box filter kernel to the image here:

im_filt = imfilter(im,fbox, 'symmetric'); % the filtered image


%% Threshold the filtered image
% If you have done everything correctly so far, the background and all
% objects smaller than q x q will hold pixel values smaller than Q/4.
% Use an appropriate threshold value (what is an appropriate threshold value?) 
% to threshold the filtered image. Call the resulting image
% after thresholding o_thresh. In this image, the background and all objects
% smaller than q×q are supposed to be black (0) and larger objects and
% around them to be white (1). Notice that you don't need to use for loops
% here. This operation can be done by only a one-line MATLAB command.
% Threshold the filtered result here:

% Gr�skalar en bild och filtrerar den till en tr�skelv�rde
o_thresh = imbinarize(im_filt, Q/4); % The result of thresholding the filtered image

%% Create the output image
% Use the thresholded image (o_thresh) as a mask to create the output image. 
% In the result (output), objects smaller than q×q are supposed to be eliminated.
% This means that, at those pixels o_thresh is equal to 1, the output image
% (output) has to be equal to the input image (im). At those pixels o_thresh is equal to 0,
% the output image (output) has to be equal to the intensity value of the background (B).
%
% HINT: Let us give an example. Assume that you have created a mask, holding 
% logical values 0 or 1. Assume that you want OUT to be equal to the image IN1, 
% where mask is 1, and equal to IN2 where mask is 0. This can be done by
% the following command:
%
% OUT= mask.*IN1 + (~mask.*IN2);
%
% Create the output image here:

% masks and creates the final image
output = o_thresh.*im + (~o_thresh.*B); % the output image

imshow([Image, output]);

%% Test your code
% Test your code on at least four different input images, as specified 
% in the document for Lab2 (Task 3).
%
%
%% Answer this question:
% Why couldn't your code eliminate one of the 2x2 objects in test4 when q=2? 
% Your answer here:


%
%