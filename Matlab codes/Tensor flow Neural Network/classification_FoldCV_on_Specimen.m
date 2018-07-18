
clear all; close all;clc;
tic
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
[Island_Data,text_Island] = xlsread('input_worein','all_ex_postcap');
[Purdue_data,text_Purdue] = xlsread('input_worein','Purdu_ex_deep');

[PCA_data,text_PCA] = xlsread('input_worein','PCA');
% PCA_data = xlsread('input','PCA_ex_postcap');



[Toronto_Data,text_Toronto]=xlsread('input_worein','Toronto');

[Toronto_4m_Data,text_Toronto_4m]=xlsread('input_worein','4mdeep');
[deep_Data,text_deep]=xlsread('input_worein','deep');

[Purdue2_Data,text_Purdue2]=xlsread('input_worein','Purdu_2');
[Haunched_Data,text_Haunched]=xlsread('input_worein','Haunched');
[Uniform_Data,text_Uniform]=xlsread('input_worein','Uniform');
% load OUTPUT_Divide_by1.mat

plotfname='March_8_10CV_on_specimen-level-classification/L2-sigmoid-learRate-15-layers-35-10-5-TensorflowNN_1T23';
plotfnameRegression='size effect study';
plotmultiRegression='Multiregression-size effect study';
% number of resampling which was defined in other Scripts (the code in 
%which output was produced)

%%
% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[1:23];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s)
                      % % 45=Av fy/(b S) (shear index)
classifier=10;  % classifier     1=Random forrest 2=J48 
                             %   3=SVM 4=logistic 5=Neighbor 6=Multi
                             %   7=RepTree 8=ZeroR 9=Gaussian Process
                             % 9 and 10 don;t work for classification
                             
testfeatNo=47;%   25=V   27=M  28=M/EI  29 =M/bd2 30=M/Asfy  29=V/GJ  32=M/bh 33=M/bhl 34=M/bdl 35=M/fcbhl 36=M/bh(l-a) or M/bh(l/2)
              % 37=M/abh(l-a) or M/abh(l/2) 40=M/(pho EI) 41=M/(pho bd)
              % 42=V/(2*sqrt(fc) bd) or V_V_ACI    43=FailureRatio
              % 44=v/(2*sqrt(fc) bd+As fy d/s) v/shear strength
              % 46=Av fy d/s (N) (shear stregth of the steel)
             % (45, 46 and 47 features are zero for data sets w/o shear
             % reinfprcement)
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
[OUTPUT_deep]=FeatureExtraction_deep('all');

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

% % all data sets 
% data sets without reinforcement
X1=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
Specimens_name1=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

% data sets with reinforcement
X2=[Faet_120(:,:),Data_120(1:end,3:26);Faet_95(:,:),Data_95(1:end,3:26);Faet_7(:,:),Data_7specimen(1:end,3:26);Faet_5(:,:),Data_5specimen(1:end,3:26);Faet_2(:,:),Data_2specimen(1:end,3:26);Faet_2meter(:,:),Data_2meter(1:end,3:26);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:26)];
Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];

% adding 3 columns of zeros for features 45,46 and 47 for beam w/o shear
% rein
X=[X1,zeros(length(X1),3);X2];
Specimens_name=[Specimens_name1;Specimens_name2];

feat_num0 = X(:,feat);
feat_num=zscore(feat_num0);

featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

if testfeatNo==48
    class_num = X(:,42); 
else
    class_num = X(:,testfeatNo);    

end

%    class_nom=cell(size(class_num))

% converting to nominal variables (Weka cannot classify numerical variables)    
 for kk=1:length(class_num);
   if class_num(kk)==0;
     class_nom(kk,1)=-1;
   else
    class_nom(kk,1)=1;
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

for  k = 1:num_crossVali
    k
   test=[];
    id=find(indices == k);
    for m=1:length(id)
        
        test=[test; unique_idx{id(m)}];
    end
%     train = unique_idx{(k~=indices)};
    train=Spec_idx(~ismember(Spec_idx,test));
%     train = Spec_idx(~(Spec_idx==unique_idx{k}));
    

    

   

    Zfeature_train = feat_num(train,:);
    Zclass_train = class_nom(train,1);
    

    Zfeature_test=feat_num(test,:);
    Zclass_test = class_nom(test,1);
   
%     class_test = class_num(test,1);

    
    net = NeuralNet2([size(feat_num,2) 35 10 5 size(class_num,2)]); % 20 10 best for point load
    net.LearningRate = 1.5; % 0.5 best for point-load database
     net.RegularizationType = 'L2'; % L1 best for point-load database
    net.RegularizationRate = 0.01; % 0 or 0.01 best for point load
    net.ActivationFunction = 'sigmoid';
    net.BatchSize =1000;  % 2000 or any value more than 500 best for point load
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
    actualClass(ismember(Spec_idx,test),:) = Zclass_test;
    predictedClass(ismember(Spec_idx,test),:) = ZpredictTest;   


%     jj=jj+1;
%     ii=ii+3;
    clear feature_train class_train feature_test class_test Zclass_test ZpredictTest
    clear net

end


%%
 CellactualClass=cell(size(class_num,1),1);
 CellpredictedClass=cell(size(class_num,1),1);

 for kk=1:length(actualClass);
     
   if actualClass(kk)<=0;
     CellactualClass(kk)={'withour_rein'};
   else
     CellactualClass(kk)={'with_rein'};
   end
   
   if predictedClass(kk)<=0;
     CellpredictedClass(kk)={'withour_rein'};
   else
     CellpredictedClass(kk)={'with_rein'};
   end
   
 end
 
AcuracyTest=sum(strcmp(CellactualClass,CellpredictedClass))/length(CellpredictedClass)*100 ;

mean(AcuracyTest)

% 
% figure (13)
% 
 Y=[mean(AcuracyTest)];

%  Y=[100*mean(probability(1:length(X1),1));100*mean(probability(length(X1)+1:end,2));mean(AcuracyTest)]
%  err=[100*std(probability(1:length(X1),1)),100*std(probability(length(X1)+1:end,2)),0]
 h=bar(Y);
% ylabel('classification accuracy (%)')
ybuff=2;
for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3) ,'%'];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
ylim([0 100])

% figure 
% fH = gcf; colormap(jet(3));
% %  Labels = {'Beams w and w/o reinforcement', 'Dat', 'IA'};
% % set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
% % Y=repmat(Y,[1,3])
% h = bar(diag(Y),'stack');
% h=bar(Y);
ylabel('classification accuracy (%)')
% 
% ybuff=3;
% for i=1:length(h)
%     XDATA=get(get(h(i),'Children'),'XData');
%     YDATA=get(get(h(i),'Children'),'YData');
%     for j=1:size(XDATA,2)
%         if i==j
%         x=XDATA(1,j)-(XDATA(3,j)-XDATA(1,j))/80;
%         x2=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/1.35;
%         y=YDATA(2,j)+ybuff;
%         t=['',num2str(YDATA(2,j),3), '%' ];
%         text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',0)
%         if j<=2
%         t_error=['SD=',num2str(err(j),3), '%' ];
%         text(x2,y,t_error,'Color','k','HorizontalAlignment','left','Rotation',90) 
%         end
%         end
% 
%     end
% end
% 
%   hold all
% 
%     hh = errorbar(Y(3), err(3))
% % hh=errorbar(Y, err,L,L,'oy');
% set(hh,'linestyle','none','linewidth',30) 
%   hold all
% 
%     hh = errorbar(Y(1:2), err(1:2))
% % hh=errorbar(Y, err,L,L,'oy');
% set(hh,'linestyle','none','linewidth',30) 
% %     set(hh,'linestyle','none')
% % legend('Specimens with and without reinforcement','Specimens without reinforcement','Specimens with reinforcement','Location','NorthOutside')
% %  set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
% l = cell(1,3);
% l{3}='Prediction accuracy for classifying specimens with and without reinforcement'; l{1}='Prediction probability of the model to classify specimens without reinforcement'; l{2}='Prediction probability of the model to classify specimens with reinforcement'; 
% legend(h,l,'Location','NorthOutside');
% 
% ylim([0 120])
% applyhatch_pluscolor(fH,'/\c', 0, [0 1 0], jet(3))



% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print(plotfname,'-dpdf', '-r2500');
print(plotfname,'-dpng', '-r1500');

toc




