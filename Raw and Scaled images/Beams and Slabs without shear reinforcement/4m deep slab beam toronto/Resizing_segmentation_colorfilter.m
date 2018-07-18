
clear all;clc, close all,close all;
tic


% filename={'CRS' 'F1V1MS'  'F1V1RC' 'F1V2MS' 'F1V2RC' 'F1V3MS' 'F1V3MS' 'F1V3RC' 'F2V2MS' 'F2V2RC' 'F1V2MS_p', 'F1V2RC_p', 'C1C', 'C1F1V1',...
% 'C1F1V2' 'C1F1V3' 'C1F2V3' 'C1F3V3' 'C2C' 'C2F1V3' 'C2F2V3' 'C2F3V3' 'DC_P1' 'DC_P2' 'DC_P3' 'DC_P4' 'DC_P5'};

filename={'Sorted Data'};

for name=1:length(filename)
    
filenameOut=strcat('Resized','_',filename{name});
files=dir(fullfile(filename{name}, '*.png'));
% to sort images with numbers, 'natsortfiles' is a function to do that
FILES=natsortfiles({files.name});

 % To scale and rotate all images based on the reference image (without any
 % crack)
% original=imread(strcat(filename{name},'/','reference.png'));

%     if length(size(original))==3
%        original=rgb2gray(original);
%     end
    

for jj=1:length(files)
Image = imread(strcat(filename{name},'/',char(FILES(jj))));

Resized_fname = strcat(filenameOut,'/',char(FILES(jj)));


% imshow(croppedImage)
 

% to filter red colour
% imshow(croppedImage)

% filterimage=filter(croppedImage,[350, 50]);median filter on red channel
% (median filter does the trick to pull out the colour)
% filterimage=medfilt2(Image(:,:,3));
filterimage=Image;

% figure
%  imshow(filterimage)

% filterimage=bwmorph(filterimage,'spur');
% filterimage=bwmorph(filterimage,'fill');

 Binaryimage=~im2bw(filterimage,0.6);
 
%          maxgray=20;mingray=240 ; % work with croppedImage(:,:,2); if the back ground was redish (used for DC_P1-DC_P5)
%         
% %         Binaryimage = filterimage >= mingray ;% & filterimage <= maxgray;
%         Binaryimage =  filterimage <= maxgray;
    
%    figure
%   imshow(Binaryimage)

%  Binaryimage = bwareaopen(Binaryimage, 20);
% Binaryimage=imfill(Binaryimage,4,'holes');   
Binaryimage=bwmorph(Binaryimage,'skel',Inf);
Binaryimage=bwmorph(Binaryimage,'spur');

 imwrite(Binaryimage,Resized_fname);
end



end
%% 

toc