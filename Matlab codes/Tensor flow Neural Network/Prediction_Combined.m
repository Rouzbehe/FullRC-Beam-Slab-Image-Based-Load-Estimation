
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

[Data] = xlsread('Shear_strength_database','beam_wo_rein');% beam_wo_rein_Pload


% load OUTPUT_Divide_by1.mat

plotfname='Tensorflow-20-10-5-layers_L1-LearnRate-1-Feat_4T13';
plotfnameRegression='size effect study';
plotmultiRegression='Multiregression-size effect study';
% number of resampling which was defined in other Scripts (the code in 
%which output was produced)

%%
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[4:13];  % 4:B_W 5:B 6:h 7:d 8:a 9:a_g  10:f_y 11:a/d 12:rho 13:f'c 

classifier=9;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=14;%              % 14: true shear strenght (KN) 15: ACI 16:CSA

num_crossVali=10;    
              
% Performing num_crossVali fold Cross Validation

%%%%%%%%%the approproate function should be chosen here %%%%%%%%%%%%

% Cracks_120 data




%   end

%
X=[Data];

feat_num0 = X(:,feat);
feat_num=zscore(feat_num0);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0); 

class_num = X(:,testfeatNo);

% linear mapping of the data to -1 to +1 range

% class_num=zscore(class_num);
Max=max(class_num(:)); Min=min(class_num(:));
class_num=-1+2*(class_num-Min)/(Max-Min);
    jj=1;
    
    
indices = crossvalind('Kfold',size(X,1),num_crossVali);
for k = 1:num_crossVali
    k
    test = (indices == k); train = ~test;
    

    
%     Zfeature_train = zscore(feat_num(train,:));
%     Zclass_train = zscore(class_num(train,1));
%     
% 
%     Zfeature_test = zscore(feat_num(test,:));
%     Zclass_test = zscore(class_num(test,1));

    Zfeature_train = feat_num(train,:);
    Zclass_train = class_num(train,1);
    

    Zfeature_test=feat_num(test,:);
    Zclass_test = class_num(test,1);
   
%     class_test = class_num(test,1);

    
    net = NeuralNet2([size(feat_num,2) 20 10 5 size(class_num,2)]); % 20 10 best for point load
    net.LearningRate = 1; % 0.5 best for point-load database
    net.RegularizationType = 'L1'; % L1 best for point-load database
    net.RegularizationRate = 0.01; % 0 or 0.01 best for point load
%     net.ActivationFunction = 'relu';
    net.BatchSize =2000;  % 2000 or any value more than 500 best for point load
    display(net)

%% Training and Testing Network

N = 5000;  % number of iterations
disp('Training...'); tic
costVal = net.train(Zfeature_train, Zclass_train, N);
toc

% compute predictions
disp('Test...'); tic
% predictTrain = net.sim(feature_train);
ZpredictTest = net.sim(Zfeature_test);
 
% convert Zscored value to real values
% predictTest=ZpredictTest*std(class_test(:))+mean(class_test(:));
% predictTest=ZpredictTest*std( X(:,testfeatNo))+mean( X(:,testfeatNo));
% class_test=Zclass_test*std( X(:,testfeatNo))+mean( X(:,testfeatNo));






    %performing regression
%     [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(indices == k,:) = Zclass_test;
    predictedClass(indices == k,:) = ZpredictTest;   



%     jj=jj+1;
%     ii=ii+3;
    clear feature_train class_train feature_test class_test
    clear net

end

%%

% plotfname='Tensorflow-20-10-layers_L1-LearnRate-05-Feat_4T13';

% changing back the mapped data
actualClass=(actualClass+1)*(Max-Min)/2+Min;
predictedClass=(predictedClass+1)*(Max-Min)/2+Min;    
    
figure1=figure('Position', [100, 100, 1024, 1200]);
tvp=[mean(actualClass,2), nanmean(predictedClass,2)];

%presenting data in %100
% tvp=100*tvp;

% % to find statistical parameters for Volume<0.5
% indices1 = find(tvp(:,1)>0.5);
% tvp(indices1,:) = [];

% plotCorrelation_histogram3D(tvp,plotfname,tol)

% plotCorrelation_all(tvp,plotfname,testfeatNo)

plotCorrelation_CI(tvp,plotfname,testfeatNo)



figure2=figure('Position', [100, 100, 1024, 1200]);
plotfname_aci='Shear strength estimation by ACI';

tvp_aci=[X(:,testfeatNo),X(:,15)]
plotCorrelation_CI(tvp_aci,plotfname_aci,15)

figure3=figure('Position', [100, 100, 1024, 1200]);
plotfname_csa='Shear strength estimation by CSA';

tvp_csa=[X(:,testfeatNo),X(:,16)]
plotCorrelation_CI(tvp_csa,plotfname_csa,16)

% figure3=figure('Position', [100, 100, 1024, 1200]);
% 
% Xaxis=40;Yaxis=41;curveaxis=22; %13 15
% plotRegression(X,plotfnameRegression,Xaxis,Yaxis,curveaxis)
%   xlabel('V/V_{ACI} ','fontsize',17);
%   ylabel('Fracture Ratio','fontsize',17);  
% 
% % figure4=figure('Position', [100, 100, 1024, 1200]);
% 
% Zaxis=41;Xaxis=13;Yaxis=21; %Zaxis=40;Xaxis=13;Yaxis=5;
% plotMultipleregression(X,plotmultiRegression,Xaxis,Yaxis,Zaxis)




