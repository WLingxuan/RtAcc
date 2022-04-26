function [mean,std] = plotLccDEph(nepoch,ns, PRNList, freqList, ti, Lccd)
%PLOTLCCDEPH 此处显示有关此函数的摘要
%   此处显示详细说明
mean = zeros(nepoch, ns) * nan;
std = zeros(nepoch, ns) * nan;

for n_sat = 1 : ns
    if PRNList(n_sat) ~= 0
       if freqList(1) ~= 0
           deltEpt = zeros(nepoch-1,2) * nan;
           cc = Lccd(:,ns);
           for i = 1 : nepoch
               
               if i<2
                   continue; 
               end
               
               deltEpt(i-1,1) = ti(i,1);
               
               if isnan(cc(i))|| isnan(cc(i-1))
                   continue;
               end
               
               deltEpt(i-1,2) = cc(i) - cc(i-1);
               
           end 
           plotsubcc(deltEpt);
           
       end  
    end
end

mean = nepoch;
std = ns;
end

function plotsubcc(deltEpt)

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

%plot1 = plot(deltEpt,'DisplayName','data1');
scatter(deltEpt(:,1), deltEpt(:,2),5,'filled', 'MarkerEdgeColor','none');
        

axXLim1 = get(axes1,'xlim');

ydata1 = get(plot1, 'ydata');
ydata1 = ydata1(:);
ymedian1 = median(ydata1);
medianValue1 = [ymedian1 ymedian1];

statLine1 = plot(axXLim1,medianValue1,'DisplayName','   y 中位数',...
    'Tag','median y',...
    'Parent',axes1,...
    'LineStyle','-.',...
    'Color',[1 0 0]);

setLineOrder(axes1,statLine1,plot1);

ystd1 = std(ydata1);
ymean1 = mean(ydata1);
lowerBound1 = ymean1 - ystd1;
upperBound1 = ymean1 + ystd1;
stdValue1 = [lowerBound1 lowerBound1 NaN upperBound1 upperBound1 NaN];
axYStdLim1 = [axXLim1 NaN axXLim1 NaN];
statLine2 = plot(axYStdLim1,stdValue1,'DisplayName','   y 标准差',...
    'Tag','std y',...
    'Parent',axes1,...
    'LineStyle','-.',...
    'Color',[0.75 0 0.75]);

setLineOrder(axes1,statLine2,plot1);
box(axes1,'on');
hold(axes1,'off');
grid('on');
legend(axes1,'show');

end

function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  设置线顺序
%  AXESH1:  坐标区
%  NEWLINE1:  新线
%  ASSOCIATEDLINE1:  结合线

% 获取坐标区的子级
hChildren = get(axesh1,'Children');
% 删除新线条
hChildren(hChildren==newLine1) = [];
% 获取结合线的索引
lineIndex = find(hChildren==associatedLine1);
% 对各条线重新排序，以便显示具有关联数据的新线条
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% 设置子级:
set(axesh1,'Children',hNewChildren);
end