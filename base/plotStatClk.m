function plotStatClk(YMatrix1)

figure1 = figure;
sz = 10;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot1 = scatter(YMatrix1(:,2),YMatrix1(:,5),15,'filled','r');
set(plot1,'DisplayName','\deltaClkG');
ylabel({'\delta t(m)'});
xlabel({'GPST(s)'});
title({'\delta clock'});
box(axes1,'on');
hold(axes1,'off');
legend(axes1,'show');
saveas(figure1,"Receiver Clock Error",'tiffn');

figure2 = figure;
sz = 10;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
plot2 = scatter(YMatrix1(:,2),YMatrix1(:,6),10,'filled','b');
set(plot2,'DisplayName','\deltaClkR');
ylabel({'\delta t(m)'});
xlabel({'GPST(s)'});
title({'\delta clock'});
box(axes2,'on');
hold(axes2,'off');
legend(axes2,'show');
saveas(figure2,"Receiver Clock Error system bias GR",'tiffn');

figure3 = figure;
sz = 10;
axes3 = axes('Parent',figure3);
hold(axes3,'on');
plot3 = scatter(YMatrix1(:,2),YMatrix1(:,7),10,'filled','b');
set(plot3,'DisplayName','\deltaClkR');
ylabel({'\delta t(m)'});
xlabel({'GPST(s)'});
title({'\delta clock'});
box(axes3,'on');
hold(axes3,'off');
legend(axes3,'show');
saveas(figure3,"Receiver Clock Error system bias GE",'tiffn');

figure4 = figure;
sz = 10;
axes4 = axes('Parent',figure4);
hold(axes4,'on');
plot4 = scatter(YMatrix1(:,2),YMatrix1(:,8),10,'filled','b');
set(plot4,'DisplayName','\deltaClkR');
ylabel({'\delta t(m)'});
xlabel({'GPST(s)'});
title({'\delta clock'});
box(axes4,'on');
hold(axes4,'off');
legend(axes4,'show');
saveas(figure4,"Receiver Clock Error system bias GB",'tiffn');