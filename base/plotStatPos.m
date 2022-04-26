function plotStatPos(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  y 数据的矩阵
%  由 MATLAB 于 11-Mar-2021 15:10:36 自动生成
% 创建 figure
figure1 = figure;
sz = 10;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% 使用 plot 的矩阵输入创建多行
plot1 = scatter(YMatrix1(:,2),YMatrix1(:,7),15,'filled','r');
plot2 = scatter(YMatrix1(:,2),YMatrix1(:,7),10,'filled','b');
plot3 = scatter(YMatrix1(:,2),YMatrix1(:,9),5,'filled','g');
set(plot1,'DisplayName','\deltaE');
set(plot2,'DisplayName','\deltaN');
set(plot3,'DisplayName','\deltaU');

% 创建 ylabel
ylabel({'\delta enu(m)'});

% 创建 xlabel
xlabel({'GPST(s)'});

% 创建 title
title({'\delta enu'});

box(axes1,'on');
hold(axes1,'off');
% 创建 legend
legend(axes1,'show');
saveas(figure1, "position error ENU", 'tiffn');

