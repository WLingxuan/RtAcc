function clkerrfit(X1, Y1)
%CREATEFIGURE(X1, Y1, S1, C1)
%  X1:  scatter x
%  Y1:  scatter y
%  S1:  scatter s
%  C1:  scatter c

%  由 MATLAB 于 25-Mar-2022 16:35:55 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 scatter
scatter1 = scatter(X1,Y1,...
    'MarkerEdgeColor','none',...
    'MarkerFaceColor',[0.96078431372549 0.23921568627451 0.0784313725490196]);

% 获取图中的 xdata
xdata1 = get(scatter1, 'xdata');
% 获取图中的 ydata
ydata1 = get(scatter1, 'ydata');
% 确保数据为列向量
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% 删除 NaN 值并发出警告
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '具有 NaN 坐标的数据点将被忽略。');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% 求用于基于 xlim 绘制拟合图的 x 值
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));

% 准备绘制残差图
% 为残差创建一个单独图窗
residFigure1 = figure();
% 重新定位残差图窗
set(residFigure1,'units','pixels');
residPos1 = get(residFigure1,'position');
set(residFigure1,'position', residPos1 + [50 -50 0 0]);
residAxes1 = axes('parent', residFigure1);
savedResids1 = zeros(length(xdata1), 2);
% 对残差排序
[sortedXdata1, xInd1] = sort(xdata1);

% 为“显示方程”系数预分配
coeffs1 = cell(2,1);

% 求多项式的系数(阶 = 4)
fitResults1 = polyfit(xdata1,ydata1,4);
% 计算多项式
yplot1 = polyval(fitResults1,xplot1);

% 保存“显示残差范数”和“显示方程”的拟合类型
fittypesArray1(1) = 5;

% 计算并保存残差 - 使用原始 xdata 进行计算
Yfit1 = polyval(fitResults1,xdata1);
resid1 = ydata1 - Yfit1(:);
savedResids1(:,1) = resid1(xInd1);
savedNormResids1(1) = norm(resid1);

% 保存“显示方程”的系数
coeffs1{1} = fitResults1;

% 绘制拟合图
fitLine1 = plot(xplot1,yplot1,'DisplayName','   4 次','XLimInclude','off',...
    'Tag','4th degree',...
    'Parent',axes1,...
    'MarkerSize',6,...
    'Color',[0.301 0.745 0.933]);

% 将新线条设置为适当位置
setLineOrder(axes1,fitLine1,scatter1);

% 求多项式的系数(阶 = 5)
fitResults1 = polyfit(xdata1,ydata1,5);
% 计算多项式
yplot2 = polyval(fitResults1,xplot1);

% 保存“显示残差范数”和“显示方程”的拟合类型
fittypesArray1(2) = 6;

% 计算并保存残差 - 使用原始 xdata 进行计算
Yfit1 = polyval(fitResults1,xdata1);
resid1 = ydata1 - Yfit1(:);
savedResids1(:,2) = resid1(xInd1);
savedNormResids1(2) = norm(resid1);

% 保存“显示方程”的系数
coeffs1{2} = fitResults1;

% 绘制拟合图
fitLine2 = plot(xplot1,yplot2,'DisplayName','   5 次','XLimInclude','off',...
    'Tag','5th degree',...
    'Parent',axes1,...
    'MarkerSize',6,...
    'Color',[0.635 0.078 0.184]);

% 将新线条设置为适当位置
setLineOrder(axes1,fitLine2,scatter1);

% 在条形图中绘制残差图
residPlot1 = bar(residAxes1, sortedXdata1, savedResids1);
% 设置与拟合线匹配的颜色并设置显示名称
set(residPlot1(1), 'facecolor', [0.301 0.745 0.933],'edgecolor', [0.301 0.745 0.933], ...
    'DisplayName', '4 次');
set(residPlot1(2), 'facecolor', [0.635 0.078 0.184],'edgecolor', [0.635 0.078 0.184], ...
    'DisplayName', '5 次');
% 设置残差图轴标题
title(residAxes1, '残差');
% 显示残差图的图例
legend(residAxes1, 'show');

% 已选定“显示残差范数”
showNormOfResiduals(residAxes1,fittypesArray1,savedNormResids1);

% 已选定“显示方程”
showEquations(fittypesArray1,coeffs1,5,axes1);

% 创建 ylabel
ylabel({'接收机钟差(m)'});

% 创建 xlabel
xlabel({'历元(s)'});

% 创建 title
title({'接收机钟差'});

% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes1,[517000 608000]);
box(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'TickLabelInterpreter','latex');
% 创建 legend
legend(axes1,'show');

%-------------------------------------------------------------------------%
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

%-------------------------------------------------------------------------%
function showNormOfResiduals(residaxes1, fittypes1, normResids1)
%SHOWNORMOFRESIDUALS(RESIDAXES1,FITTYPES1,NORMRESIDS1)
%  显示残差范数
%  RESIDAXES1:  残差的坐标区
%  FITTYPES1:  拟合类型
%  NORMRESIDS1:  残差范数

txt = cell(length(fittypes1) ,1);
for i = 1:length(fittypes1)
    txt{i,:} = getResidString(fittypes1(i),normResids1(i));
end
% 保存当前轴单位；然后设置为归一化单位
axesunits = get(residaxes1,'units');
set(residaxes1,'units','normalized');
text(.05,.95,txt,'parent',residaxes1, ...
    'verticalalignment','top','units','normalized');
% 重置单位
set(residaxes1,'units',axesunits);

%-------------------------------------------------------------------------%
function [s1] = getResidString(fittype1, normResid1)
%GETRESIDSTRING(FITTYPE1,NORMRESID1)
%  获取“显示残差范数”文本
%  FITTYPE1:  拟合类型
%  NORMRESID1:  残差范数

% 从消息目录中获取文本。
switch fittype1
    case 0
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplaySplineNorm'));
    case 1
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplayShapepreservingNorm'));
    case 2
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplayLinearNorm', num2str(normResid1)));
    case 3
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplayQuadraticNorm', num2str(normResid1)));
    case 4
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplayCubicNorm', num2str(normResid1)));
    otherwise
        s1 = getString(message('MATLAB:graph2d:bfit:ResidualDisplayNthDegreeNorm', fittype1-1, num2str(normResid1)));
end

%-------------------------------------------------------------------------%
function showEquations(fittypes1, coeffs1, digits1, axesh1)
%SHOWEQUATIONS(FITTYPES1,COEFFS1,DIGITS1,AXESH1)
%  显示方程
%  FITTYPES1:  拟合类型
%  COEFFS1:  系数
%  DIGITS1:  有效数字位数
%  AXESH1:  坐标区

n = length(fittypes1);
txt = cell(length(n + 1) ,1);
txt{1,:} = ' ';
for i = 1:n
    txt{i + 1,:} = getEquationString(fittypes1(i),coeffs1{i},digits1,axesh1);
end
text(.05,.95,txt,'parent',axesh1, ...
    'verticalalignment','top','units','normalized');

%-------------------------------------------------------------------------%
function [s1, a1] = getEquationString(fittype1, coeffs1, digits1, axesh1)
%GETEQUATIONSTRING(FITTYPE1,COEFFS1,DIGITS1,AXESH1)
%  获取“显示方程”文本
%  FITTYPE1:  拟合类型
%  COEFFS1:  系数
%  DIGITS1:  有效数字位数
%  AXESH1:  坐标区

if isequal(fittype1, 0)
    s1 = '三次样条插值';
elseif isequal(fittype1, 1)
    s1 = '保形插值';
else
    if isequal(fittype1, 2)
        a1 = '线性: ';
    elseif isequal(fittype1, 3)
        a1 = '二次: ';
    elseif isequal(fittype1, 4)
        a1 = '三次: ';
    elseif isequal(fittype1, 5)
        a1 = '4 次: ';
    elseif isequal(fittype1, 6)
        a1 = '5 次: ';
    elseif isequal(fittype1, 7)
        a1 = '6 次: ';
    elseif isequal(fittype1, 8)
        a1 = '7 次: ';
    elseif isequal(fittype1, 9)
        a1 = '8 次: ';
    elseif isequal(fittype1, 10)
        a1 = '9 次: ';
    elseif isequal(fittype1, 11)
        a1 = '10 次: ';
    end
    op = '+-';
    format1 = ['%s %0.',num2str(digits1),'g*x^{%s} %s'];
    format2 = ['%s %0.',num2str(digits1),'g'];
    xl = get(axesh1, 'xlim');
    fit =  fittype1 - 1;
    s1 = sprintf('%s y =',a1);
    th = text(xl*[.95;.05],1,s1,'parent',axesh1, 'vis','off');
    if abs(coeffs1(1) < 0)
        s1 = [s1 ' -'];
    end
    for i = 1:fit
        sl = length(s1);
        if ~isequal(coeffs1(i),0) % if exactly zero, skip it
            s1 = sprintf(format1,s1,abs(coeffs1(i)),num2str(fit+1-i), op((coeffs1(i+1)<0)+1));
        end
        if (i==fit) && ~isequal(coeffs1(i),0)
            s1(end-5:end-2) = []; % change x^1 to x.
        end
        set(th,'string',s1);
        et = get(th,'extent');
        if et(1)+et(3) > xl(2)
            s1 = [s1(1:sl) sprintf('\n     ') s1(sl+1:end)];
        end
    end
    if ~isequal(coeffs1(fit+1),0)
        sl = length(s1);
        s1 = sprintf(format2,s1,abs(coeffs1(fit+1)));
        set(th,'string',s1);
        et = get(th,'extent');
        if et(1)+et(3) > xl(2)
            s1 = [s1(1:sl) sprintf('\n     ') s1(sl+1:end)];
        end
    end
    delete(th);
    % Delete last "+"
    if isequal(s1(end),'+')
        s1(end-1:end) = []; % There is always a space before the +.
    end
    if length(s1) == 3
        s1 = sprintf(format2,s1,0);
    end
end

