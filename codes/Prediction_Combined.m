
clear all; close all;clc;

%% Initializing 
% adding the path to matlab2weka codes
addpath([pwd filesep 'matlab2weka']);
% adding Weka Jar file
if strcmp(filesep, '\')% Windows    
    javaaddpath('C:\Program Files\Weka-3-6\weka.jar');
elseif strcmp(filesep, '/')% Mac OS X
    javaaddpath('/Applications/weka-3-6-12/weka.jar')
end
% adding matlab2weka JAR file that converts the matlab matrices (and cells)
% to Weka instances.
javaaddpath([pwd filesep 'matlab2weka' filesep 'matlab2weka.jar']);

%% Loading Car Dataset

[Data_120,text_120] = xlsread('input','120Cracks');

[Data_95,text_95] = xlsread('input','95Cracks');

[Data_7specimen,text_7specimen] = xlsread('input','7specimen');

[Data_5specimen,text_5specimen]=xlsread('input','5specimen');

[Data_2specimen,text_2specimen]=xlsread('input','2specimen');

[Data_2meter,text_2meter]=xlsread('input','2meter');

[Data_low_a_d,text_low_a_d]=xlsread('input','low_a_d');

% load OUTPUT_Divide_by1.mat

plotfname='10_Cross_V_V_ACI_Gaussian_Feat_20,13,24,26';
plotfnameRegression='size effect study';
plotmultiRegression='Multiregression-size effect study';
% number of resampling which was defined in other Scripts (the code in 
%which output was produced)

%%
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[20,13,24,26];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s)
                      % % 45=Av fy/(b S) (shear index)
classifier=3;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=42;%  24=deflectionRatio, 23=V   25=M  26=M/EI  27=M/bd^2  28=M/Asfy  29=V/GJ  30=V/bd 30=M/bd 32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=v/(2*sqrt(fc) bd+As fy d/s) v/shear strength
              % 46=Av fy d/s (N) (shear stregth of the steel)
              % 48=Moment through predicted shear M_(pho bd)
num_crossVali=10;    
              
% Performing num_crossVali fold Cross Validation

%%%%%%%%%the approproate function should be chosen here %%%%%%%%%%%%

% Cracks_120 data
[OUTPUT_120]=FeatureExtraction('Cracks_120');

% Cracks_95 data
[OUTPUT_95]=FeatureExtraction('Cracks_95');

% 7specimen data
[OUTPUT_7specimen]=FeatureExtraction('Cracks_7specimen');


[OUTPUT_5specimen]=FeatureExtraction('Cracks_5specimen');

[OUTPUT_2specimen]=FeatureExtraction('Cracks_2specimen');

[OUTPUT_2meter]=FeatureExtraction('Cracks_2meter');

[OUTPUT_low_a_d]=FeatureExtraction('Cracks_low_a_d');

    
for i=1:size(OUTPUT_120,1);
Faet_120(i,:)=OUTPUT_120{i,1};
end

for i=1:size(OUTPUT_95,1);
Faet_95(i,:)=OUTPUT_95{i,1};
end

for i=1:size(OUTPUT_7specimen,1);
Faet_7(i,:)=OUTPUT_7specimen{i,1};
end


for i=1:size(OUTPUT_5specimen,1);
Faet_5(i,:)=OUTPUT_5specimen{i,1};
end

for i=1:size(OUTPUT_2specimen,1);
Faet_2(i,:)=OUTPUT_2specimen{i,1};
end

for i=1:size(OUTPUT_2meter,1);
Faet_2meter(i,:)=OUTPUT_2meter{i,1};
end

for i=1:size(OUTPUT_low_a_d,1);
Faet_low_a_d(i,:)=OUTPUT_low_a_d{i,1};
end



% % all data sets 
X=[Faet_120(:,:),Data_120(1:end,3:26);Faet_95(:,:),Data_95(1:end,3:26);Faet_7(:,:),Data_7specimen(1:end,3:26);Faet_5(:,:),Data_5specimen(1:end,3:26);Faet_2(:,:),Data_2specimen(1:end,3:26);Faet_2meter(:,:),Data_2meter(1:end,3:26);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:26)];
Specimens_name=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];


feat_num = X(:,feat);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0); 

if testfeatNo==48
    class_num = X(:,42); 
else
    class_num = X(:,testfeatNo);    

end

    jj=1;
    
    
indices = crossvalind('Kfold',size(X,1),num_crossVali);
for k = 1:num_crossVali
    k
    test = (indices == k); train = ~test;
    

    
    feature_train = feat_num(train,:);
    class_train = class_num(train,1);
    

    feature_test = feat_num(test,:);
    class_test = class_num(test,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(indices == k,:) = actual_tmp;
    predictedClass(indices == k,:) = predicted_tmp;   
    

%     jj=jj+1;
%     ii=ii+3;
    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr_tmp 

end

%%

    if testfeatNo==48
        actualClass=actualClass.*X(:,48);
        predictedClass=predictedClass.*X(:,48);
    end
    
figure2=figure('Position', [100, 100, 1024, 1200]);
tvp=[mean(actualClass,2), nanmean(predictedClass,2)];

plotCorrelation_CI(tvp,plotfname,testfeatNo)





