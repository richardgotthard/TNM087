function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )
%function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )

%   Implement gamma correction:
%   Truncate the original gray values using lower and upper quantiles
%   (Lower, Upper) and then apply gamma correction with exponent Gamma 
%   to the input image OImage,
%   the result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: ricgo595 and marfr808, same as in the Lisam submission
% You can work in groups of max 2 students
%
%% Syntax of the function
%
%   Input arguments:
%       OImage: Grayscale image of type uint8 or double
%       Gamma: exponent used in the gamma correction, 
%       Lower: value in the range 0, 1
%       Upper: value in the range 0, 1 and lower < upper
%       Lower and Upper are quantile values. 
%   Output argument: GImage: gamma corrected gray value image of type double
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: today's date
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
%% Image class handling
% Make sure that you can handle input images of class uint8, uint16 and double

Testimage = imread(OImage); %reads in input image
Test2 = im2double(Testimage); %converts image into matrix of doubles
GImage = Test2; % converts into the function image



%% Compute lower and upper gray value boundaries. 
% Use the parameteers Lower and Upper to find the corresponding gray values
% for the boundaries
% Look at the help function for the command quantile
%
lowgv = quantile(GImage(:),Lower); % Lower-bound gray value
uppgv = quantile(GImage(:),Upper); % Upper-bound gray value

%% Compute a scaled version GImage of the image, where: 
% the lower-bound gray value is zero 
% the upper-bound gray value is one 
% because 0^Gamma = 0 and 1^Gamma = 1

GImage = (GImage-lowgv)/(uppgv-lowgv);
GImage(GImage > 1) = 1;
GImage(GImage < 0) = 0;

%% Gamma mapping of the previous result 
% Make sure that your image is in the range [0,1] before applying gamma
% correction!
%

GImage = GImage.^Gamma; % apply gamma correction (which is an elementwise operation)
%imshow(GImage);
figure;
imhist(GImage);
%imshow([Test2, GImage]);

end

%% Experiments with your code
%
% Use your code to modify the images 'aerialview-washedout.tif' and
% 'spillway-dark.tif' for different values for Gamma, Lower and Upper
% Write some comments on your experiments and propose some good parameters
% to use (don't forget to comment your text so that the code will work)
% 
% 'spillway-dark.tif':
%
% Since the picture was way to dark 
%    GammaCorrection( 'spillway-dark.tif', 0.4, 0.1, 0.9 )
%
%
% 'aerialview-washedout.tif'
%
%
%
%
% The image ?IntensityRampGamma25.tif? illustrates the effect of an intensity
% ramp displayed on a monitor with gamma =2.5. 
% Which value for gamma should you use in your code to correct the image to appear as a linear intensity ramp?
% (Set Lower=0 and Upper=1)
% Gamma = ?




