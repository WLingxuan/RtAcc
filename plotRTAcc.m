function [outputArg1,outputArg2] = plotRTAcc(nepoch, data, ti)
%%
nf = 0;
for i = 1 : 6
    nf = nf + data.freqlist(i);
end
usedfre = zeros(1, 6);
di = 0;
if data.sys == "GPS"
    opsys = 'G';
elseif data.sys == "GAL"
    opsys = 'E'; 
elseif data.sys == "GLO"
    opsys = 'R'; 
elseif data.sys == "BDS2"
    opsys = 'C'; 
elseif data.sys == "BDS3"
    opsys = 'C ';
end

for i = 1 : 6
    startep = 0; endep = 0;
    if data.freqlist(i) == 0
        continue;
    end
    di = di + 1;
    idx = 0;
    for ne = 1 : nepoch  
        if isnan(data.cc(ne,i)) && startep == 0
            continue;
        elseif idx == 0
            startep = ne;
            usedfre(1, di) = di;
            idx = 1;
        elseif isnan(data.cc(ne,i)) && startep ~=0
            endep = ne-1;
            break; 
        elseif ne == nepoch
            endep = ne;
        end
    end
    len = endep - startep + 1;
    if len < 2
        continue;
    end
    dataused(1:len,di) = data.cc(startep:endep,i);
    snrdata(1:len,di) = data.snr(startep:endep,i);
    el(1:len,1) = data.el(startep:endep,1);
    usedstr(di) = data.fstr(i);
    tused(1:len,1) = ti(startep:endep,1);
end

plotnum = 0;
for i = 1:6
    if usedfre(1,i) == 0
        continue;
    else
        plotnum = plotnum + 1;
    end
end

for i = 1:plotnum
    std(i) = plotccpoly(dataused(:,i), usedstr(i), opsys, data.prn, tused, snrdata(:,i), el);
    
end

outputArg1 = 0;
outputArg2 = 0;
end

%%
function std = plotccpoly(dataused, str_fre, sys, prn, tused,  snrdata, el)

time = tused(:,1);
ccdata = dataused(:,1);
nanMask1 = isnan(time(:)) | isnan(ccdata(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '具有 NaN 坐标的数据点将被忽略。');
    time(nanMask1) = [];
    ccdata(nanMask1) = [];
end
left = tused(1) -50;
right = tused(end) +50;
tiplot = linspace(left, right);
savedccResids = zeros(length(time), 1);
[sortedtime, timeInd] = sort(time);
%coeffs1 = cell(1,1);
fitCCResults = polyfit(time,ccdata,7);
CCplot = polyval(fitCCResults,tiplot);
%fittypesArray1(1) = 7;
CCfit = polyval(fitCCResults,time);
CCresid = ccdata - CCfit(:);
savedccResids(:,1) = CCresid(timeInd);
%coeffs1{1} = fitResults1;
%xlim([left right]);      

RGB1 = cbrewer('qual', 'Set1', 9, 'linear');
%1 cc&py 2 poly res 3 cc diff&mean+std 4 SNR&ele
figure1 = figure;

subplot(5,1,1);
hold('on');
plot1 = plot(time, ccdata, 'Color', 'b',...
     'LineStyle','-','LineWidth',1.5);
set(plot1,'DisplayName',str_fre);

fitLine1 = plot(tiplot,CCplot,'DisplayName','多项式拟合','XLimInclude','off',...
    'Tag','7th degree',...   
    'LineStyle','-','LineWidth',1.4,...
    'MarkerSize',4,...
    'Color','r');
ylabel("观测值(m)");  
tit = sprintf('CC组合观测值与多项式拟合');
title(tit);
box('on');
grid('on');
hold('off');
%legend('show','Location','best');

subplot(5,1,2);
hold('on');
residPlot1 = bar(sortedtime, savedccResids);
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
[ccmeanvec, ccstdvec] = calmeanstd(savedccResids, 20);
disname_mean = sprintf("残差期望");%usedstr(i)
plot(sortedtime,ccmeanvec,'DisplayName',disname_mean,...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...
    %setLineOrder(axes1,statLine1,ploti(i));
% lowerBound1 = ccmeanvec - ccstdvec;
% upperBound1 = ccmeanvec + ccstdvec;
% plot(sortedtime,lowerBound1,...
%     sortedtime,upperBound1,...     
%     'Tag','Residual STD',...      
%     'LineStyle',':','LineWidth',1.2,...
%     'Color','k');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差(m)");    

tit = sprintf('CC组合与拟合值差值');
title(tit);
xlim([left right]);
box('on');
grid('on');
hold('off');

subplot(5,1,3);
hold('on');
deltEpt = caldiffcc(dataused);
residPlot1 = bar(time(2:end,1), deltEpt(:,1));
set(residPlot1(1), 'facecolor', 'r','edgecolor', 'r', ...
    'LineWidth',0.3);

[difmeanvec, difstdvec] = calmeanstd(deltEpt(:,1), 20);
difstdvec = difstdvec/sqrt(2);
disname_mean = sprintf("残差期望");%usedstr(i)
mploti = plot(time(2:end,1),difmeanvec,'DisplayName',disname_mean,...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',0.6,...
    'Color','k');        %'Parent',axes1,...RGB1(9,:)
% lowerBound1 = difmeanvec - difstdvec;
% upperBound1 = difmeanvec + difstdvec;
% sploti = plot(time(2:end,1),lowerBound1,...
%     time(2:end,1),upperBound1,...  
%     'Tag','Residual STD',...  
%     'LineStyle',':','LineWidth',1,...
%     'Color','k');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("伪距残差(m)");   
xlim([left right]); 
tit = sprintf('CC组合历元间差分值');
title(tit);
box('on');
grid('on');
hold('off');

subplot(5,1,4);
hold('on');
plot(time(2:end,1),difstdvec,...
    'Tag','Residual STD',... 
    'LineStyle','-','LineWidth',1.3,...
    'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
 plot(sortedtime,ccstdvec,...
     'Tag','Residual STD',...
     'LineStyle','-','LineWidth',1.3,...
     'Color','b');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("标准差(m)");
xlim([left right]); 
tit = sprintf('标准差');
title(tit);
box('on');
grid('on');
hold('off');

%把方差都话到这里
%高度角计算方差（信噪比）



% sploti = plot(time(2:end,1),lowerBound1,...
%     time(2:end,1),upperBound1,...  
%     'Tag','Residual STD',...  
%     'LineStyle',':','LineWidth',1,...
%     'Color','k');% 'Parent',axes1,...'DisplayName',disname_std,...

%yyaxis left
%plot(time, el, 'Color', RGB1(4,:));
%yyaxis right
%plot(time, snrdata, 'Color', RGB1(5,:));
%ylabel("高度角(°)");  
%snraxes = axes('right');




subplot(5,1,5);
hold('on');
yyaxis left
ylabel("高度角(°)"); 
plot(time, el);%, 'Color', 'r'

ylim([9 91]); 
yyaxis right
ylabel("信噪比(dB-Hz)");
plot(time, snrdata);%, 'Color', RGB1(5,:)
%ylim([33 55]); 

%snraxes = axes('right');
%plot(time,snrdata, 'LineStyle',':','LineWidth',1, 'Color',RGB1(4,:));
%xlim([left right]); 
% 高度角 SNR画一张图

xlim([left right]); 
xlabel({'历元(s)'});
title("高度角与信噪比");
box('on');
grid('on');
hold('off');

outname = sprintf("%s-PRN%d卫星%s CC组合多项式拟合与历元间差分伪距残差分布",sys, prn, str_fre);
savefig(figure1, "tifs\"+outname);
saveas(figure1, "tifs\"+outname, 'tiffn');
outname
std = 0;
end



%%
function deltEpt = caldiffcc(dataused)
len = length(dataused);
deltEpt = zeros(len-1,1) * nan;
for ne = 1 : len
   if ne < 2
      continue; 
   end
   if isnan(dataused(ne,1)) || isnan(dataused(ne-1,1))
       deltEpt(ne-1, 1) = nan;
   else
       deltEpt(ne-1, 1) = dataused(ne, 1) - dataused(ne-1,1); 
   end
end
end

%%
function [meanvec, stdvec] = calmeanstd(delt, wnds)
len = length(delt);
meanvec = zeros(len, 1)*nan;
stdvec = zeros(len,1)*nan;

for i = 1 : len
    tempvec = [];
    if isnan(delt(i))
        meanvec(i) = nan;
        stdvec(i) = nan;
        continue;
    end
    
    if i <= wnds
        tempvec = delt(1:(i+wnds), 1);
    elseif i > len-wnds
        tempvec = delt((i-wnds):end, 1);
    else
        tempvec = delt((i-wnds):(i+wnds),1);        
    end
    
    meanvec(i) = mean(tempvec, 'omitnan');
    stdvec(i) = std(tempvec,'omitnan');
    
end
end