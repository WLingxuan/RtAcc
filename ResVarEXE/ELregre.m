function [outputArg1] = ELregre(ti,el_,snr_, Polyvar, Diffvar, Pvar, fstr, sys, prn)
%ELREGRE 此处显示有关此函数的摘要
%   此处显示详细说明
len = length(ti);
rdeg = pi/180;
satid = sprintf("%s%02d",sys(1,1),prn);

if sys == "G"
    freqused = [1 2 3];
elseif sys == "E"
    freqused = [1 2 3];
elseif sys == "R"
    freqused = [1 2 3];
elseif sys == "C2"
    freqused = [1 2 4];
elseif sys == "C3"
    freqused = [6 3 4];
end

el = el_;
snr = snr_;
nanMaskLC = isnan(el);
if any(nanMaskLC)
    el(nanMaskLC) = [];
    snr(nanMaskLC,:) = [];
end

Dsinel = zeros(len,1); Dsinel2 = zeros(len,1);
Dsnr = zeros(len,1);

for i = 1:len
    Dsinel(i,1) = 1 / sin(el(i) * rdeg);
    Dsinel2(i,1) = Dsinel(i,1) * Dsinel(i,1);
    for j = 1:3
        Dsnr(i,j) = 10.^(-snr(i,freqused(j))/10);
    end
end

Xel = [ones(size(Dsinel)) Dsinel ];
Xel_ = [ones(size(Dsinel)) Dsinel Dsinel2];
Xsnr1 = [ones(size(Dsnr(:,1))) Dsnr(:,1) ];
Xsnr2 = [ones(size(Dsnr(:,2))) Dsnr(:,2) ];
Xsnr3 = [ones(size(Dsnr(:,3))) Dsnr(:,3) ];

b1 = regress(Pvar(:,1), Xel);
b2 = regress(Pvar(:,2), Xel);
b3 = regress(Pvar(:,3), Xel);

c1 = regress(Pvar(:,1), Xsnr1);
c2 = regress(Pvar(:,2), Xsnr2);
c3 = regress(Pvar(:,3), Xsnr3);

d1 = regress(Pvar(:,1), Xel_);
d2 = regress(Pvar(:,2), Xel_);
d3 = regress(Pvar(:,3), Xel_);

regreTable = table;
regreTable.b_sinel(:,1) = b1;
regreTable.b_sinel(:,2) = b2;
regreTable.b_sinel(:,3) = b3;
regreTable.c_snr(:,1) = c1;
regreTable.c_snr(:,2) = c2;
regreTable.c_snr(:,3) = c3;
outputArg1 = regreTable;
writetable(regreTable,satid+'reg.txt');
regresults = zeros(len,3);  snrrst = zeros(len,3);  el2rst = zeros(len,3);

for i = 1:len
    regresults(i,1) = b1(1,1) + b1(2,1)*Dsinel(i,1);
    regresults(i,2) = b2(1,1) + b2(2,1)*Dsinel(i,1);
    regresults(i,3) = b3(1,1) + b3(2,1)*Dsinel(i,1);
        
    snrrst(i,1) = c1(1,1) +c1(2,1)*Dsnr(i,1); 
    snrrst(i,2) = c2(1,1) +c2(2,1)*Dsnr(i,2); 
    snrrst(i,3) = c3(1,1) +c3(2,1)*Dsnr(i,3); 
    
    el2rst(i,1) = d1(1,1) + d1(2,1)*Dsinel(i,1) + d1(3,1) * Dsinel2(i,1);
    el2rst(i,2) = d2(1,1) + d2(2,1)*Dsinel(i,1) + d2(3,1) * Dsinel2(i,1);
    el2rst(i,3) = d3(1,1) + d3(2,1)*Dsinel(i,1) + d3(3,1) * Dsinel2(i,1);
end

RGB1 = cbrewer('seq', 'Greys', 8, 'linear');

%%
%test
figure1 = figure;
subplot(3,1,1);
hold on;
scatter(el(2:end,1), Diffvar(:,1), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,1),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,1),  6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), snrrst(:,1),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '多元回归信噪比标准差模型');
plot(el(:,1), regresults(:,1),'b','LineWidth',1.8,...
    'DisplayName', '多元回归高度角标准差模型');
title(fstr(1,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(a)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');

subplot(3,1,2);
hold on;
scatter(el(2:end,1), Diffvar(:,2), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,2),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,2),  6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), regresults(:,2),'b','LineWidth',1.8,...
    'DisplayName', '多元回归高度角标准差模型');
plot(el(:,1), snrrst(:,2),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '多元回归信噪比标准差模型');
title(fstr(2,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(b)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');


subplot(3,1,3);
hold on;
scatter(el(2:end,1), Diffvar(:,3), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,3),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,3),  6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), snrrst(:,3),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '多元回归信噪比标准差模型');
plot(el(:,1), regresults(:,3),'b','LineWidth',1.8,...
    'DisplayName', '多元回归高度角标准差模型');
title(fstr(3,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(c)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');

outname = sprintf("%s高度角、信噪比标准差回归", satid);
saveas(figure1, "tifs\"+outname, 'tiffn');
savefig(figure1, "tifs\"+outname);
%close(figure1);








figure2 = figure;
subplot(3,1,1);
hold on;
scatter(el(2:end,1), Diffvar(:,1), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,1),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,1),  6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), snrrst(:,1),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '信噪比标准差模型');
plot(el(:,1), regresults(:,1),'b','LineWidth',1.8,...
    'DisplayName', '高度角标准差模型');
plot(el(:,1), el2rst(:,1),'y','LineWidth',1.8,...
    'DisplayName', '二次高度角标准差模型');
title(satid+" "+fstr(1,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(a)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');

subplot(3,1,2);
hold on;
scatter(el(2:end,1), Diffvar(:,2), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,2),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,2),  6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), snrrst(:,2),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '信噪比标准差模型');
plot(el(:,1), regresults(:,2),'b','LineWidth',1.8,...
    'DisplayName', '高度角标准差模型');
plot(el(:,1), el2rst(:,2),'y','LineWidth',1.8,...
    'DisplayName', '二次高度角标准差模型');
title(satid+" "+fstr(2,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(a)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');

subplot(3,1,3);
hold on;
scatter(el(2:end,1), Diffvar(:,3), 8, RGB1(4,:),'+',...
    'DisplayName', 'CC组合历元间差分标准差');
scatter(el(:,1), Polyvar(:,3),6, RGB1(5,:),'filled','^',...
    'DisplayName', 'CC组合拟合标准差');
scatter(el(:,1), Pvar(:,3), 6, RGB1(7,:),'filled','o',...
    'DisplayName', '三频GIF组合回归标准差');
plot(el(:,1), snrrst(:,3),'r','LineWidth',1.3,...
    'LineStyle',':', ...
    'DisplayName', '信噪比标准差模型');
plot(el(:,1), regresults(:,3),'b','LineWidth',1.8,...
    'DisplayName', '高度角标准差模型');
plot(el(:,1), el2rst(:,3),'y','LineWidth',1.8,...
    'DisplayName', '二次高度角标准差模型');
title(satid+" "+fstr(3,2:3)+"高度角与信噪比标准差回归模型");
legend('show','FontSize',6);
xlabel({'高度角(°)','(a)'});
ylabel('标准差(m)');
%ylim([0 1]);
grid('on');
box('on');
hold('off');

outname = sprintf("%s二次高度角、信噪比标准差回归", satid);
saveas(figure2, "tifs\"+outname, 'tiffn');
savefig(figure2, "tifs\"+outname);
%close(figure2);
end

