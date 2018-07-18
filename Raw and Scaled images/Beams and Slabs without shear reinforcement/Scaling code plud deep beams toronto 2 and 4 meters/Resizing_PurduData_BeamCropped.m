
clear all;clc, close all,
tic



files=dir(fullfile('Sorted_Segmented', '*.png'));
% to sort images with numbers, natsortfiles is a function to do that
FILES=natsortfiles({files.name});

 % To scale Purdue data based on Island data (I_primary)
 I_primary=imread('2_Island.png');
 [M,N]=size(I_primary);
 
 

% Define a cell to save segmented longitudinal cracks
deep_2=cell(length(files),1);  % deep including 4-m //  deep_2 exluding 4-m


for jj=1:length(files)
    
%     filename=files(jj).name;
    fname = strcat('./Sorted_Segmented/',char(FILES(jj)));
   
    
%    test_folder = strcat('./Scaled_Sorted_Images/',test_name,'/');
%    files = dir(fullfile(test_folder,'*.png'));
 
%    segmented_fname = strcat(seg_test_folder,files(ii).name);

%     Widden_filename=['Widden',filename];
    I=imread(fname);
    I=im2bw(I,0.1);
%     I=imfill(I,8,'holes'); 



% Dilate image, filling the gap between pixels
% se=strel('disk',1);
% I = imdilate(I,se);


% LmakeHomoonRC function makes image smoother and reduces the noise
% I=~I; 
% % I=imfill(I,8,'holes'); 
%     bw=ones(size(I,1),size(I,2));
%     I=LmakeHomoonRC(I(:,:,1),bw,5);   
%     % filling the holes in (rebars, aggregates and..)  
% 
% 
% I=~I;
% 
%   I=imfill(I,4,'holes'); 

    if length(size(I))==3
       I=rgb2gray(I);
    end
    


% To skeltonize or remove tiny branches before scaling
%    I= bwmorph(I, 'thin',Inf);
%    I= bwmorph(I,'skel',Inf);

     
    I=imresize(I,[M,N]);

%   Skeltonized the binary image (mainly reason is to extract features which tickness of the cracks can be ignored)    
%     I= bwmorph(I,'skel',Inf);

% To remove tiny branches after scaling
I=bwmorph(I,'spur');

   I= bwmorph(I, 'thin',Inf);
 I = bwareaopen(I, 10);



    Widden_fname = strcat('./Widden_Sorted_Segmented_BeamCropped_line/',char(FILES(jj)));

    imwrite(I,Widden_fname);
    

    deep_2{jj,1}=I;

clear n m I
end
save deep_2.mat;
toc