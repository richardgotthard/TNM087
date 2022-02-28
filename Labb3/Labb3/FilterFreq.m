function [olp, ohp]=FilterFreq(f, D0)
%
% function [olp, ohp]=FilterFreq(f, D0)
%
%% Lab3, Task 2
%
%% Performs filtering in the frequency domain
%
% Lowpass and highpass filters the image in the frequency domain by
% a Gaussian filter constructed in the frequency domain
%
%% Who has done it
%
% Author: ricgo595
% Co-author: marfr808
%
%% Syntax of the function
%      Input arguments:
%           f: the original input grayscale image of type double scaled
%               between 0 and 1
%           D0: The cutoff frequency of the Gaussian lowpass filter
%
%      Output arguments:
%           olp: the result after lowpass filtering the input image by
%                the Gaussian lowpass filter
%           ohp: the result after highpass filtering the input image by
%                the Gaussian highpass filter
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 3rd of december 2020
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
%----?_-
% 4) Often you must do something else between the given commands in the
%       template
%
%% Here starts your code.
% % % Write the appropriate MATLAB commands right after each comment below.
%
%% zero pad the input image
% The input image is zero padded to an image of size P x Q, where P = 2M and
% Q = 2N (M x N is the size of the input image). Notice that the input
% image has to be placed at the top-left corner of the zero-padded image.
% creates a size derived from the image f
[M, N] = size(f);

%creates P and Q from instructions
P = 2*M;
Q = 2*N;

%creates a matrix with size p and q which is empty
fp= zeros(P, Q); 
% shifts the image from the first top left pixel (1,1) 
% and fills in the rest of the image
fp(1:M, 1:N) = f; % the zero padded image
    
%% construct the Gaussian lowpass filter transfer function
% If you want, you can write a separate function to construct the Gaussian filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
% % The transfer function is supposed to be the same size as the padded image
% that is P x Q
% The cutoff frequency of this filter, D0, is the second input argument of
% this MATLAB function

% As specified in Chapter 4
[X,Y] = meshgrid(0:P-1,0:Q-1);
X = X';
Y = Y';
D = sqrt((X-P/2).^2 + (Y-Q/2).^2);

GLPF= exp((-D.^2)./2*D0^.2); % the Gaussian lowpass filter transfer function
    
%% Perform filtering in the frequency domain
% Find the product between the filter transfer function and the Fourier
% transform of the padded image (Notice that the zero frequency is supposed
% to be shifted to the center of the Fourier transform)

% The fourier transform of the the orginal image
FFD = fftshift(fft2(fp));

OLP= GLPF.*FFD; % The Fourier transform of the lowpass filtered image
    
%% Find the padded lowpass filtered image
% The zero frequency of OLP should be shifted back to the top left corner of the
% image followed by the inverse Fourier transform. Take the real part of
% the result.

shift_back = ifft2(ifftshift(OLP));

olpf= real(shift_back); % The padded lowpass filtered image of size P x Q
    
%% Find the lowpass filtered image
% Extract the final lowpass filtered image from the padded lowpass filtered
% image

olp= olpf(1:M,1:N); % The final lowpass filtered image
    
%% Find the final highpass filtered image
% Read the document for this task

ohp= f - olp; % The final highpass filtered image
    
imshow([olp, ohp]);
%% Test your code
%
% Test your code on different images (for example Einstein1.jpg,
% Einstein2.jpg or characterTestPattern.tif) using different cutoff
% frequencies and look at the result of lowpass filtering and highpass
% filtering the original image. Ask yourself, what happens if you increase
% the cutoff frequency (the second input argument of your function). Will the
% result be blurrier or less blurry? Test it and see whether or not you are
% correct. Hopefully, you are not surprised by the result, if you are,
% discuss it with your classmates or the teachers.
