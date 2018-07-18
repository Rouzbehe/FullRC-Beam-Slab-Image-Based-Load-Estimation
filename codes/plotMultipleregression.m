function [] = plotMultipleregression(X,plotfnameRegression,Xaxis,Yaxis,Zaxis,plotfname)




% to remove deep beams
removeid=find(X(:,26)>500);
X(removeid,:)=[];

x1=X(:,Xaxis);
x2=X(:,Yaxis);
% 24 is a/d andd 26 is d
x3=X(:,24);
x4=X(:,26);
y=X(:,Zaxis);

Xdata = [ones(size(x1)) x1 x2 x1.*x2];
b = regress(y,Xdata) %   % Removes NaN data







Xvar = [x1,x2,x3,x4];

% % % % % % % % % % % % % % % % V-Vaci % % % % % % % % % % % % %

% fit for V-Vaci using 10 (Area) , 13 (Total major axis), 24 (a/d), 26(d)

% features works bes for all data sets and depths
% modelfun = @(b,x) (b(1) + b(2)*x(:,1) + ...
%     b(3)*x(:,1).^2+b(4)*x(:,2)).*(1-b(5)*x(:,3).^1+b(6)*x(:,4).^-1);

% V-Vaci all data set ex deep and uniform d<20 in
% theString = sprintf('y =[0.75+0.00027(L)-1.5e-8(L)^2+0.00016(Major axis)]*[1-0.19(a/d)+119.3/d]');

% features works bes for data ex deep and unform (both d<20 and all depths)
% modelfun = @(b,x) (b(1) + b(2)*x(:,1) + ...
%     b(3)*x(:,1).^2+b(4)*x(:,2)).*(1-b(5)*x(:,3).^1+b(6)*x(:,4).^-1);

% V-Vaci all data set ex deep and uniform d<20 in
% theString = sprintf('y =[0.87+0.0004(L)-2.2e-8(L)^2+0.00012(Major axis)]*[1-0.08(a/d)+11.8/d]');

% V-Vaci all data set ex deep and uniform all depths
% theString = sprintf('y =[0.77+0.0002(L)-1.2e-8(L)^2+0.00016(Major axis)]*[1-0.17(a/d)+111.3/d]');



% % % % % % % % % % % % % % % % Fracture Ratio % % % % % % % % % % % % %

% fit for Fracture Ratio using  (Total major axis)=13 (threshout)=3, 24 (a/d), 26(d)
% features works bes for data ex deep and unform (all depths)
% modelfun = @(b,x) (b(1) + b(2)*x(:,1) + ...
%     b(3)*x(:,1).^2+b(4)*x(:,2)+b(5)*x(:,2).^2).*(1-b(6)*x(:,3).^1+b(7)*x(:,4).^-1);
% 
% % FractureRatio all data set ex deep and uniform all depths
%  theString = sprintf('y =[0.22+0.0002(Major axis)-1.2e-8(Major axis)^2+5(Thresh)-16(Thresh)^2]*[1-0.08(a/d)+42.3/d]');


% fit for Fracture Ratio using  (Total major axis)=13 , 24 (a/d), 26(d)
% features works bes for all data sets 
modelfun = @(b,x) (b(1) + b(2)*x(:,1) + ...
    b(3)*x(:,1).^2).*(1+b(4)*x(:,3).^1+b(5)*x(:,4).^-1);

% FractureRatio all data set ex deep and uniform all depths
 theString = sprintf('y =[0.34+0.0003(Major axis)-2.67e-8(Major axis)^2]*[1-0.095(a/d)+50.2/d]');



beta0 = [0 0 0 0 0 ];
mdl = fitnlm(Xvar,y,modelfun,beta0)

% to access to coefiecnts
beta = mdl.Coefficients.Estimate 

% theString = sprintf('y = (%.4f x + %.4f)*(1-%.4f beta(7)+%.4f beta(8))', bestfit(1), bestfit(2));
% text(2,3, theString, 'FontSize', 24);


ypred =feval(mdl,Xvar);
tvp=[y,ypred];

figure4=figure('Position', [100, 100, 1024, 1200]);

% 3d plot regression
x2new=(beta(4).*x3+beta(5).*x4.^-1);

scatter3(x1,x2new,y,'filled')
hold on

x2new=(beta(4).*x3+beta(5).*x4.^-1);
x1fit = min(x1):10:max(x1);
x2fit = min(x2new):0.05:max(x2new);

[X1FIT,X2FIT] = ndgrid(x1fit,x2fit);
YFIT = (beta(1) + beta(2)*X1FIT + beta(3)*X1FIT.^2 ).*(1+X2FIT);


mesh(X1FIT,X2FIT,YFIT)
xlabel('Total major axis')
ylabel('0.075(a/d)+62.6/d')
zlabel('Fracture Ratio')
view(50,10)

hold off


% to remove "NaN" array from calculation in case some exis
tvp(find(isnan(tvp(:,2))),:) = []; 


%tvp(:,2) predicted variable, tvp(:,1) true varaible
NMAE = mean(abs(tvp(:,2)-tvp(:,1))./tvp(:,1))*100;
RMSE = sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/mean(tvp(:,1));
NRMSE=sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/(max(tvp(:,1))-min(tvp(:,1)));
SDR= sqrt(mean((tvp(:,2)-tvp(:,1)-mean(tvp(:,2))+mean(tvp(:,1))).^2));
R = corrcoef(tvp(:,2),tvp(:,1));
[RHO,PVAL] = corr(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)),'Type','Spearman');
IA = 1 - mean((tvp(:,2)-tvp(:,1)).^2)/max(mean((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2),eps);
% CorrectnessTol=mean((abs(tvp(:,2)-tvp(:,1))<tol)*100);
% Correctness=mean((abs(tvp(:,2)-tvp(:,1))<NMAE)*100);
ExVar=1-var(tvp(:,1)-tvp(:,2),1)/var(tvp(:,1),1);
Rn = corrcoef(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)));

nameFolder='Oct_18_regressionfit';
if (exist(char(nameFolder),'dir') == 0); mkdir(char(nameFolder)); end;
Namepdf = strcat(nameFolder,'/',plotfname,'.pdf');
NameJPG = strcat(nameFolder,'/',plotfname);
Nametxt = strcat(nameFolder,'/',plotfname,'.txt');


% if (exist(char('test'),'dir') == 0); mkdir(char('test')); end;
% Namepdf = strcat('test','/',plotfname,'.pdf');
% NameJPG = strcat('test','/',plotfname);
% Nametxt = strcat('test','/',plotfname,'.txt');


fid = fopen(Nametxt,'w');

fprintf(fid,'Accuracy Performance of models\n');
fprintf(fid,'\t NRMSE \t NMAE \t RMSE \t SDR \t R \t IA \t Rn \t ExplVarSco \n');
fprintf(fid, '\t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f\t %2.2f \t %2.2f \n',NRMSE,NMAE,RMSE,SDR,R(2),IA,Rn(2),ExVar) 

close(ancestor(fid, 'figure'))









%set plot limits
xmin = min(tvp(:,1));
xmax = max(tvp(:,1));
ymin = min(tvp(:,2));
ymax = max(tvp(:,2));
% plotmin = floor(min(xmin,ymin));
plotmin=0;
plotmax = max(xmax,ymax);
% plotmax =2.5;

%find limits for linear fit (equation forced through origin)
A=tvp(:,1);
B=tvp(:,2);
m=sum(A.*B)/sum(A.^2);
mx = [0,plotmax];
my = [0,plotmax*m];

 figure6=figure('Position', [100, 100, 1024, 1200]);
%plot scatter and trendlines (and 45 degree correlation) d
plot(tvp(:,1),tvp(:,2),'k*','markers',7)
hold on
plot(mx,my,'k')
hold on 
plot([0,plotmax],[0,plotmax],'--k')
hold on 

xlim([0 plotmax]);
ylim([0 plotmax]);

% set(gca,'XTick',plotmin:tol:plotmax)
% set(gca,'YTick',plotmin:tol:plotmax)
fontsize=17;


Plot_No=Zaxis;
  
  
  if Plot_No==24
  xlabel('True deflection ratio (deflection/beam length)%','fontsize',fontsize);
  ylabel('Predicted deflection ratio (deflection/beam length)%','fontsize',fontsize);
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','deflection ratio');

elseif Plot_No==23
   xlabel('True shear force (kN)','fontsize',fontsize);
  ylabel('Predicted shear force (kN)','fontsize',fontsize);
    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','shear force');

elseif Plot_No==25
   xlabel('True moment at mid span (kN.mm)','fontsize',fontsize);
  ylabel('Predicted moment at mid span (kN.mm)','fontsize',fontsize);    
      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','moment');

elseif Plot_No==26
   xlabel('True scaled moment at mid span (M/(EI))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span (M/(EI))','fontsize',fontsize);  
  
        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment');

elseif Plot_No==27
   xlabel('True scaled moment at mid span (M/(bd^2))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span (M/(bd^2))','fontsize',fontsize);  
          NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment 2');

elseif Plot_No==28
   xlabel('True scaled moment at mid span (M/(Asfyd))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span (M/(Asfyd))','fontsize',fontsize);   
  
  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled moment Asfy');

elseif Plot_No==29
   xlabel('True scaled shear force (V/(GJ))','fontsize',fontsize);
  ylabel('Predicted sclaed shear force (V/(GJ))','fontsize',fontsize);  
  
    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled shear force GJ');

elseif Plot_No==30
   xlabel('True scaled shear force (V/(bd))','fontsize',fontsize);
  ylabel('Predicted sclaed shear force (V/(bd))','fontsize',fontsize);    
  
      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','scaled shear force Vbd');

  elseif Plot_No==31
   xlabel('True scaled moment at mid span  (M/(bd))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span (M/(bd))','fontsize',fontsize);
  
        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbd');

  elseif Plot_No==32
   xlabel('True scaled moment at mid span  (M/(bh))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(bh))','fontsize',fontsize); 
  
          NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbh');

  elseif Plot_No==33
   xlabel('True scaled moment at mid span  (M/(bhl))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(bhl))','fontsize',fontsize); 
  
            NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mbhl');

    elseif Plot_No==34
   xlabel('True scaled moment at mid span  (M/(bdl))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(bdl))','fontsize',fontsize); 
  
              NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mdl');

      elseif Plot_No==35
   xlabel('True scaled moment at mid span  (M/(fc bhl))','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(fc bhl))','fontsize',fontsize); 
  
                NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Mfcbhl');

     elseif Plot_No==36
   xlabel('True scaled moment at mid span (Integral Ratio) ','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (Integral Ratio)','fontsize',fontsize); 
  
                  NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M Integral');

     elseif Plot_No==37
   xlabel('True scaled moment at mid span (M/(abh (l-a))) ','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(abh (l-a)))','fontsize',fontsize); 
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M span');

    elseif Plot_No==40
   xlabel('True scaled moment at mid span (M/(a^2bh)) ','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(a^2bh))','fontsize',fontsize); 
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M midsoan');

     elseif Plot_No==41
   xlabel('True scaled moment at mid span   (M/(\rho bd)) ','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd)) ','fontsize',fontsize);  
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M rho bd');

     elseif Plot_No==42
%  xlabel('True scaled shear $$(V/(2\sqrt{f_c}~bd)$$','fontsize',13,'FontName','Helvetica','Interpreter','latex');
%   ylabel('Predicted scaled shear $$(V/(2\sqrt{f_c}~bd)$$','fontsize',13,'FontName','Helvetica','Interpreter','latex'); 

 xlabel('True scaled shear     ','fontsize',fontsize);
 ylabel('Predicted scaled shear     ','fontsize',fontsize);  
  
                      NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','V aci');

      elseif Plot_No==43
  xlabel('True  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',fontsize);
  ylabel('Predicted  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',fontsize); 
  
                        NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','Failure Ratio');

       elseif Plot_No==44
   xlabel('True scaled moment at mid span   (M/(\rho bd)) ','fontsize',fontsize);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd)) ','fontsize',fontsize);  
  
                    NameJPG2 = strcat(nameFolder,'/',plotfname,'ConfidenceInterval','M rho bd');
end


% text(0.03, .25, theString, 'FontSize', fontsize-2);

annotation('textbox',...
    [0.12 0.12 0.85 0.065],...
    'String',theString,'FontSize', fontsize-2,'BackgroundColor',[1  1 1])

alpha=[0.01:0.01:0.1];
[p,S] = polyfitZero(tvp(:,1),tvp(:,2),1);
[Y,DELTA] = polyconf(p,tvp(:,1),S,'alpha',alpha(5));

% hconf = plot(tvp(:,1),Y+DELTA,'-b<','MarkerFaceColor',[.49 1 .63]);

hconf = plot(tvp(:,1),Y+DELTA,'b','LineWidth',2.2);
plot(tvp(:,1),Y-DELTA,'b','LineWidth',2.2);

LEG=legend('data d<20 inch', 'regression trend', 'ideal trend', '95 % regression intervals','Location','northwest')
set(LEG,'fontsize',fontsize);
set(gca,'fontsize',fontsize)

% set(gcf, 'PaperPositionMode', 'auto')

h = gcf;
% print('-dpdf',char(Namepdf),'-r300')
print(char(NameJPG),'-dpng', '-r300');
% saveas(h, char(NameJPG),'-r300');
% hold off

for ii=1:length(alpha)
[Y,Delta(ii,:)] = polyconf(p,tvp(:,1),S,'alpha',alpha(ii)) ;   

delta(ii)=mean(Delta(ii,:));
end


figure

plot((1-alpha)*100,delta,'b-','LineWidth',1.5)
grid on
xlim([ min((1-alpha)*100) max((1-alpha)*100)]);

xlabel('Prediction Interval (%)','fontsize',fontsize);
ylabel('Average margin of error','fontsize',fontsize);  
set(gca,'fontsize',fontsize)

% print('-dpdf',char(Namepdf),'-r300')
print(char(NameJPG2),'-dpng', '-r300');




end