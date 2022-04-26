function plotTrop(YMatrix1)

figure1 = figure;
sz = 10;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot1 = scatter(YMatrix1(:,2),YMatrix1(:,5),15,'filled','r');
set(plot1,'DisplayName','trop delay');
ylabel({'delay (m)'});
xlabel({'GPST(s)'});
title({'trop delay'});
box(axes1,'on');
hold(axes1,'off');
legend(axes1,'show');


figure2 = figure;
sz = 10;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
plot2 = scatter(YMatrix1(:,2),YMatrix1(:,6),10,'filled','b');
set(plot2,'DisplayName','trop var');
ylabel({'(m`2)'});
xlabel({'GPST(s)'});
title({'trop delay variance'});
box(axes2,'on');
hold(axes2,'off');
legend(axes2,'show');