function [] = plotRegression(X,plotfnameRegression,Xaxis,Yaxis,curveaxis)








% to remove "NaN" array from calculation in case some exis
% tvp(find(isnan(tvp(:,2))),:) = []; 

% 
% 
% tvp(:,2) predicted variable, tvp(:,1) true varaible
% NMAE = mean(abs(tvp(:,2)-tvp(:,1))./tvp(:,1))*100;
% RMSE = sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/mean(tvp(:,1));
% SDR= sqrt(mean((tvp(:,2)-tvp(:,1)-mean(tvp(:,2))+mean(tvp(:,1))).^2));
% R = corrcoef(tvp(:,2),tvp(:,1));
% [RHO,PVAL] = corr(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)),'Type','Spearman');
% IA = 1 - mean((tvp(:,2)-tvp(:,1)).^2)/max(mean((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2),eps);
% CorrectnessTol=mean((abs(tvp(:,2)-tvp(:,1))<tol)*100);
% Correctness=mean((abs(tvp(:,2)-tvp(:,1))<NMAE)*100);
% ExVar=1-var(tvp(:,1)-tvp(:,2),1)/var(tvp(:,1),1);
% Rn = corrcoef(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)));

nameFolder='Sep_28/regression';
if (exist(char(nameFolder),'dir') == 0); mkdir(char(nameFolder)); end;
Namepdf = strcat(nameFolder,'/',plotfnameRegression,'.pdf');
NameJPG = strcat(nameFolder,'/',plotfnameRegression);
Nametxt = strcat(nameFolder,'/',plotfnameRegression,'.txt');

% ids=find(X(:,41)==1);
% X=X(ids,:);

% to remove very deep beams
removeid=find(X(:,curveaxis)>500);
X(removeid,:)=[];


theSignal=X(:,curveaxis);
% preDefined=[floor(max(theSignal)/5);floor(2*max(theSignal)/5);floor(3*max(theSignal)/5);floor(4*max(theSignal)/5);floor(max(theSignal))];

% preDefined=[2;2.5;2.8;3;3.5;5];
% preDefined=[0.25;0.5;0.75;1];
preDefined=25.4*[5;8;10;15;20;25];

for i=1:length(theSignal)
     [Y,I] = min(abs(theSignal(i)-preDefined));
     theSignal(i) =preDefined(I);
end






Zcurve=theSignal; Xcurve=X(:,Xaxis); Ycurve=X(:,Yaxis);




colorstflex = 'kbrgmbc';
plotStyle = {'o','*','r.','s','^','+','.'};


% for m=1:numel(preDefined)
%  n=find(Zcurve==preDefined(m));
%  plot(Xcurve(n),Ycurve(n),plotStyle{m},'color',colorstflex(m))
%  legendInfo{m}=[num2str(preDefined(m))]; % or whatever is appropriate
%  legend(legendInfo)
%  hold on
% end


% removeid=find(Ycurve>0.98);
% Ycurve(removeid)=[];
% Xcurve(removeid)=[];

removeid=find(Xcurve>300);
Ycurve(removeid)=[];
Xcurve(removeid)=[];

plot(Xcurve,Ycurve,'*')

print(char(NameJPG),'-dpng', '-r300');


end