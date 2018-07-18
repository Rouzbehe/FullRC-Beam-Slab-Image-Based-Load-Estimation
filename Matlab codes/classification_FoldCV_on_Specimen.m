
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
[deep_Data,text_deep]=xlsread('input_worein','deep');

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

%%
clear X1 X2 X tvp actualClass predictedClass tvp_stregth test feat_num
plotfname='class_Nov_6/Random forrest-Feat-zscored1T23';
plotfnameRegression='size effect study';
plotmultiRegression='Multiregression-size effect study';
% number of resampling which was defined in other Scripts (the code in 
%which output was produced)

% featName = {'Compactness','Aspect Ratio', 'ThreshOut','Entropy', 'Contrast','Correlation','Energy','Homegenity','Variance','Area' ,'Perimeter','EulerNumber','Standard Deviation'};
feat=[1:23];   % 1:20 same as before. 21:No of cracks,22: total distance between cracks 23:ave distance 24:(a/d) 26:(d) 45:shear index 47:(d/s) 50:(width)
                      % % 45=Av fy/(b S) (shear index)
classifier=2;  % classifier     1=Random forrest 2=J48 
                             %   3=SVM 4=logistic 5=Neighbor 6=Multi
                             %   7=RepTree 8=ZeroR 9=Gaussian Process
                             % 9 and 10 don't work for classification
                             
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



% % all data sets 
% data sets without reinforcement
X1=[Island_crack(:,:),Island_Data(1:end,3:23);Purdue_crack(:,:),Purdue_data(1:end,2:22);PCA_crack(:,:),PCA_data(1:end,3:23);Toronto_crack(:,:),Toronto_Data(1:end,3:23);deep(:,:),deep_Data(1:end,3:23);Purdue2(:,:),Purdue2_Data(1:end,2:22);haunched(:,:),Haunched_Data(1:end,3:23); uniform(:,:),Uniform_Data(1:end,3:23)];
Specimens_name1=[text_Island(2:end,1);text_Purdue(2:end,1);text_PCA(2:end,1);text_Toronto(2:end,1);text_deep(2:end,1);text_Purdue2(2:end,1);text_Haunched(2:end,1);text_Uniform(2:end,1)];

X1_2=[Island_Data(1:end,24:28);Purdue_data(1:end,23:27);PCA_data(1:end,24:28);Toronto_Data(1:end,24:28);deep_Data(1:end,24:28);Purdue2_Data(1:end,23:27);Haunched_Data(1:end,24:28); Uniform_Data(1:end,24:28)];

% data sets with reinforcement
% X2=[Faet_120(:,:),Data_120(1:end,3:26);Faet_95(:,:),Data_95(1:end,3:26);Faet_7(:,:),Data_7specimen(1:end,3:26);Faet_5(:,:),Data_5specimen(1:end,3:26);Faet_2(:,:),Data_2specimen(1:end,3:26);Faet_2meter(:,:),Data_2meter(1:end,3:26);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:26)];
% Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];

X2=[Faet_120(:,:),Data_120(1:end,3:31);Faet_95(:,:),Data_95(1:end,3:31);Faet_7(:,:),Data_7specimen(1:end,3:31);Faet_5(:,:),Data_5specimen(1:end,3:31);Faet_2(:,:),Data_2specimen(1:end,3:31);Faet_2meter(:,:),Data_2meter(1:end,3:31);Faet_low_a_d(:,:),Data_low_a_d(1:end,3:31)];
Specimens_name2=[text_120(2:end,1);text_95(2:end,1);text_7specimen(2:end,1);text_5specimen(2:end,1);text_2specimen(2:end,1);text_2meter(2:end,1);text_low_a_d(2:end,1)];




% adding 3 columns of zeros for features 45,46 and 47 for beam w/o shear
% rein
X=[X1,zeros(length(X1),3),X1_2; X2];
Specimens_name=[Specimens_name1;Specimens_name2];


feat_num = X(:,feat);

% rounding a/h and h for classification
% feat_num=[X(:,feat),round(X(:,[51]))];
% feat_num=[round(X(:,[51,52]))];
% feat_num=[round(X(:,[52]))];
feat_num=zscore(feat_num);

% feat_num=zscore(feat_num);
featName = arrayfun(@num2str, [1:1:length(feat_num(1,:))], 'unif', 0);   

% if testfeatNo==48
%     class_num = X(:,42); 
% else
     class_num = X(:,testfeatNo);    
% 
% end

   class_nom=cell(size(class_num))

% converting to nominal variables (Weka cannot classify numerical variables)    
 for kk=1:length(class_num);
   if class_num(kk)==0;
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

AcuracyTest=sum(strcmp(actualClass,predictedClass))/length(predictedClass)*100 ;
AccuracyX1=sum(strcmp(actualClass(1:length(X1)),predictedClass(1:length(X1))))/length(predictedClass(1:length(X1)))*100 ;
AccuracyX2=sum(strcmp(actualClass(length(X1)+1:end),predictedClass(length(X1)+1:end)))/length(predictedClass(length(X1)+1:end))*100 ;

% 
% figure (13)
% 
 Y=[AccuracyX1;AccuracyX2;AcuracyTest]
 err=[100*std(probability(1:length(X1),1)),100*std(probability(length(X1)+1:end,2)),0]
figure 
fH = gcf; colormap(jet(3));
h = bar(diag(Y),'stack');
ylabel('classification accuracy (%)')
ybuff=3;
for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        if i==j
        x=XDATA(1,j)-(XDATA(3,j)-XDATA(1,j))/80;
        x2=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/1.35;
        y=YDATA(2,j)+ybuff;
        t=['',num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',0)
%         if j<=2
%         t_error=['SD=',num2str(err(j),3), '%' ];
%         text(x2,y,t_error,'Color','k','HorizontalAlignment','left','Rotation',90) 
%         end
        end

    end
end

l = cell(1,3);
l{3}='Prediction accuracy for classifying specimens with and without reinforcement'; l{1}='Accuracy of the model to classify specimens without reinforcement'; l{2}='Accuracy of the model to classify specimens with reinforcement'; 
legend(h,l,'Location','NorthOutside');

ylim([0 120])
applyhatch_pluscolor(fH,'/\c', 0, [0 1 0], jet(3))

print(plotfname,'-dpng', '-r1500');

figure;
figure2=figure('Position', [100, 100, 1024, 1200]);

tot_op = probability(:,1);
targets = strcmp(actualClass,'without_rein');
th_vals= sort(tot_op);

for i = 1:length(th_vals)
  b_pred = (tot_op>=th_vals(i,1));
  TP = sum(b_pred == 1 & targets == 1);
  FP = sum(b_pred == 1 & targets == 0);
  TN = sum(b_pred == 0 & targets == 0);
  FN = sum(b_pred == 0 & targets == 1);
  sens(i) = TP/(TP+FN);
  spec(i) = TN/(TN+FP);
end


cspec1 = 1-spec;
cspec1 = cspec1(end:-1:1);
sens1 = sens(end:-1:1);

tot_op = probability(:,2);
targets = strcmp(actualClass,'with_rein');
th_vals= sort(tot_op);

for i = 1:length(th_vals)
  b_pred = (tot_op>=th_vals(i,1));
  TP = sum(b_pred == 1 & targets == 1);
  FP = sum(b_pred == 1 & targets == 0);
  TN = sum(b_pred == 0 & targets == 0);
  FN = sum(b_pred == 0 & targets == 1);
  sens(i) = TP/(TP+FN);
  spec(i) = TN/(TN+FP);
  accu(i)=(TP+TN)/(TP+FP+TN+FN);
end


cspec2 = 1-spec;
cspec2 = cspec2(end:-1:1);
sens2 = sens(end:-1:1);


plot(cspec1,sens1,'r','LineWidth',1.3);
hold on
plot(cspec2,sens2,'--b','LineWidth',1.5);

  xlabel('False Positive Rate (1 - Specificity)','fontsize',17);
  ylabel('True Positive Rate (Sensitivity)','fontsize',17);
  
AUC1 = sum(0.5*(sens1(2:end)+sens1(1:end-1)).*(cspec1(2:end) - cspec1(1:end-1)));
AUC2 = sum(0.5*(sens2(2:end)+sens2(1:end-1)).*(cspec2(2:end) - cspec2(1:end-1)));

    LEG=legend(['Class 1 (Shear critical), AUC=' num2str(AUC1)],['Class 2 (Shear reinforced), AUC=' num2str(AUC2)],'Location','best');
  set(LEG,'fontsize',17);
set(gca,'fontsize',17)

% fprintf('\nAUC: %g \n',AUC);
print(plotfname,'-dpdf', '-r2500');

figure ;
figure2=figure('Position', [100, 100, 1024, 1200]);


% [n1,ctr1] = hist(accu,20);
[b1,m1,n1] = unique(th_vals);
th_vals = th_vals(m1);accu = accu(m1);
bar(th_vals,accu,0.5);
  xlabel('Threshhold','fontsize',17);
  ylabel('Accuracy (%)','fontsize',17);

 [Y,I]=sort(accu); 
 idxx=I(end);
    LEG=legend(['Maximum Accuracy=' num2str(accu(idxx)),' at Optimal Threshhold=' num2str(th_vals(idxx)), ],'Location','best');
  
set(gca,'fontsize',17)  
set(LEG,'fontsize',17);
grid ON
print(plotfname,'-djpeg', '-r1500');

