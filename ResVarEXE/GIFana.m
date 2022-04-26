function [outputArg1,outputArg2,outputArg3] = GIFana(data, strlist,ti)
%GIFANA 此处显示有关此函数的摘要
%   此处显示详细说明
CLIGHT = 299792458.0;
rdeg = pi/180;

if data.sys == "GPS"
    opsys = 'G';
    f(1) = 1575420000;
    f(2) = 1227600000;
    f(3) = 1176450000;
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "GAL"
    opsys = 'E'; 
    f(1) = 1575420000; %E1
    f(2) = 1207140000; %E5b
    f(3) = 1176450000; %E5a
    f(4) = 1278750000; %E6
    f(5) = 1191795000; %E5ab
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "GLO"
    opsys = 'R'; 
    f(1) = 1600875000;
    f(2) = 1245125000;
    f(3) = 1202025000;
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(3));
elseif data.sys == "BDS2"
    opsys = 'C'; 
    f(1) = 1561098000; %B1I
    f(2) = 1207140000; %B2I
    %f(3) = 0;
    f(3) = 1268520000; %B3
    str1 = char(strlist(1)); str2 = char(strlist(2)); str3 = char(strlist(4));
elseif data.sys == "BDS3"
    opsys = 'C';
    f(1) = 1575420000; %B1C
    %f(1) = 1561098000; %B1I
    %f(2) = 0;
    f(2) = 1176450000; %B2a
    f(3) = 1268520000; %B3
    %f(5) = 0;
    %f(6) = 1575420000; %B1C
     str1 = char(strlist(6)); str2 = char(strlist(3)); str3 = char(strlist(4)); 
end

l1 = f(1)/(f(1)+f(2)); m1 = f(2)/(f(1)+f(2)); n1 = 0;
l2 = f(1)/(f(1)+f(3)); m2 = 0;                n2 = f(3)/(f(1)+f(3));
l3 = f(1)*f(1) / (f(1)*f(1) - f(2)*f(2));
m3 = 0-(f(2)*f(2) / (f(1)*f(1) - f(2)*f(2)));
n3 = 0;
A = [l1 m1 n1; l2 m2 n2; l3 m3 n3];

LCt = ti;
nanMaskLC = isnan(data.pnl12) | isnan(data.wl12);
if any(nanMaskLC)
    data.pnl12(nanMaskLC) = [];
    data.wl12(nanMaskLC) = [];
    data.pnl13(nanMaskLC) = [];
    data.wl13(nanMaskLC) = [];
    data.pif12(nanMaskLC) = [];
    data.if12(nanMaskLC) = [];
    data.el(nanMaskLC) = [];
    data.snr(nanMaskLC,:) = [];
    LCt(nanMaskLC) = [];
end

len = length(LCt);
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

GIFnh = zeros(len,3); GIFres = zeros(len,3); GIFvar = zeros(len,3);
Pres = zeros(len,3); Pstd = zeros(len,3); Pcov = zeros(len,6);
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
    GIFvar(i,1) = sqrt(adpt_var(1,1)); GIFvar(i,2) = sqrt(adpt_var(2,2)); GIFvar(i,3) = sqrt(adpt_var(3,3));
    Pstd(i,1) = sqrt(VarCov(1,1)); Pstd(i,2) = sqrt(VarCov(2,2)); Pstd(i,3) = sqrt(VarCov(3,3));%P1 P2 P3
    Pcov(i,1) = VarCov(1,2); Pcov(i,2) = VarCov(1,3); Pcov(i,3) = VarCov(2,3);%P12 P12 P23
end
satid = sprintf("%s%02d",opsys, data.prn);
stopel = 10;
[max_res,min_res,mean_res,std_res, mean_cov] = anaPres(len, stopel, data.el, Pres, Pcov);
plottest(LCt, mw12, mw13, ifdif, GIFnh, GIFres, GIFvar, Pres, Pstd, Pcov, satid, str1, str2, str3);
%[b,bint,r,rint,stats] = regress(mw12(i),x);
%输出标准差，往后拟合用
outputArg1 = Pres;
outputArg2 = Pstd;
outputArg3 = LCt;
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
function plottest(ti, mw12, mw13, ifdif23, GIFnh, GIFres, GIFvar, Pres, Pvar, Pcov, satid, str1, str2, str3)
left = ti(1) - 50;
right = ti(end) +50;

str_mw12 = sprintf("%s&%s MW组合",str1(2:3), str2(2:3));
str_mw13 = sprintf("%s&%s MW组合",str1(2:3), str3(2:3));
str_ifd12 =sprintf("%s&%s IFGF组合", str1(2:3), str2(2:3));

figure1 = figure;

subplot(3,2,1);
hold('on');
scatter(ti,mw12,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,1), 'Color', 'r', 'LineWidth',1.5);
title(str_mw12+"拟合");
ylabel("观测值(m)");
xlabel({"历元(s)",'(a)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,3);
hold('on');
scatter(ti,mw13,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,2), 'Color', 'r', 'LineWidth',1.5);
title(str_mw13+"拟合");
ylabel("观测值(m)");
xlabel({"历元(s)",'(b)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,5);
hold('on');
scatter(ti,ifdif23,5,'filled','b');
%plot(ti, mw12, 'DisplayName', 'MW', 'Color', 'b');
plot(ti, GIFnh(:,3), 'Color', 'r', 'LineWidth',1.5);
title(str_ifd12+"拟合");
ylabel("观测值(m)");
xlabel({"历元(s)",'(c)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,2);
hold('on');
residPlot1 = bar(ti,GIFres(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), GIFvar(:,1),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
%,'LineStyle',':', 'Color','r',
title(str_mw12+"拟合残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(d)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,4);
hold('on');
residPlot1 = bar(ti,GIFres(:,2));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), GIFvar(:,2),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
title(str_mw13+"拟合残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(e)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,6);
hold('on');
residPlot1 = bar(ti,GIFres(:,3));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), GIFvar(:,3),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
title(str_ifd12+"残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(f)'});
xlim([left right]);
grid('on');
box('on');
hold('off');


outname = sprintf("%s三频GIF组合与拟合结果", satid);
saveas(figure1, "tifs\"+outname, 'tiffn');
savefig(figure1, "tifs\"+outname);
close(figure1);

figure3 = figure;
subplot(3,2,1);
hold('on');
residPlot1 = bar(ti,Pres(:,1));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), Pvar(:,1),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
title(str1(2:3)+"残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(a)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,2);
hold('on');
plot(ti(:,1), Pcov(:,1),...
    'LineStyle', '-', 'Color','b', 'LineWidth', 1);
title(str1(2:3)+"&"+str2(2:3)+"协方差");
ylabel("协方差(m)");
xlabel({"历元(s)",'(b)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,3);
hold('on');
residPlot1 = bar(ti,Pres(:,2));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), Pvar(:,2),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
title("残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(c)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,4);
hold('on');
plot(ti(:,1), Pcov(:,2),...
    'LineStyle', '-', 'Color','b', 'LineWidth', 1);
title(str1(2:3)+"&"+str3(2:3)+"协方差");
xlim([left right]);
ylabel("协方差(m)");
xlabel({"历元(s)",'(d)'});
grid('on');
box('on');
hold('off');

subplot(3,2,5);
hold('on');
residPlot1 = bar(ti,Pres(:,3));
set(residPlot1(1), 'facecolor', 'b','edgecolor', 'b',...
    'LineWidth',0.3);
plot(ti(:,1), Pvar(:,3),...
    'LineStyle', '-', 'Color','r', 'LineWidth', 1.5);
title(str3(2:3)+"残差与标准差");
ylabel("残差/标准差(m)");
xlabel({"历元(s)",'(e)'});
xlim([left right]);
grid('on');
box('on');
hold('off');

subplot(3,2,6);
hold('on');
plot(ti(:,1), Pcov(:,3),...
    'LineStyle', '-', 'Color','b', 'LineWidth', 1);
title(str2(2:3)+"&"+str3(2:3)+"协方差");
ylabel("协方差(m)");
xlabel({"历元(s)",'(f)'});
xlim([left right]);
grid('on');
box('on');
hold('off');
outname = sprintf("%s三频GIF组合伪距观测值残差与方差及协方差", satid);
saveas(figure3, "tifs\"+outname, 'tiffn');
savefig(figure3, "tifs\"+outname);
close(figure3);

end