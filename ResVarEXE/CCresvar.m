function [Polyvar ,Diffvar, CCt, strout] = CCresvar(data,ti)
%CCRESVAR 此处显示有关此函数的摘要
%   此处显示详细说明
strlist = ["","","","","",""];
nf = 0;
for i = 1 : 6
    nf = nf + data.freqlist(i);
    if data.freqlist(i) == 1
        strlist(i) = data.fstr(i);     
    end
end
%usedfre = zeros(1, 6);
%di = 0;
if data.sys == "GPS"
    opsys = 'G';
    freqused = [1 2 3];
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "GAL"
    opsys = 'E'; 
    freqused = [1 2 3];
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "GLO"
    opsys = 'R'; 
    freqused = [1 2 3];
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "BDS2"
    opsys = 'C'; 
    freqused = [1 2 4];
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(4));
elseif data.sys == "BDS3"
    opsys = 'C ';
    freqused = [6 3 4];
    str1 = char(strlist(6)); str2 = char(strlist(3)); str3 = char(strlist(4)); 
end

strused = [str1; str2; str3];

%CC
%CCplot3(data, ti);
CCt = ti;
nanMaskcc = isnan(data.cc(:,1));
if any(nanMaskcc)
    data.cc(nanMaskcc,:) = []; 
    CCt(nanMaskcc,:) = [];
end

%把各个频率画到一张图
[Polyvar ,Diffvar] = plotccDfPl(CCt, data.cc, strused, opsys, data.prn, freqused);
%snrdata(:,i), el 放到外面做个回归
strout = strused;
end


function [Polystd,Diffstd] = plotccDfPl(time, data_used, str_fre, sys, prn, freqused)
len = length(data_used);
ccdata  = zeros(len,3);
polyCC  = zeros(len,3);
CCresid = zeros(len,3);
savedccResids = zeros(len, 3);
ccmeanvec = zeros(len,3);
ccstdvec = zeros(len,3);
deltEpt = zeros(len-1,3);
difmeanvec = zeros(len-1,3);
difstdvec = zeros(len-1,3);

satid = sprintf("%s%02d",sys,prn);
for i = 1:3
    j = freqused(i);
    ccdata(:,i) = data_used(:,j);
end

left = time(1) -50;
right = time(end) +50;
%tiplot = linspace(left, right);
[sortedtime, timeInd] = sort(time);

for i = 1:3
    fitCCfun = polyfit(time,ccdata(:,i),7); %7
    polyCC(:,i) = polyval(fitCCfun, time);
    CCresid(:,i) = ccdata(:,i) - polyCC(:,i);
    savedccResids(:,i) = CCresid(timeInd,i);
    [ccmeanvec(:,i), ccstdvec(:,i)] = calmeanstd(savedccResids(:,i), 20);
    deltEpt(:,i) = caldiffcc(ccdata(:,i));
    [difmeanvec(:,i), difstdvec(:,i)] = calmeanstd(deltEpt(:,i), 20);
    difstdvec = difstdvec/sqrt(2);
end
Polystd = ccstdvec;
Diffstd = difstdvec;

upbond1 = max(savedccResids(:,1),[],'all');
upbond2 = max(deltEpt(:,1),[],'all');
lowbond1 = min(savedccResids(:,1),[],'all');
lowbond2 = min(deltEpt(:,1),[],'all');
upbonda = max(upbond1, upbond2);
lowbonda = min(lowbond1, lowbond2);

upbond1 = max(savedccResids(:,2),[],'all');
upbond2 = max(deltEpt(:,2),[],'all');
lowbond1 = min(savedccResids(:,2),[],'all');
lowbond2 = min(deltEpt(:,2),[],'all');
upbondb = max(upbond1, upbond2);
lowbondb = min(lowbond1, lowbond2);

upbond1 = max(savedccResids(:,3),[],'all');
upbond2 = max(deltEpt(:,3),[],'all');
lowbond1 = min(savedccResids(:,3),[],'all');
lowbond2 = min(deltEpt(:,3),[],'all');
upbondc = max(upbond1, upbond2);
lowbondc = min(lowbond1, lowbond2);


figure1 = figure;

subplot(3,3,1);
hold on;
scatter(time, ccdata(:,1), 3, 'b', '*');
plot(time,polyCC(:,1),'DisplayName','多项式拟合','XLimInclude','off',...
    'Tag','7th degree',...   
    'LineStyle','-','LineWidth',1.5,...
    'MarkerSize',4,...
    'Color','r');
ylabel("观测值(m)");
xlabel({"历元(s)",'(a)'});
title(str_fre(1,2:3) + " CC组合拟合");
xlim([left right]);
%ylim([mincc maxcc]);
box('on');
grid('on');
hold('off');

subplot(3,3,4);
hold on;
scatter(time, ccdata(:,2), 3, 'b', '*');
plot(time,polyCC(:,2),'DisplayName','多项式拟合','XLimInclude','off',...
    'Tag','7th degree',...   
    'LineStyle','-','LineWidth',1.5,...
    'MarkerSize',4,...
    'Color','r');
ylabel("观测值(m)");
xlabel({"历元(s)",'(b)'});
title(str_fre(2,2:3) + " CC组合拟合");
xlim([left right]);
%ylim([mincc maxcc]);
box('on');
grid('on');
hold('off');

subplot(3,3,7);
hold on;
scatter(time, ccdata(:,3), 3, 'b', '*');
plot(time,polyCC(:,3),'DisplayName','多项式拟合','XLimInclude','off',...
    'Tag','7th degree',...   
    'LineStyle','-','LineWidth',1.5,...
    'MarkerSize',4,...
    'Color','r');
ylabel("观测值(m)");
xlabel({"历元(s)",'(c)'});
title(str_fre(3,2:3) + " CC组合拟合");
xlim([left right]);
%ylim([mincc maxcc]);
box('on');
grid('on');
hold('off');

subplot(3,3,2);
hold on;
residPlot1 = bar(sortedtime, savedccResids(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(sortedtime,ccmeanvec(:,1),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...
plot(sortedtime,ccstdvec(:,1),...
     'Tag','Residual STD',...
     'LineStyle','-','LineWidth',1.5,...
     'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(d)'});
title(str_fre(1,2:3) + " CC拟合残差");
xlim([left right]);
ylim([lowbonda upbonda]);
box('on');
grid('on');
hold('off');

subplot(3,3,5);
hold on;
residPlot2 = bar(sortedtime, savedccResids(:,2));
set(residPlot2(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(sortedtime,ccmeanvec(:,2),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...
plot(sortedtime,ccstdvec(:,2),...
     'Tag','Residual STD',...
     'LineStyle','-','LineWidth',1.5,...
     'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(e)'});
title(str_fre(2,2:3) + " CC拟合残差");
xlim([left right]);
ylim([lowbondb upbondb]);
box('on');
grid('on');
hold('off');

subplot(3,3,8);
hold on;
residPlot3 = bar(sortedtime, savedccResids(:,3));
set(residPlot3(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(sortedtime,ccmeanvec(:,3),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...
plot(sortedtime,ccstdvec(:,3),...
     'Tag','Residual STD',...
     'LineStyle','-','LineWidth',1.5,...
     'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(f)'});
title(str_fre(3,2:3) + " CC拟合残差");
xlim([left right]);
ylim([lowbondc upbondc]);
box('on');
grid('on');
hold('off');

subplot(3,3,3);
hold on;
residPlot4 = bar(time(2:end,1), deltEpt(:,1));
set(residPlot4(1), 'facecolor', 'b','edgecolor', 'b', ...
    'LineWidth',0.3);
plot(time(2:end,1),difmeanvec(:,1),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...RGB1(9,:)
plot(time(2:end,1),difstdvec(:,1),...
    'Tag','Residual STD',... 
    'LineStyle','-','LineWidth',1.5,...
    'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(g)'});
title(str_fre(1,2:3) + " CC组合历元差分");
xlim([left right]);
ylim([lowbonda upbonda]);
box('on');
grid('on');
hold('off');

subplot(3,3,6);
hold on;
residPlot5 = bar(time(2:end,1), deltEpt(:,2));
set(residPlot5(1), 'facecolor', 'b','edgecolor', 'b', ...
    'LineWidth',0.3);
plot(time(2:end,1),difmeanvec(:,2),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...RGB1(9,:)
plot(time(2:end,1),difstdvec(:,2),...
    'Tag','Residual STD',... 
    'LineStyle','-','LineWidth',1.5,...
    'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差(m)");
xlabel({"历元(s)",'(h)'});
title(str_fre(2,2:3) + " CC组合历元差分");
xlim([left right]);
ylim([lowbondb upbondb]);
box('on');
grid('on');
hold('off');

subplot(3,3,9);
hold on;
residPlot6 = bar(time(2:end,1), deltEpt(:,3));
set(residPlot6(1), 'facecolor', 'b','edgecolor', 'b', ...
    'LineWidth',0.3);
plot(time(2:end,1),difmeanvec(:,3),'DisplayName',"残差期望",...
    'Tag','Residual MeanValue',...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...RGB1(9,:)
plot(time(2:end,1),difstdvec(:,3),...
    'Tag','Residual STD',... 
    'LineStyle','-','LineWidth',1.5,...
    'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差(m)");
xlabel({"历元(s)",'(i)'});
title(str_fre(3,2:3) + " CC组合历元差分");
xlim([left right]);
ylim([lowbondc upbondc]);
box('on');
grid('on');
hold('off');

outname = sprintf("%s CC组合多项式拟合与历元间差分伪距残差分布",satid);
savefig(figure1, "tifs\"+outname);
saveas(figure1, "tifs\"+outname, 'tiffn');
close(figure1);
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