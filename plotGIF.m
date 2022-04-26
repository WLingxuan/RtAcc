function [outputArg1,outputArg2] = plotGIF(data, ti)
%PLOTGIF 此处显示有关此函数的摘要
%   此处显示详细说明
% freq1 = 1.57542E9;          % L1
% freq2 = 1.22760E9;          % L2         frequency (Hz) */
% freq5 = 1.17645E9;          % L5/E5a/B2a frequency (Hz) */
% freq6 = 1.27875E9;          % E6/L6      frequency (Hz) */
% freq7 = 1.20714E9;          % E5b        frequency (Hz) */
% freq8 = 1.191795E9;         % E5a+b/B5ab frequency (Hz) */
% freq1_r = 1.60200E9;        % GLONASS G1 base frequency (Hz) */
% dfreq1_r = 0.56250E6;       % GLONASS G1 bias frequency (Hz/n) */
% freq2_GLO = 1.24600E9;      % GLONASS G2 base frequency (Hz) */
% dfreq2_GLO = 0.43750E6;     % GLONASS G2 bias frequency (Hz/n) */
% freq3_GLO = 1.202025E9;     % GLONASS G3 frequency (Hz) */
% freq1a_GLO = 1.600995E9;    % GLONASS G1a frequency (Hz) */
% freq2a_GLO = 1.248060E9;    % GLONASS G2a frequency (Hz) */
% freq1_CMP = 1.561098E9;     % BDS B1I     frequency (Hz) */
% freq2_CMP = 1.20714E9;      % BDS B2I/B2b frequency (Hz) */
% freq3_CMP = 1.26852E9;      % BDS B3      frequency (Hz) */

%%
nf = 0; f = zeros(nf,1);
CLIGHT = 299792458.0;
rdeg = pi/180;
for i = 1 : 6
    nf = nf + data.freqlist(i);
end
usedfre = zeros(1, 6);
di = 0;
if data.sys == "GPS"
    opsys = 'G';
    f(1) = 1575420000;
    f(2) = 1227600000;
    f(3) = 1176450000;
    str_mw12 = "1C&2W MW组合";
    str_mw13 = "1C&5Q MW组合";
    str_ifd12 = "1C&2W IFGF组合";
elseif data.sys == "GAL"
    opsys = 'E'; 
    f(1) = 1575420000; %E1
    f(2) = 1207140000; %E5b
    f(3) = 1176450000; %E5a
    f(4) = 1278750000; %E6
    f(5) = 1191795000; %E5ab
    str_mw12 = "1C&7Q MW组合";
    str_mw13 = "1C&5Q MW组合";
    str_ifd12 = "1C&7Q IFGF组合";
elseif data.sys == "GLO"
    opsys = 'R'; 
    f(1) = 1600875000;
    f(2) = 1245125000;
    f(3) = 1202025000;
    str_mw12 = "1C&2P MW组合";
    str_mw13 = "1C&3Q MW组合";
    str_ifd12 = "1C&2P IFGF组合";    
elseif data.sys == "BDS2"
    opsys = 'C'; 
    f(1) = 1561098000; %B1I
    f(2) = 1207140000; %B2I
    %f(3) = 0;
    f(3) = 1268520000; %B3
    str_mw12 = "2I&7I MW组合";
    str_mw13 = "2I&6I MW组合";
    str_ifd12 = "2I&7I IFGF组合";    

elseif data.sys == "BDS3"
    opsys = 'C ';
    f(1) = 1575420000; %B1C
    %f(1) = 1561098000; %B1I
    %f(2) = 0;
    f(2) = 1176450000; %B2a
    f(3) = 1268520000; %B3
    %f(5) = 0;
    %f(6) = 1575420000; %B1C
    str_mw12 = "1P&5P MW组合";
    str_mw13 = "1P&6I MW组合";
    str_ifd12 = "1P&5P IFGF组合";    
end

l1 = f(1)/(f(1)+f(2)); m1 = f(2)/(f(1)+f(2)); n1 = 0;
l2 = f(1)/(f(1)+f(3)); m2 = 0;                n2 = f(3)/(f(1)+f(3));
l3 = f(1)*f(1) / (f(1)*f(1) - f(2)*f(2));
m3 = 0-f(2)*f(2) / (f(1)*f(1) - f(2)*f(2));
n3 = 0;
A = [l1 m1 n1; l2 m2 n2; l3 m3 n3];

nanMask = isnan(data.pnl12) | isnan(data.wl12);
if any(nanMask)
    data.pnl12(nanMask) = [];
    data.wl12(nanMask) = [];
    data.pnl13(nanMask) = [];
    data.wl13(nanMask) = [];
    data.pif12(nanMask) = [];
    data.if12(nanMask) = [];
    data.el(nanMask) = [];
    data.snr(nanMask,:) = [];
    ti(nanMask) = [];
end
len = length(ti);
lam_wl12 = CLIGHT/(f(1)-f(2));
lam_wl13 = CLIGHT/(f(1)-f(3));
mw12=zeros(len,1); mw13 = zeros(len,1); ifdif = zeros(len,1);
sinelT = zeros(len,1); snr = zeros(len,1); sinelT2 = zeros(len,1);
for i = 1 : len
    mw12(i) = data.pnl12(i)-data.wl12(i)*lam_wl12;
    mw13(i) = data.pnl13(i)-data.wl13(i)*lam_wl13;
    ifdif(i) = data.pif12(i) - data.if12(i);
    sinelT(i) = 1/sin((data.el(i))*rdeg);
    sinelT2(i) = (1/sin((data.el(i))*rdeg)).^2;
    %snr(i) = data.snr(i);
end

wnds = 15; cure = 0;
%tempsize = 0;t = 3;

GIFnh = zeros(len,3); GIFres = zeros(len,3); Pres = zeros(len,3);
restest = zeros(len,3); Pvarcov = zeros(len,6);
for i = 1:len
    if i <= wnds
        %tempsize = i + wnds;
        tem_rspd = zeros(i+wnds,3);
        tem_rspd(:,1) = mw12(1:(i+wnds),1);
        tem_rspd(:,2) = mw13(1:(i+wnds),1);
        tem_rspd(:,3) = ifdif(1:(i+wnds),1);
        cure = i;
    elseif i > len-wnds
        %tempsize = len-i+wnds+1;
        tem_rspd = zeros(len-i+wnds+1,3);
        tem_rspd(:,1) = mw12((i-wnds):end,1);
        tem_rspd(:,2) = mw13((i-wnds):end,1);
        tem_rspd(:,3) = ifdif((i-wnds):end,1);
        cure = wnds+1;
    else
        %tempsize = 2*wnds + 1;
        tem_rspd = zeros(2*wnds + 1,3);
        tem_rspd(:,1) = mw12((i-wnds):(i+wnds),1);
        tem_rspd(:,2) = mw13((i-wnds):(i+wnds),1);
        tem_rspd(:,3) = ifdif((i-wnds):(i+wnds),1);
        cure = wnds+1;
    end
    t = 4;
    err = zeros(t,1);
    regout = table;
    for j = 1:t
        [err(j),regout(j,:)] = multi_reg(tem_rspd,j,cure); 
    end
    minerr = min(err(:,1));
    pos_min = find(err == minerr);
    
    [~, adpt_regout, adpt_var] = multi_reg(tem_rspd, pos_min(1), cure);
    
    for j = 1:3
        GIFnh(i,j) = adpt_regout.Hmiu(1,j);
        GIFres(i,j) = adpt_regout.delt(1,j);        
    end
    restest(i,1) = mw12(i,1) - GIFnh(i,1);
    restest(i,2) = mw13(i,1) - GIFnh(i,2);
    restest(i,3) = ifdif(i,1) - GIFnh(i,3);
    Pres(i,:) = A \ GIFres(i,:).';
    VarCov = inv(A) * adpt_var * (inv(A).');
    Pvarcov(i,1) = VarCov(1,1); Pvarcov(i,2) = VarCov(2,2); Pvarcov(i,3) = VarCov(3,3);%P1 P2 P3
    Pvarcov(i,4) = VarCov(1,2); Pvarcov(i,5) = VarCov(1,3); Pvarcov(i,6) = VarCov(2,3);%P12 P12 P23
end
satid = sprintf("%s%2d",opsys, data.prn);
plottest(ti, mw12, mw13, ifdif, GIFnh, GIFres, Pres, satid, str_mw12, str_mw13, str_ifd12);
%[b,bint,r,rint,stats] = regress(mw12(i),x);

outputArg1 = 0;
outputArg2 = 0;
end

%%
function [err,regout,keseiG] = multi_reg(Y,t,i)
[len,d] = size(Y);
x = (1:len);
H = ones(len,t+1);
for j = 1:len
    for k = 1:t
        H(j, k+1) = x(j).^(k);
    end
end
miu = zeros(t+1, d);
xs = (inv(H.'*H))*H.';
miu = xs*Y;
Hmiu = H * miu;
delt = Y - H*miu;
sz = [len 2];
regout = table;
regout.Hmiu = Hmiu(i,:);
regout.delt = delt(i,:);
%regout = table(Hmiu(i,:), delt(i,:));
%nhrst = Hmiu(i,:);
%nhres = delt(i,:);

keseiG = (delt.' * delt)/(len-t);%len
err = 0;
for j = 1:len
    for k = 1:d
        err = err + delt(j,k);
    end
end

end                                                   

%%
function plottest(ti, mw12, mw13, ifdif23, GIFnh, GIFres, Pres, satid, str_mw12, str_mw13, str_ifd12)
left = ti(1) - 50;
right = ti(end) +50;

figure1 = figure;

subplot(3,1,1);
hold('on');
scatter(ti,mw12,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,1), 'Color', 'r', 'LineWidth',1.5);
title(satid+" "+str_mw12+"与拟合结果");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,2);
hold('on');
scatter(ti,mw13,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,2), 'Color', 'r', 'LineWidth',1.5);
title(satid+" "+str_mw13+"与拟合结果");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,3);
hold('on');
scatter(ti,ifdif23,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,3), 'Color', 'r', 'LineWidth',1.5);
title(satid+" "+str_ifd12+"与拟合结果");
xlim([left right]);
grid('on');
box('on');
hold('off');

outname = sprintf("%s三频GIF组合与拟合结果", satid);
saveas(figure1, "tifs\"+outname, 'tiffn');
savefig(figure1, "tifs\"+outname);
close(figure1);

figure2 = figure;
subplot(3,1,1);
hold('on');
residPlot1 = bar(ti,GIFres(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" "+str_mw12+"拟合残差");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,2);
hold('on');
residPlot1 = bar(ti,GIFres(:,2));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" "+str_mw13+"拟合残差");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,3);
hold('on');
residPlot1 = bar(ti,GIFres(:,3));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" "+str_ifd12+"拟合残差");
xlim([left right]);
grid('on');
box('on');
hold('off');
saveas(figure2, "tifs\"+outname, 'tiffn');
savefig(figure2, "tifs\"+outname);
close(figure2);

figure3 = figure;
subplot(3,1,1);
hold('on');
residPlot1 = bar(ti,Pres(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" L1残差");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,2);
hold('on');
residPlot1 = bar(ti,Pres(:,2));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" L2残差");
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,1,3);
hold('on');
residPlot1 = bar(ti,Pres(:,3));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
title(satid+" L3残差");
xlim([left right]);
grid('on');
box('on');
hold('off');

saveas(figure3, "tifs\"+outname, 'tiffn');
savefig(figure3, "tifs\"+outname);
close(figure3);

end



