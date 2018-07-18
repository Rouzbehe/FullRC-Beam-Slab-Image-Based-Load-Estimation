% function regression_example()
% A example code that runs a regression algorithm on the Car dataset.
% http://www.sunghoonivanlee.com
% Written by Sunghoon Ivan Lee, All copy rights reserved, 2/20/2015 
% Revised on 7/22/2015

clear all; close all;close all

%% Initializing 
% adding the path to matlab2weka codes
% addpath([pwd filesep 'matlab2weka']);
% % adding Weka Jar file
% if strcmp(filesep, '\')% Windows    
%     javaaddpath('C:\Program Files\Weka-3-6\weka.jar');
% elseif strcmp(filesep, '/')% Mac OS X
%     javaaddpath('/Applications/weka-3-6-12/weka.jar')
% end
% adding matlab2weka JAR file that converts the matlab matrices (and cells)
% to Weka instances.
javaaddpath([pwd filesep 'matlab2weka' filesep 'matlab2weka.jar']);

%% Loading Image Dataset

%%%%%%%%%the approproate excel sheet should be chosen here %%%%%%%%%%%%  
Island_Data = xlsread('input','all_ex_postcap');
Purdue_data = xlsread('input','Purdu_ex_deep');

PCA_data = xlsread('input','PCA');
% PCA_data = xlsread('input','PCA_ex_postcap');



Toronto_Data=xlsread('input','Toronto');
Toronto_4m_Data=xlsread('input','4mdeep');
Purdue2_Data=xlsread('input','Purdu_2');
Haunched_Data=xlsread('input','Haunched');
Uniform_Data=xlsread('input','Uniform');



numbersample=1;
num_crossVali=1;


for kk=1:num_crossVali
 kk  
 
% try



%%%%%%%%%the approproate function should be chosen here %%%%%%%%%%%%

% Island data
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap('all');
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap_line('all');
% [OUTPUT_Crackshields]=FeatureExtraction_ex_postcap_BeamCropped('all');
[OUTPUT_Training]=FeatureExtraction_ex_postcap_BeamCropped_line('all');
% [OUTPUT_Crackshields]=Island_Scaled_segmented_ex_postcap_cropped_Skeltonized('all');


% Purdue data
% [OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line('all');
[OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line_ex_deep('all');


% PCA data
[OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line('all');
% [OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line_ex_postcap('all')


[OUTPUT_Toronto_4m]=FeatureExtraction_Toronto_4m('all');
[OUTPUT_Toronto]=FeatureExtraction_Toronto('all');
[OUTPUT_Purdue2]=FeatureExtraction_Purdue2('all');
[OUTPUT_Haunched]=FeatureExtraction_haunched('all');
[OUTPUT_Uniform]=FeatureExtraction_uniform('all');



%   end
    
for i=1:size(OUTPUT_Training,1);
Island_crack(i,:)=OUTPUT_Training{i,1};
end

for i=1:size(OUTPUT_test,1);
Purdue_crack(i,:)=OUTPUT_test{i,1};
end

for i=1:size(OUTPUT_PCA,1);
PCA_crack(i,:)=OUTPUT_PCA{i,1};
end


for i=1:size(OUTPUT_Toronto,1);
Toronto_crack(i,:)=OUTPUT_Toronto{i,1};
end


for i=1:size(OUTPUT_Toronto_4m,1);
Toronto_4m_crack(i,:)=OUTPUT_Toronto_4m{i,1};
end


for i=1:size(OUTPUT_Purdue2,1);
Toronto_Purdue2(i,:)=OUTPUT_Purdue2{i,1};
end

for i=1:size(OUTPUT_Haunched,1);
haunched(i,:)=OUTPUT_Haunched{i,1};
end

for i=1:size(OUTPUT_Uniform,1);
uniform(i,:)=OUTPUT_Uniform{i,1};
end

X=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);Toronto_4m_crack(:,:),Toronto_4m_Data(1:end,3:23);Toronto_Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];


Feat = X(:,[ 1: 21]);




% ranking using relief algorithm 
test=X(:,41);% %  24=deflectionRatio, 23=V   25=M  26=M/EI  27=M/bd^2  28=M/Asfy  29=V/GJ  30=V/bd 30=M/bd 32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 36=M/abh(l-a) or M/abh(l/2) 37=M/a^2bh 38=M/(pho bd)
              % 40=V/(2*sqrt(fc) bd) or V_V_ACI    41=FailureRatio

% y = sortedClass;%'method','classification'

 K=10;
% K=length(X(:,24));
[ranked,weights(:,kk)] = relieff(Feat,test,K,'Method','regression');
% end
% clear X OUTPUT_Crackshields
end

%%
figure2=figure('Position', [50, 50, 2400, 1800]);

% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation','Central Moment','Moment of Inertia','Polar Moment of Inertia'};
featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Average Perimeter','Total Perimeter','Total majorAxis','Average majorAxis','EulerNumber','Standard Deviation','Central Moment','I-xx','I-yy','Polar Moment of Inertia','Number of Cracks'};
fH = gcf; colormap(jet(5));
bar(mean(weights,2));


set(gca,'XTick', 1:length(featName), 'XTickLabel', featName,'fontsize',22,'XLim',[0 length(featName)+1]); 
rotateXLabels( gca(), 45 )
xlabel('Features','fontsize',24);
ylabel('Feature importance weight','fontsize',24);
applyhatch_pluscolor(fH,'c', 0, [1], jet(5))



%plotfname='Features_V_CrackType_All';
% if (exist(char('May28_Accuracy_Parameters'),'dir') == 0); mkdir(char('May28_Accuracy_Parameters')); end;
% Namepdf = strcat('May28_Accuracy_Parameters','/',plotfname,'.pdf');
% NameJPG = strcat('May28_Accuracy_Parameters','/',plotfname);

% print('-dpdf',char(Namepdf),'-r600')
% print(char(NameJPG),'-dpng', '-r1000');



