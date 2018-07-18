clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];

data = 100*[ 0.74  , .80  , 0.77  ,  0.8  ;0.92    , 0.91  , 0.83  ,  0.8   ];



fH = gcf; colormap(jet(4));
Labels = {'All crack features', 'All crack features, a/d, d'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('J48','Random forrest','SVM','Logistic','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_class','-dpng', '-r1000');

%% Data Set 2
clear all,clc
close all
% data Set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[ 0.14 , 0.14 ,0.15  , 0.14 ;  0.84 ,0.85  , 0.82 , 0.84 ; 0.91 , 0.92 ,0.9 , 0.91 ; 0.7 ,0.72  ,0.66  , 0.7 ];

 data = 100*[ 0.14  , 0.15  , 0.13  ,  0.17 ,0.15 ;0.85    ,  0.88 ,0.9   ,  0.8  ,0.85; 0.92  , 0.93 ,0.95   , 0.89 ,0.92 ;  0.72  , 0.77   , 0.81   , 0.62  ,0.72];


fH = gcf; colormap(jet(6));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:6, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end

legend('Data Set w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d','Data Set w rein-Gaussian-Feat: I_{p},Total major axis,a/d,d','Data Set w rein-SVM-Feat: crack length,Total major axis,a/d,d, shear index, d/s','Data Sets w and w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d','Data Sets w and w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d, shear index, d/s','Location','NorthOutside')
set(gca, 'XTick', 1:6, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc..', 0, [0 1 0 1 0 1], jet(6))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_FR3','-dpng', '-r1000');



%%
clear all,clc
close all
% data Set 1
 data = 100*[ 0.14 , 0.15 ,0.15 , 0.15  ; 0.85 , 0.87 , 0.84  ,0.85 ; 0.92  , 0.93 ,0.91  , 0.92  ;  0.71 , 0.76  , 0.69  , 0.71  ];

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[0.12  , 0.15 ;  0.9 , 0.82;0.94   , 0.9 ; 0.8  ,  0.66 ];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set-without shear reinforcement','Data Set-with shear reinforcement','Both data Sets-Regression','Both data Sets-Combined Classification and Regression','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance1','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
 data = 100*[ 0.07 ,0.1 ,0.08 , 0.07  ;0.83  , 0.82 , 0.77  , 0.78; 0.9 , 0.9 , 0.86 , 0.87  ; 0.68  , 0.66  , 0.59  , 0.61 ];

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[0.12  , 0.15 ;  0.9 , 0.82;0.94   , 0.9 ; 0.8  ,  0.66 ];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set-without shear reinforcement','Data Set-with shear reinforcement','Both data Sets-Regression','Both data Sets-Combined Classification and Regression','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance2','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];

data = 100*[0.17  ,0.16  ;0.8 , 0.82; 0.89,0.9 ; 0.63,0.66];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 3','Data Set 4','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_72','-dpng', '-r1000');

%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];

data = 100*[0.16  ,0.13  ;0.82 ,0.88 ; 0.9, 0.93; 0.67,0.76];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 4-Regression-Failure ratio-Feat: B, I_{p}, N_{c}, a/d, d','Data Set 4-Combined calssification and Regression-Failure ratio-Feat: B, I_{p}, N_{c}, a/d, d','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_73','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];
% data = 100*[  ,  ; , ; , ; , ];

data = 100*[0.08  ,0.08  ; 0.87, 0.88; 0.93,0.93 ;0.75 , 0.77];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 4-Regression-Feat: B, I_{p}, N_{c}, a/d, d','Data Set 4-Combined calssification and Regression-Feat: B, I_{p}, N_{c}, a/d, d','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_92','-dpng', '-r1000');

%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];
 data = 100*[ 0.05 , 0.05 ;0.95 , 0.96 ;0.97 , 0.98 ; 0.9 ,0.92 ];

% data = 100*[0.08  ,0.08  ; 0.87, 0.88; 0.93,0.93 ;0.75 , 0.77];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 4-Regression-Feat: B, I_{p}, N_{c}, a/d, d','Data Set 4-Combined calssification and Regression-Feat: B, I_{p}, N_{c}, a/d, d','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_112','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];
 data = 100*[ 0.06 ,0.06  ;0.95 , 0.94;0.97 , 0.97; 0.9,0.88 ];

% data = 100*[0.08  ,0.08  ; 0.87, 0.88; 0.93,0.93 ;0.75 , 0.77];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 4-Regression-Feat: B, I_{p}, N_{c}, a/d, d','Data Set 4-Combined calssification and Regression-Feat: B, I_{p}, N_{c}, a/d, d','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_132','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];
 data = 100*[ 0.06,0.02 , .07 ,0.07  ; 0.58 , 0.95,  0.92 ,0.93 ; 0.65 , 0.97,  0.95 , .96; 0.33 ,0.89 ,  0.84,0.86 ];

% data = 100*[0.08  ,0.08  ; 0.87, 0.88; 0.93,0.93 ;0.75 , 0.77];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 3-Regression','Data Set 3-Classification followed by regression','Data Set 4-Regression','Data Set 4-Classification followed by regression','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('Performance_141','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
 data = 100*[ 0.41 , 0.95 , 0.58  ;0.47 ,0.97  ,0.65    ; 0.17   , 0.89   , 0.33  ];

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[0.12  , 0.15 ;  0.9 , 0.82;0.94   , 0.9 ; 0.8  ,  0.66 ];



fH = gcf; colormap(jet(4));
Labels = {'(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 1 (Shear unreinforced)-SVM','Data Set 2 (Shear reinforced)-Gaussian','Data Set 3 (Data Set 1+ Data Set 2)-SVM','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_131','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
%  data = 100*[ ,   ,     ;  ,    ,  ;  ,   ,   ;  ,  ,  ];

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[0.12  , 0.15 ;  0.9 , 0.82;0.94   , 0.9 ; 0.8  ,  0.66 ];

 data = 100*[ 0.08,  .08 ,  0.07   ; 0.88 ,  0.94  ,0.91  ; 0.9 , 0.97  ,  0.94 ; 0.74 ,0.88  , 0.82 ];


fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 1 (Shear unreinforced)-SVM','Data Set 2 (Shear reinforced)-Gaussian','Data Set 3 (Data Set 1+ Data Set 2)-SVM','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_111','-dpng', '-r1000');

%%
clear all,clc
close all
% data Set 1
% data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];
% data = 100*[  ,  ; , ; , ; , ];

data = 100*[ 0.14 ,0.15,0.12 ;0.84 , 0.88,0.89;0.91 , 0.94,0.94; 0.71,0.77 ,0.78];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('Data Set 1','Data Set 2','Data Set 5','Location','NorthOutside')
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
print('performance4','-dpng', '-r1000');
%%
clear all,clc
close all
% data Set 1
 data = 100*[0.1 , 0.06 ,0.08  ; 0.89    , 0.94 ,0.92; 0.93 , 0.97,0.96   ; 0.73 , 0.87 ,0.84];

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[0.12  , 0.15 ;  0.9 , 0.82;0.94   , 0.9 ; 0.8  ,  0.66 ];

%  data = 100*[ 0.08,  .08 ,  0.07   ; 0.88 ,  0.94  ,0.91  ; 0.9 , 0.97  ,  0.94 ; 0.74 ,0.88  , 0.82 ];


fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained Variance Score'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
h=bar(data);
ylabel('Performance of models (%)')
ybuff=1;

for i=1:length(h)
    XDATA=get(get(h(i),'Children'),'XData');
    YDATA=get(get(h(i),'Children'),'YData');
    for j=1:size(XDATA,2)
        x=XDATA(1,j)+(XDATA(3,j)-XDATA(1,j))/2;
        y=YDATA(2,j)+ybuff;
        t=[num2str(YDATA(2,j),3), '%' ];
        text(x,y,t,'Color','k','HorizontalAlignment','left','Rotation',90)
    end
end
legend('ACI','Internal shear estimation-Classification followed by regression-SVM','Ultimate shear load estimation-Classification followed by regression-SVM','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_15','-dpng', '-r1000');
