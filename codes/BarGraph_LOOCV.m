clear all,clc
close all
% data set 1
data = 100*[  0.19 , 0.17  , 0.18  ,0.15    ; 0.73   ,0.8   , 0.79  ,0.85   ; 0.85  , 0.89 ,0.89   , 0.92  ;  0.52  , 0.62   ,0.59  , 0.72  ];

% data = 100*[   ,   ,   ,    ;    ,   ,   ,    ;   ,  ,   ,   ;    ,    ,    ,   ];



fH = gcf; colormap(jet(4));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
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
legend('Gaussian-Feat: I_{p},Total major axis,a/d,d','SVM-Feat: I_{p},Total major axis,a/d,d','Gaussian-Feat: I_{p},Total major axis,a/d,d,shear index, d/s','SVM-Feat: I_{p},Total major axis,a/d,d,shear index, d/s','Location','NorthOutside')
set(gca, 'XTick', 1:5, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc', 0, [0 1 0 1], jet(4))


% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_FR','-dpng', '-r1000');

%% Data set 2
clear all,clc
close all
% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
% data = 100*[ 0.14 , 0.14 ,0.15  , 0.14 ;  0.84 ,0.85  , 0.82 , 0.84 ; 0.91 , 0.92 ,0.9 , 0.91 ; 0.7 ,0.72  ,0.66  , 0.7 ];

 data = 100*[ 0.14  , 0.15  , 0.13  ,  0.17 ,0.15 ;0.85    ,  0.88 ,0.9   ,  0.8  ,0.85; 0.92  , 0.93 ,0.95   , 0.89 ,0.92 ;  0.72  , 0.77   , 0.81   , 0.62  ,0.72];


fH = gcf; colormap(jet(6));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
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

legend('Data set w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d','Data set w rein-Gaussian-Feat: I_{p},Total major axis,a/d,d','Data set w rein-SVM-Feat: crack length,Total major axis,a/d,d, shear index, d/s','Data sets w and w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d','Data sets w and w/o rein-SVM-Feat: I_{p},Total major axis,a/d,d, shear index, d/s','Location','NorthOutside')
set(gca, 'XTick', 1:6, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc..', 0, [0 1 0 1 0 1], jet(6))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_FR3','-dpng', '-r1000');

%% paper figure 3

clear all,clc
close all
% data set 1

% data2 = 100*[ 0.33, 0.37, 0.39,0.36 ,0.45  ,0.28 , 0.29,0.28 , 0.32, 0.35;0.9 ,0.86 ,0.86 ,0.9 , 0.87 ,0.91 ,0.9 ,0.91 ,0.9 ,0.88 ;0.94 ,0.92 ,0.92 ,0.94 ,0.92  ,0.95 , 0.94,0.95 ,0.94 ,0.93 ; 0.81,0.72 , 0.72,0.77 ,0.66  ,0.83 ,0.81 ,0.82 , 0.8,0.77];
 data = 100*[  0.08,0.09 ,0.09,0.09   , 0.1  ,   0.07 ;0.9, 0.87, 0.83  , 0.85  , 0.8  ,  0.92  ;0.95,0.93, 0.91  ,0.92  ,  0.88 ,  0.96 ; 0.81,0.76, 0.68  , 0.73   ,   0.64 ,   0.85];

fH = gcf; colormap(jet(6));
Labels = {'NRMSE (error)', '(R)', 'IA','Explained variance Score'};
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

legend('Data set w/o rein-Gaussian-Feat: All, a/d,d','Data set w/o rein-Gaussian-Feat: I_{p},Total major axis,NO cracks, a/d,d','Data set w rein-Gaussian-Feat: All, a/d,d','Data set w rein-Gaussian-Feat: I_{p},Total major axis,NO cracks, a/d,d','Data sets w and w/o rein-SVM-Feat: All,a/d,d','Data sets w and w/o rein-SVM-Feat:I_{p},No cracks,Total major axis,a/d,d,shear index,d/s','Location','NorthOutside')
set(gca, 'XTick', 1:6, 'XTickLabel', Labels);

ylim([0 110])
applyhatch_pluscolor(fH,'//cc..', 0, [0 1 0 1 0 1], jet(6))

% applyhatch_pluscolor(gcf,'|-.+\',0,[1 1 0 1 0 ],cool(5),200,3,2)
% legend('baseline','SVM using Wavelet feat','SVM using Geometrical feat','J48 using Geometrical feat','SVM+J48 Geometrical feat','Position','bestoutside')
print('Performance_1','-dpng', '-r1000');
