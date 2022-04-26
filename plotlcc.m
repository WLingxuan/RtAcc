function [mean,std] = plotlcc(nepoch, data, ti)
%PLOTLCC 此处显示有关此函数的摘要
%   此处显示详细说明
nf = 0;
for i = 1 : 6
    nf = nf + data.freqlist(i);
end
usedfre = zeros(1, 6);

deltEpt = zeros(nepoch-1,nf+1) * nan;
di = 0;
tusedi = 0;
deltEpt(:,1) = ti(2:end,1);
for i = 1 : 6
   if data.freqlist(i) == 0
       continue;
   end
   
   di = di + 1;
   for ne = 1 : nepoch
       if ne < 2
           continue;
       end
       if isnan(data.cc(ne,i)) || isnan(data.cc(ne-1,i))
           deltEpt(ne-1, di+1) = nan;
       else
           tusedi = tusedi + 1;
           tused(tusedi) = ti(ne);
           deltEpt(ne-1, di+1) = data.cc(ne, i) - data.cc(ne-1,i);  
           usedfre(1, di) = di;
           usedstr(di) = data.fstr(i);
           
       end            
   end 
end

plotsubcc(deltEpt, usedfre, usedstr, data.sys(1), data.prn, tused);   
mean = 0;
std = 0;
end


function plotsubcc(deltEpt, usedfre, usedstr, sys, prn, tused)

RGB1 = cbrewer('qual', 'Set1', 6, 'linear');
plotnum = 0;
for i = 1:6
    if usedfre(1,i) == 0
        continue;
    else
        plotnum = plotnum + 1;
    end
end


figure1 = figure;
%axes1 = axes('Parent',figure1);
tit = sprintf("%s-%d伪距相位观测值历元间差分",sys, prn);
title(tit);

for i = 1:plotnum
    subplot(plotnum, 1, i);
    hold('on');
    fre = usedfre(1, i);
    
    [meanvec, stdvec] = calmeanstd(deltEpt(:,fre+1), 20);
    
    %axXLim1 = get(axes1,'xlim');
    disname_mean = sprintf("残差期望");%usedstr(i)
    %disname_std = sprintf("%s残差标准差", usedstr(i));
    mploti = plot(deltEpt(:,1),meanvec,'DisplayName',disname_mean,...
        'Tag','Residual MeanValue',...
        'LineStyle','-','LineWidth',1,...
        'Color','b');        %'Parent',axes1,...
    %setLineOrder(axes1,statLine1,ploti(i));
    lowerBound1 = meanvec - stdvec;
    upperBound1 = meanvec + stdvec;
    sploti = plot(deltEpt(:,1),lowerBound1,...
        deltEpt(:,1),upperBound1,...        
        'Tag','Residual STD',...       
        'LineStyle',':','LineWidth',1,...
        'Color','k');% 'Parent',axes1,...'DisplayName',disname_std,...
    ylabel("伪距残差");    
    legend('Location','northeast');
    %set(mploti,'handlevisibility','off');
    set(sploti,'handlevisibility','off');
    left = tused(1) -50;
    right = tused(end) +50;
    xlim([left right]);    
    grid('on');
    box('on');
    hold('off');
    %setLineOrder(axes1,statLine2,ploti(i));
    %%lgdu(i) = usedstr(i);
end
xlabel({'历元(s)'});
outname = sprintf("%s-PRN%d卫星伪距残差分布",sys, prn);
savefig(figure1, "tifs\"+outname);
saveas(figure1, "tifs\"+outname, 'tiffn');

end


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

