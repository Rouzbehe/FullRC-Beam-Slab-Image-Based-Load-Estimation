function [] = plotCorrelation_all(tvp,plotfname,Plot_No)







% to remove "NaN" array from calculation in case some exis
tvp(find(isnan(tvp(:,2))),:) = []; 


%tvp(:,2) predicted variable, tvp(:,1) true varaible
NMAE = mean(abs(tvp(:,2)-tvp(:,1))./tvp(:,1))*100;
RMSE = sqrt(mean((tvp(:,2)-tvp(:,1)).^2))/mean(tvp(:,1));
SDR= sqrt(mean((tvp(:,2)-tvp(:,1)-mean(tvp(:,2))+mean(tvp(:,1))).^2));
R = corrcoef(tvp(:,2),tvp(:,1));
[RHO,PVAL] = corr(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)),'Type','Spearman');
IA = 1 - mean((tvp(:,2)-tvp(:,1)).^2)/max(mean((abs(tvp(:,2)-mean(tvp(:,1)))+abs(tvp(:,1)-mean(tvp(:,1)))).^2),eps);
% CorrectnessTol=mean((abs(tvp(:,2)-tvp(:,1))<tol)*100);
% Correctness=mean((abs(tvp(:,2)-tvp(:,1))<NMAE)*100);
ExVar=1-var(tvp(:,1)-tvp(:,2),1)/var(tvp(:,1),1);
Rn = corrcoef(tvp(:,2)/max(tvp(:,2)),tvp(:,1)/max(tvp(:,1)));

nameFolder='Case2';
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
fprintf(fid,'\t RSpearman \t NMAE \t RMSE \t SDR \t R \t IA \t Rn \t ExplVarSco \n');
fprintf(fid, '\t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f \t %2.2f\t %2.2f \t %2.2f \n',RHO,NMAE,RMSE,SDR,R(2),IA,Rn(2),ExVar) 

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

%plot scatter and trendlines (and 45 degree correlation) d
plot(tvp(:,1),tvp(:,2),'k*','markers',7)
hold on
plot(mx,my,'k')
hold on 
plot([0,plotmax],[0,plotmax],'--k')

xlim([0 plotmax]);
ylim([0 plotmax]);

% set(gca,'XTick',plotmin:tol:plotmax)
% set(gca,'YTick',plotmin:tol:plotmax)
size=17;


testfeatNo=24;% 23=deflection, 22=V,24=M, 25=M/EI, 26=M/bd^2, 27=M/Asfy, 28=V/GJ, 29=V/bd


if Plot_No==24
  xlabel('True deflection ratio (deflection/beam length)%','fontsize',size);
  ylabel('Predicted deflection ratio (deflection/beam length)%','fontsize',size);
elseif Plot_No==23
   xlabel('True shear force (kN)','fontsize',size);
  ylabel('Predicted shear force (kN)','fontsize',size);   
elseif Plot_No==25
   xlabel('True moment at mid span (kN.mm)','fontsize',size);
  ylabel('Predicted moment at mid span (kN.mm)','fontsize',size);       
elseif Plot_No==26
   xlabel('True scaled moment at mid span (M/(EI))','fontsize',size);
  ylabel('Predicted scaled moment at mid span (M/(EI))','fontsize',size);    
elseif Plot_No==27
   xlabel('True scaled moment at mid span (M/(bd^2))','fontsize',size);
  ylabel('Predicted scaled moment at mid span (M/(bd^2))','fontsize',size);   
elseif Plot_No==28
   xlabel('True scaled moment at mid span (M/(Asfyd))','fontsize',size);
  ylabel('Predicted scaled moment at mid span (M/(Asfyd))','fontsize',size);   
elseif Plot_No==29
   xlabel('True scaled shear force (V/(GJ))','fontsize',size);
  ylabel('Predicted sclaed shear force (V/(GJ))','fontsize',size);     
elseif Plot_No==30
   xlabel('True scaled shear force (V/(bd))','fontsize',size);
  ylabel('Predicted sclaed shear force (V/(bd))','fontsize',size);    
  elseif Plot_No==31
   xlabel('True scaled moment at mid span  (M/(bd))','fontsize',size);
  ylabel('Predicted scaled moment at mid span (M/(bd))','fontsize',size); 
  elseif Plot_No==32
   xlabel('True scaled moment at mid span  (M/(bh))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bh))','fontsize',size); 
  elseif Plot_No==33
   xlabel('True scaled moment at mid span  (M/(bhl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bhl))','fontsize',size); 
    elseif Plot_No==34
   xlabel('True scaled moment at mid span  (M/(bdl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(bdl))','fontsize',size); 
      elseif Plot_No==35
   xlabel('True scaled moment at mid span  (M/(fc bhl))','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(fc bhl))','fontsize',size); 
     elseif Plot_No==36
   xlabel('True scaled moment at mid span (Integral Ratio) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (Integral Ratio)','fontsize',size); 
     elseif Plot_No==37
   xlabel('True scaled moment at mid span (M/(abh (l-a))) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(abh (l-a)))','fontsize',size); 
    elseif Plot_No==38
   xlabel('True scaled moment at mid span (M/(a^2bh)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(a^2bh))','fontsize',size); 
     elseif Plot_No==39
   xlabel('True scaled moment at mid span   (M/(\rho bd)) ','fontsize',size);
  ylabel('Predicted scaled moment at mid span  (M/(\rho bd)) ','fontsize',size);  
     elseif Plot_No==40
  xlabel('True scaled shear force at mid span   (V/($$\sqrt{f_c}$$ bd) ','fontsize',size);
  ylabel('Predicted scaled shear force  at mid span  (V/($$\sqrt{f_c}$$ bd) ','fontsize',size);  
      elseif Plot_No==41
  xlabel('True  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',size);
  ylabel('Predicted  Failure ratio (M/M_{failure}) or (V/V_{failure})','fontsize',size);  
end



LEG=legend('prediction', 'prediction trend', 'ideal trend', 'Location','northwest')
set(LEG,'fontsize',size);
set(gca,'fontsize',size)
h = gcf;
% print('-dpdf',char(Namepdf),'-r300')
print(char(NameJPG),'-dpng', '-r300');
% saveas(h, char(NameJPG),'-r300');
% hold off


% close(fid);


end