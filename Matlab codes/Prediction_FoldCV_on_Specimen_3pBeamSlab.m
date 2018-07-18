
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
% beams w reinforcement
[Data_120,text_120] = xlsread('input_withrein','120Cracks');

[Data_95,text_95] = xlsread('input_withrein','95Cracks');

[Data_7specimen,text_7specimen] = xlsread('input_withrein','7specimen');

[Data_5specimen,text_5specimen]=xlsread('input_withrein','5specimen');

[Data_2specimen,text_2specimen]=xlsread('input_withrein','2specimen');

[Data_2meter,text_2meter]=xlsread('input_withrein','2meter');

[Data_low_a_d,text_low_a_d]=xlsread('input_withrein','low_a_d');

% beams w/o reinforcement
[Island_Data,text_Island] = xlsread('input_worein','all_ex_postcap_2'); %all_ex_postcap  all_ex_postcap_2 (5 more images/2 specimens were removed)
[Purdue_data,text_Purdue] = xlsread('input_worein','Purdu_ex_deep');

[PCA_data,text_PCA] = xlsread('input_worein','PCA');
% PCA_data = xlsread('input','PCA_ex_postcap');



[Toronto_Data,text_Toronto]=xlsread('input_worein','Toronto');

% [Toronto_4m_Data,text_Toronto_4m]=xlsread('input_worein','4mdeep');
[deep_Data,text_deep]=xlsread('input_worein','deep_2'); %'deep' includes 4-m and 2-m deep beam, but 'deem_2' includes just 2-m deep bemas

[Purdue2_Data,text_Purdue2]=xlsread('input_worein','Purdu_2');
[Haunched_Data,text_Haunched]=xlsread('input_worein','Haunched');
[Uniform_Data,text_Uniform]=xlsread('input_worein','Uniform');
% load OUTPUT_Divide_by1.mat

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




%   end
    
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

% % % %  % % % % % % % % % % % % % % % % 
[OUTPUT_Training]=FeatureExtraction_ex_postcap_BeamCropped_line('all');
% [OUTPUT_Crackshields]=Island_Scaled_segmented_ex_postcap_cropped_Skeltonized('all');


% Purdue data
% [OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line('all');
[OUTPUT_test]=FeatureExtraction_PurdeData_BeamCropped_line_ex_deep('all');


% PCA data
[OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line('all');
% [OUTPUT_PCA]=FeatureExtraction_PCA_BeamCropped_line_ex_postcap('all')


[OUTPUT_Toronto_4m]=FeatureExtraction_Toronto_4m('all');
% [OUTPUT_deep]=FeatureExtraction_deep('all');
[OUTPUT_deep]=FeatureExtraction_deep_2('all');  %'deep' includes 4-m and 2-m deep beam, but 'deep_2' includes just 2-m deep bemas

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

for i=1:size(OUTPUT_deep,1);
deep(i,:)=OUTPUT_deep{i,1};
end



for i=1:size(OUTPUT_Purdue2,1);
Purdue2(i,:)=OUTPUT_Purdue2{i,1};
end

for i=1:size(OUTPUT_Haunched,1);
haunched(i,:)=OUTPUT_Haunched{i,1};
end

for i=1:size(OUTPUT_Uniform,1);
uniform(i,:)=OUTPUT_Uniform{i,1};
end

%%
clear X1 X2 X tvp actualClass predictedClass tvp_stregth

plotfname='ultimate-LS-3pBeamSlab-V-SVM-Feat_20,13,21,50,51,52';
plotfnameRegression='size effect study';
plotmultiRegression='Multiregression-size effect study';
% number of resampling which was defined in other Scripts (the code in 
%which output was produced)

% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[20,13,21,50,51,52];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s) 50:(width)
                      % % 45=Av fy/(b S) (shear index) 51:a/h 52:h
classifier=4;  % classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SVM regression (broght it here from other code 'svmRegressioInMatlab.m')
                             %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR
                             
testfeatNo=25;%  24=deflectionRatio, 25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy   32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=v/(2*sqrt(fc) bd+As fy d/s) v/shear strength
              % 46=Av fy d/s (N) (shear stregth of the steel)
              % 48=Shear through predicted M (KN)
              % 49=Shear through predicted M/bd2 (KN)
              % 50=M through M/bd2
num_crossVali=10;   

% Performing num_crossVali fold Cross Validation

%%%%%%%%%the approproate function should be chosen here %%%%%%%%%%%%



% % all data sets 
% data sets without reinforcement
X1=[Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22)];
Specimens_name1=[text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1)];

X1_2=[Purdue_data(1:end,23:27);PCA_data(1:end,24:28);Toronto_Data(1:end,24:28);deep_Data(1:end,24:28);Purdue2_Data(1:end,23:27)];

% data sets with reinforcement
% X2=[Faet_120(:,:),Data_120(1:end,3:26);Faet_95(:,:),Data_95(1:end,3:26);Faet_7(:,:),Data_7specimen(1:end,3:26);Faet_5(:,:),Data_5specimen(1:end,3:26);Faet_2(:,:),Data_2specimen(1:end,3:26);Faet_2meter(:,:),Data_2meter(1:end,3:26);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:26)];
% Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];

X2=[Faet_120(:,:),Data_120(1:end,3:31);Faet_95(:,:),Data_95(1:end,3:31);Faet_7(:,:),Data_7specimen(1:end,3:31);Faet_5(:,:),Data_5specimen(1:end,3:31);Faet_2(:,:),Data_2specimen(1:end,3:31);Faet_2meter(:,:),Data_2meter(1:end,3:31);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:31)];
Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];




% adding 3 columns of zeros for features 45,46 and 47 for beam w/o shear
% % rein

X=[X1,zeros(length(X1),3),X1_2; X2];
Specimens_name=[Specimens_name1;Specimens_name2];
% 
% X=[X1,zeros(length(X1),3),X1_2];
% Specimens_name=[Specimens_name1];

% X=[X2];
% Specimens_name=[Specimens_name2];



feat_num = X(:,feat);

% rounding a/h and h for classification
feat51 = floor(X(:,51)) + ceil( (X(:,51)-floor(X(:,51)))/0.5) * 0.5; % rounding up to 0.5
feat52 = floor( floor(X(:,52))/50) * 50; % rounding to 20 mm

% feat_num=[X(:,feat),feat51,feat52];
% feat_num=[X(:,feat),feat51];
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

if testfeatNo==48
    class_num = X(:,27); 
    
elseif testfeatNo==49
     class_num = X(:,29); 
elseif testfeatNo==50
     class_num = X(:,29); 
else
        class_num = X(:,testfeatNo);    

end

    jj=1;
    
  
    
%  [un idx_last idx] = unique(Specimens_name);
% N = length(un);
% idx_unique = cell(1,N);
% for i = 1:N % for each unique element
%     idx_unique{i} = find(strcmp(Specimens_name,un(i))==1);
% end   
    


[un idx_last, idx] = unique(Specimens_name,'stable');
unique_idx = accumarray(idx(:),(1:length(idx))',[],@(x) {sort(x)});
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx=cell2mat(unique_idx);

indices = crossvalind('Kfold',size(unique_idx,1),num_crossVali);

for  k = 1:num_crossVali
   test=[];
    id=find(indices == k);
    for m=1:length(id)
        
        test=[test; unique_idx{id(m)}]
    end
%     train = unique_idx{(k~=indices)};
    train=Spec_idx(~ismember(Spec_idx,test));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    
    feature_train = feat_num(train,:);
    class_train = class_num(train,1);
    

    feature_test = feat_num(test,:);
    class_test = class_num(test,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass(ismember(Spec_idx,test),:) = actual_tmp;
    predictedClass(ismember(Spec_idx,test),:) = predicted_tmp;   


    

%     jj=jj+1;
%     ii=ii+3;
    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr_tmp 

end



    % to multiply predicted shear to span length to build moment
    if testfeatNo==48
        actualClass=actualClass./X(:,48);
        predictedClass=predictedClass./X(:,48);
    elseif testfeatNo==49
        actualClass=actualClass.*X(:,49)./X(:,48);
        predictedClass=predictedClass.*X(:,49)./X(:,48);
    elseif testfeatNo==50
        actualClass=actualClass.*X(:,49);
        predictedClass=predictedClass.*X(:,49);
    end
    
figure2=figure('Position', [100, 100, 1024, 1200]);
tvp=[mean(actualClass,2), nanmean(predictedClass,2)];



% % % to present just the ultimate load stafe, the last index for each spec

ultimate_LS=[idx_last(2:end)-1;length(Spec_idx)];
tvp=tvp(ultimate_LS,:);
%presenting data in %100
% tvp=100*tvp;

% % to find statistical parameters for Volume<0.5
% indices1 = find(tvp(:,1)>0.5);
% tvp(indices1,:) = [];

% plotCorrelation_histogram3D(tvp,plotfname,tol)

% plotCorrelation_all(tvp,plotfname,testfeatNo)

plotCorrelation_CI(tvp,plotfname,testfeatNo)

%  figure3=figure('Position', [100, 100, 1024, 1200]);

% Xaxis=23;Yaxis=42;curveaxis=26; %13 15
% plotRegression(X,plotfnameRegression,Xaxis,Yaxis,curveaxis)
%  ylabel('Scaled shear $$(V/(2\sqrt{f_c}~bd)$$','fontsize',17,'FontName','Helvetica','Interpreter','latex'); 
%  xlabel('Moment of inertia about x axis','fontsize',16,'FontName','Helvetica','Interpreter','text'); 

%   ylabel('Scaled shear force','fontsize',17);  
%   xlabel('Average distance between cracks ','fontsize',17);

% figure4=figure('Position', [100, 100, 1024, 1200]);
% plotname='regression-lessfeatures-_all-exuiform-deep-FractureRatio-all depth';

% plotname='regression-all data sets-d lower 20 in-fractureratio';

% Zaxis=43;Xaxis=13;Yaxis=3; %Zaxis=40;Xaxis=13;Yaxis=5;
% plotMultipleregression(X,plotmultiRegression,Xaxis,Yaxis,Zaxis,plotname)


% figure4=figure('Position', [100, 100, 1024, 1200]);
% 
% % plot the regression line vs tru line
% Xcurve=X(:,Xaxis); Ycurve=X(:,Yaxis);
% % removeid=find(Ycurve>0.98);
% % Ycurve(removeid)=[];
% % Xcurve(removeid)=[];
% RegressionEQ=2.8876e-12*Xcurve.^3-5.4306e-08*Xcurve.^2+0.00031.*Xcurve+0.28;
% 
% tvr=[Ycurve, RegressionEQ];
% Plot_No=1;
% plotfregression='regressioin_feature13_includingultimatepointNEW';
% plotCorrelation_regressionfit(tvr,plotfregression,Plot_No)

% figure
% plot(Ycurve,RegressionEQ,'*')
% xlim([0 2]);
% ylim([0 2]);
%%
figure3=figure('Position', [100, 100, 1024, 1200]);

[tvp_stregth]=xlsread('input_worein','D4');
% 
plotCorrelation_CI(tvp_stregth,'3pBeamSlab-shear strength by ACI_withoutslab',1)

