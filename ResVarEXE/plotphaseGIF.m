function [outputArg1,outputArg2] = plotphaseGIF(test)
%PLOTPHASEGIF 此处显示有关此函数的摘要
%   此处显示详细说明

%[test.C3.GIF, test.C3.t, test.C3.polyGIF, test.C3.resGIF, test.C3.meanGIF, test.C3.stdGIF, test.C3.stdPH] = phaseGIF(test.C3,ti);
figure1 = myfigure;

subplot(3,3,1)
plotGIFnh(test.G,'(a)');
subplot(3,3,2)
plotGIFnh(test.R,'(b)');
subplot(3,3,3)
plotGIFnh(test.E,'(c)');

subplot(3,3,4)
plotGIFres(test.G,'(d)');
subplot(3,3,5)
plotGIFres(test.R,'(e)');
subplot(3,3,6)
plotGIFres(test.E,'(f)');

subplot(3,3,7)
plotPHstd(test.G,'(g)');
subplot(3,3,8)
plotPHstd(test.R,'(h)');
subplot(3,3,9)
plotPHstd(test.E,'(i)');

outname = sprintf("GRE相位GIF");
savefig(figure1, "tifs\"+outname);
saveas(figure1, "tifs\"+outname, 'tiffn');
close(figure1);

figure2 = myfigure;

subplot(3,3,1)
plotGIFnh(test.C2g,'(a)');
subplot(3,3,2)
plotGIFnh(test.C2i,'(b)');
subplot(3,3,3)
plotGIFnh(test.C3,'(c)');

subplot(3,3,4)
plotGIFres(test.C2g,'(d)');
subplot(3,3,5)
plotGIFres(test.C2i,'(e)');
subplot(3,3,6)
plotGIFres(test.C3,'(f)');

subplot(3,3,7)
plotPHstd(test.C2g,'(g)');
subplot(3,3,8)
plotPHstd(test.C2i,'(h)');
subplot(3,3,9)
plotPHstd(test.C3,'(i)');

outname = sprintf("北斗相位GIF");
savefig(figure2, "tifs\"+outname);
saveas(figure2, "tifs\"+outname, 'tiffn');
close(figure2);


outputArg1 = 0;
outputArg2 = 0;

%max min std mean
end

%%
function plotGIFnh(data, num)
left = data.t(1,1)-50;
right = data.t(end,1)+50;
hold on;
scatter(data.t(:,1),data.GIF(:,1),10,'b','+');
plot(data.t(:,1),data.polyGIF(:,1), ...   
    'LineStyle','-','LineWidth',1.2,...
    'MarkerSize',4,...
    'Color','r');
ylabel("观测值(m)");
xlabel({"历元(s)",num});
ttl = sprintf("%s%02d 相位GIF组合拟合",data.sys,data.prn);
title(ttl);
xlim([left right]);
box('on');
grid('on');
hold('off');
end

%%
function plotGIFres(data, num)
left = data.t(1,1)-50;
right = data.t(end,1)+50;
hold on;
residPlot1 = bar(data.t(:,1),data.resGIF(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(data.t(:,1),data.meanGIF(:,1),...
    'LineStyle','-','LineWidth',1,...
    'Color','k');        %'Parent',axes1,...
plot(data.t(:,1),data.stdGIF(:,1),...
     'LineStyle','-','LineWidth',1.5,...
     'Color','r');% 'Parent',axes1,...'DisplayName',disname_std,...
ylabel("残差/标准差(m)");
xlabel({"历元(s)",num});
ttl = sprintf("%s%02d 相位GIF拟合残差",data.sys,data.prn);
title(ttl);
xlim([left right]);
box('on');
grid('on');
hold('off');
end

%%
function plotPHstd(data,num)
satid = sprintf("%s%02d",data.sys, data.prn);
elr = elreg(data.pel, data.stdPH, satid);
hold on;
scatter(data.pel(:,1),data.stdPH(:,1),8,'b','+');
plot(data.pel(:,1), elr(:,1),'r','LineWidth',1.3,...
    'LineStyle','-');
ylabel("标准差(m)");
xlabel({"高度角(°)",num});
ttl = sprintf("%s%02d 相位标准差",data.sys,data.prn);
title(ttl);
box('on');
grid('on');
hold('off');

end

%%
function [elr] = elreg(el, stdph, satid)
rdeg = pi/180;
len = length(el);
elr = zeros(len,1);
Dsinel = zeros(len,1);
for i = 1:len
    Dsinel(i,1) = 1/sin(el(i)*rdeg);
end

Xel = [ones(size(Dsinel)) Dsinel ];
b1 = regress(stdph(:,1), Xel);
regreTable = table;
regreTable.b_sinel(:,1) = b1;
writetable(regreTable,satid+'regPh.txt');

for i = 1:len
    elr(i,1) = b1(1,1) + b1(2,1)*Dsinel(i,1);
end
end

