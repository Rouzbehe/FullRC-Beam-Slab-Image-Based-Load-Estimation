
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

%%
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

[Toronto_4m_Data,text_Toronto_4m]=xlsread('input_worein','4mdeep');

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
clear X1 X2 X tvp actualClass predictedClass tvp_stregth test idx idx1 idx2 actualClass1 actualClass2 predictedClass1 predictedClass2 finalactual finalpredicted

plotfname='classReg/2Class-Multi-1T23,51round_Reg-SVM_case49_20,13,21,50,51,52';

% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[1:23];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s)
                      % % 45=Av fy/(b S) (shear index)
classifier=6;  % classifier     1=Random forrest 2=J48 
                             %   3=SVM 4=logistic 5=Neighbor 6=Multi
                             %   7=RepTree 8=ZeroR 9=Gaussian Process
                             % 9 and 10 don;t work for classification
                             
Regclassifier=4 %  Regression classifier     1=Support Vector Regression 2=Nearest Neighbor Regression 
                             %   3=Gaussian Process Regression 4=SOM regression (broght it here from other code 'svmRegressioInMatlab.m')
                            %   5=Linear Rgression    6=MultilayerPerceptron    7=REPTree   8=ZeroR

feat_Reg=[20,13,21,50,51,52];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s) 50:(width)
                      % % 45=Av fy/(b S) (shear index)testfeatNo=44;%   25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy  29=V/GJ  32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)

testfeatNo=49;%  24=deflectionRatio, 25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy   32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 38=M/a^2bh 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=v/(2*sqrt(fc) bd+As fy d/s) v/shear strength
              % 46=Av fy d/s (N) (shear stregth of the steel)
              
              % 48=Shear through predicted M (KN) $$ direct V
              % 49=Shear through predicted M/bd2 (KN)  $$  direct V
              % 50=M through M/bd2  $$  M through V        
              
% Performing num_crossVali fold Cross Validation
num_crossVali=10;    




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
% rein
X=[X1,zeros(length(X1),3),X1_2; X2];
Specimens_name=[Specimens_name1;Specimens_name2];




feat_num=[X(:,feat),round(X(:,51))]; % just rounded a/h values added for classification to avoide overfitting
feat_num=zscore(feat_num);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

% if testfeatNo==48
%     class_num = X(:,42); 
% else
     class_num = X(:,testfeatNo);    
     binary_calss=X(:,47); % 0 and 1 for without and with shear rein
% end

   class_nom=cell(size(binary_calss))

% converting to nominal variables (Weka cannot classify numerical variables)    
 for kk=1:length(binary_calss);
   if binary_calss(kk)==0;
     class_nom(kk)={'without_rein'};
   else
    class_nom(kk)={'with_rein'};
   end
 end
    
%  [un idx_last idx] = unique(Specimens_name);
% N = length(un);
% idx_unique = cell(1,N);
% for i = 1:N % for each unique element
%     idx_unique{i} = find(strcmp(Specimens_name,un(i))==1);
% end   
    


[un idx_last idx] = unique(Specimens_name,'stable');
unique_idx = accumarray(idx(:),(1:length(idx))',[],@(x) {sort(x)});
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx=cell2mat(unique_idx);

indices = crossvalind('Kfold',size(unique_idx,1),num_crossVali);

% to find the ultimate load stage and corrosponding shear values 
% (to compare with ACI nominal strength in the papaer)

ultimate_LS=[idx_last(2:end)-1;length(Spec_idx)];
ultimate_shear=X(ultimate_LS,25);


for  k = 1:num_crossVali
   test=[];
    id=find(indices == k);
    for m=1:length(id)
        
        test=[test; unique_idx{id(m)}];
    end
%     train = unique_idx{(k~=indices)};
    train=Spec_idx(~ismember(Spec_idx,test));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    
    feature_train = feat_num(train,:);
    class_train = class_nom(train,1);
    

    feature_test = feat_num(test,:);
    class_test = class_nom(test,1);
   
    %performing regression
%     [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train, class_train, feature_test, class_test, featName, classifier);
    [actual_tmp, predicted_tmp, probDistr]=wekaClassification(feature_train, class_train, feature_test, class_test, featName, classifier);

    %accumulating the results
    actualClass(ismember(Spec_idx,test),:) = actual_tmp;
    predictedClass(ismember(Spec_idx,test),:) = predicted_tmp;   
    probability(ismember(Spec_idx,test),:) = probDistr; 

    clear feature_train class_train feature_test class_test
    clear actual_tmp predicted_tmp probDistr 

end

AcuracyTest=sum(strcmp(actualClass,predictedClass))/length(predictedClass)*100 

feat_num_Reg = X(:,feat_Reg);
% feat_num=zscore(feat_num);
featName_Reg = arrayfun(@num2str, [1:1:length(feat_num_Reg(1,:))], 'unif', 0);   


if testfeatNo==48
    class_num = X(:,25); 
    
elseif testfeatNo==49
     class_num = X(:,25); 
elseif testfeatNo==50
     class_num = X(:,25); 
else
        class_num = X(:,testfeatNo);    

end



without_rein_id=strmatch('without_rein', predictedClass, 'exact')
pre_without_name=Specimens_name(without_rein_id)
feat_num1=feat_num_Reg(without_rein_id,:)
class_num1=class_num(without_rein_id,1)

[un idx_last1 idx1] = unique(pre_without_name,'stable');
unique_idx1 = accumarray(idx1(:),(1:length(idx1))',[],@(x) {sort(x)});
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx1=cell2mat(unique_idx1);

indices1 = crossvalind('Kfold',size(unique_idx1,1),num_crossVali);

for  k = 1:num_crossVali
   test1=[];
    id1=find(indices1 == k);
    for m=1:length(id1)
        
        test1=[test1; unique_idx1{id1(m)}]
    end
%     train = unique_idx{(k~=indices)};
    train1=Spec_idx1(~ismember(Spec_idx1,test1));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    
    feature_train1 = feat_num1(train1,:);
    class_train1 = class_num1(train1,1);
    

    feature_test1 = feat_num1(test1,:);
    class_test1 = class_num1(test1,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train1, class_train1, feature_test1, class_test1, featName_Reg, Regclassifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass1(ismember(Spec_idx1,test1),:) = actual_tmp;
    predictedClass1(ismember(Spec_idx1,test1),:) = predicted_tmp;   


    

%     jj=jj+1;
%     ii=ii+3;
    clear feature_train1 class_train1 feature_test1 class_test1
    clear actual_tmp predicted_tmp probDistr_tmp 

end

    if testfeatNo==50
        actualClass1=actualClass1.*X(without_rein_id,48);
        predictedClass1=predictedClass1.*X(without_rein_id,48);
    end



if testfeatNo==48
    class_num = X(:,27); 
    
elseif testfeatNo==49
     class_num = X(:,29); 
elseif testfeatNo==50
     class_num = X(:,29); 
else
        class_num = X(:,testfeatNo);    

end



with_rein_id=strmatch('with_rein', predictedClass, 'exact')
pre_with_name=Specimens_name(with_rein_id)
feat_num2=feat_num_Reg(with_rein_id,:)
class_num2=class_num(with_rein_id,1)

[un idx_last2 idx2] = unique(pre_with_name,'stable');
unique_idx2 = accumarray(idx2(:),(1:length(idx2))',[],@(x) {sort(x)});
% indices = crossvalind('Kfold',size(X,1),num_crossVali);

Spec_idx2=cell2mat(unique_idx2);

indices2 = crossvalind('Kfold',size(unique_idx2,1),num_crossVali);

for  k = 1:num_crossVali
   test2=[];
    id2=find(indices2 == k);
    for m=1:length(id2)
        
        test2=[test2; unique_idx2{id2(m)}]
    end
%     train = unique_idx{(k~=indices)};
    train2=Spec_idx2(~ismember(Spec_idx2,test2));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    feature_train2 = feat_num2(train2,:);
    class_train2 = class_num2(train2,1);
    

    feature_test2 = feat_num2(test2,:);
    class_test2 = class_num2(test2,1);
   

    %performing regression
    [actual_tmp, predicted_tmp, stdDev_tmp] = wekaRegression(feature_train2, class_train2, feature_test2, class_test2, featName_Reg, Regclassifier);
%     selectedAttr(jj,kk)=wekaFeatureSelection(feature_train, feature_test, class_train, class_test, featName, 1);

    %accumulating the results
    actualClass2(ismember(Spec_idx2,test2),:) = actual_tmp;
    predictedClass2(ismember(Spec_idx2,test2),:) = predicted_tmp;   


    

%     jj=jj+1;
%     ii=ii+3;
    clear feature_train2 class_train2 feature_test2 class_test2
    clear actual_tmp predicted_tmp probDistr_tmp 

end

    if testfeatNo==48
        actualClass2=actualClass2./X(with_rein_id,48);
        predictedClass2=predictedClass2./X(with_rein_id,48);
    elseif testfeatNo==49
        actualClass2=actualClass2.*X(with_rein_id,49)./X(with_rein_id,48);
        predictedClass2=predictedClass2.*X(with_rein_id,49)./X(with_rein_id,48);
    elseif testfeatNo==50
        actualClass2=actualClass2.*X(with_rein_id,49);
        predictedClass2=predictedClass2.*X(with_rein_id,49);
    end

finalactual=[actualClass1;actualClass2]
finalpredicted=[predictedClass1;predictedClass2];

    % to multiply predicted shear to span length to build moment

tvp=[mean(finalactual,2), nanmean(finalpredicted,2)];



% % % to present just the ultimate load stafe, the last index for each spec
% ultimate_LS1=[idx_last1(2:end)-1;length(Spec_idx1)];ultimate_LS2=[idx_last2(2:end)-1;length(Spec_idx2)];
% tvp=tvp([ultimate_LS1;ultimate_LS2],:);  
%%
 plotfname='classReg/2ultimate-LS-Class-Multi-1T23,51round_Reg-SVM_case49_20,13,21,50,51,52';

[C,ia,ib] = intersect(ultimate_shear,finalactual) ;    
 tvp=tvp(ib,:);  
    
figure2=figure('Position', [100, 100, 1024, 1200]);


%presenting data in %100
% tvp=100*tvp;

% % to find statistical parameters for Volume<0.5
% indices1 = find(tvp(:,1)>0.5);
% tvp(indices1,:) = [];

% plotCorrelation_histogram3D(tvp,plotfname,tol)

% plotCorrelation_all(tvp,plotfname,testfeatNo)

plotCorrelation_CI(tvp,plotfname,testfeatNo)



