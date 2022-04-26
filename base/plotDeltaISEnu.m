function plotDeltaISEnu(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  y 数据的矩阵
%  由 MATLAB 于 11-Mar-2021 15:10:36 自动生成
% 创建 figure

figure1 = figure;
sz = 10;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter(YMatrix1(:,2), YMatrix1(:,8),5,'filled','r');
scatter(YMatrix1(:,2), YMatrix1(:,9),5,'filled','g');
scatter(YMatrix1(:,2), YMatrix1(:,10),5,'filled','b');

ylabel({'\delta enu variance(m^2)'});
xlabel({'GPST(s)'});
title({'\delta enu variance(m^2)'});

% 取消以下行的注释以保留坐标区的 X 范围
 xlim(axes1,[517500 605500]);
% 取消以下行的注释以保留坐标区的 Y 范围
 ylim(axes1,[0 1.1]);
  grid('on');
box(axes1,'on');
hold(axes1,'off');
legend(axes1,'show');
legend("\delta E", "\delta N", "\delta U");
saveas(figure1, "\delta ENU variance(m^2)", 'tiffn');
%set('DisplayName','\deltaE---');
legend({'E','N','U'});
legend(axes1,'show');
saveas(figure1,"Position ENU Error variance",'tiffn');
