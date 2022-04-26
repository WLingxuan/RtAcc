function [mean,std] = plotccpoly(nepoch, data, ti)
%PLOTCCPOLY 此处显示有关此函数的摘要
%   此处显示详细说明

nf = 0;
for i = 1 : 6
    nf = nf + data.freqlist(i);
end

usedfre = zeros(1, 6);

di = 0; tusedi = 0; 
dataused = [];

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
        end
    end
    len = endep - startep + 1;
    if len < 2
        continue;
    end
    dataused(1:len,di) = data.cc(startep:endep,i);
    usedstr(di) = data.fstr(i);
    tused(1:len,1) = ti(startep:endep,1);
end



plotsubpoly(dataused, usedfre, usedstr, data.sys(1), data.prn, tused);
mean = 0;
std = 0;
end



function plotsubpoly(dataused, usedfre, usedstr, sys, prn, tused)
RGB1 = cbrewer('qual', 'Set1', 6, 'linear');
plotnum = 0;
for i = 1:6
    if usedfre(1,i) == 0
        continue;
    else
        plotnum = plotnum + 1;
    end
end

for i = 1:plotnum   
    figure1 = figure;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    xdata = tused(:,1);
    ydata = dataused(:,i);
    
    plot1 = plot(xdata, ydata,'Parent',axes1);
    set(plot1(1),'DisplayName',usedstr(i));
    left = tused(1) -50;
    right = tused(end) +50;
    xlim([left right]);      
    
    
    nanMask1 = isnan(xdata(:)) | isnan(ydata(:));
    if any(nanMask1)
        warning('GeneratedCode:IgnoringNaNs', ...
            '具有 NaN 坐标的数据点将被忽略。');
        xdata(nanMask1) = [];
        ydata(nanMask1) = [];
    end
    axesLimits1 = xlim(axes1);
    xplot1 = linspace(axesLimits1(1), axesLimits1(2));
    set(axes1,'position',[0.1300    0.5811    0.7750    0.3439]);
    residAxes1 = axes('position', [0.1300    0.1100    0.7750    0.3439], ...
        'parent', gcf);
    savedResids1 = zeros(length(xdata), 1);
    [sortedXdata1, xInd1] = sort(xdata);
    coeffs1 = cell(1,1);
    fitResults1 = polyfit(xdata,ydata,7);
    yplot1 = polyval(fitResults1,xplot1);
    fittypesArray1(1) = 8;
    Yfit1 = polyval(fitResults1,xdata);
    resid1 = ydata - Yfit1(:);
    savedResids1(:,1) = resid1(xInd1);
    coeffs1{1} = fitResults1;
    fitLine1 = plot(xplot1,yplot1,'DisplayName','   7 次','XLimInclude','off',...
        'Tag','7th degree',...
        'Parent',axes1,...
        'MarkerSize',6,...
        'Color',[0.85 0.325 0.098]);
    residPlot1 = bar(residAxes1, sortedXdata1, savedResids1);
    set(residPlot1(1), 'facecolor', [0.85 0.325 0.098],'edgecolor', [0.85 0.325 0.098]);
    title(residAxes1, '残差');
    box(axes1,'on');
    hold(axes1,'off');
    % 设置其余坐标区属性
    set(axes1,'OuterPosition',[0 0.5 1 0.5]);
    % 创建 legend
    legend1 = legend(axes1,'show');
    set(legend1,...
        'Position',[0.613350336139242 0.795946709098729 0.202295922155631 0.109863948914701]);
end

end



