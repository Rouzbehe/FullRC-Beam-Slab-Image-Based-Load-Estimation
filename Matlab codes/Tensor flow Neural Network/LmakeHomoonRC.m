%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function is used to making the image homogenous
% using hibrid morphological reconstruction described in article in AQCH.

% feel free to use this function and cited information is as follows:
%     Cheng Lu, Muhammad Mahmood, Naresh Jha, Mrinal Mandal.
%     ''A Robust Automatic Nuclei Segmentation Technique for Quantitative Histopathological Image Analysis ''
%     Analytical and Quantitative Cytology and Histopathology. December 2012, P. 296-308.

%   -IM    input image, should be single channel
%   -bw    indicate the ROI in the input image, if you want to do it for
%   the whole image, just put a all 1 bw.
%   -strSize  the size of the morphological element, basically the size
%   that close to your object of interst got good result.
% Output:
%   -IM_homo  homogenous version of inpute image IM
%   
%  an example is as follows:
% IM=imread('testIM.jpg');
% bw=ones(size(IM,1),size(IM,2));
% IM_homo=LmakeHomoonRC(IM(:,:,1),bw,4);
% imshow(IM_homo);

% (c) Edited by Cheng Lu, http://www.ece.ualberta.ca/~lcheng4/
% Deptment of Eletrical and Computer Engineering,
% University of Alberta, Canada.  Aug, 2013
% If you have any problem feel free to contact me.
% Please address questions or comments to: hacylu@yahoo.com

% Terms of use: You are free to copy,
% distribute, display, and use this work, under the following
% conditions. (1) You must give the original authors credit. (2) You may
% not use or redistribute this work for commercial purposes. (3) You may
% not alter, transform, or build upon this work. (4) For any reuse or
% distribution, you must make clear to others the license terms of this
% work. (5) Any of these conditions can be waived if you get permission
% from the authors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function IM_homo=LmakeHomoonRC(IM,bw,strSize)

if ~exist('strSize','var')
    strSize=4;
end
if ~exist('bw','var') || isempty(bw)
    bw=ones(size(IM));
end

% complement of R channel
IMc = imcomplement(IM); 
IMc(~bw)=0;


% opening by reconstruction
se=strel('disk',strSize);
IMce=imerode(IMc,se);
IMceobr=imreconstruct(IMce,IMc);


% closing by reconstruction
IMceobIM=imcomplement(IMceobr);
IMceobIMe=imerode(IMceobIM,se);
IMceobIMbr=imcomplement(imreconstruct(IMceobIMe,IMceobIM));

% back to original
IM_homo= imcomplement(IMceobIMbr); 
IM_homo(~bw)=0;
end