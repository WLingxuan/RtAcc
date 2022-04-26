function [outGIF,outt,polyGIF,resGIF,meanGIF,stdGIF,stdPH,outel] = phaseGIF(data,ti)
%PHASEGIF 此处显示有关此函数的摘要
%   此处显示详细说明
CLIGHT = 299792458.0;

f1 = data.f1;
f2 = data.f2;
f3 = data.f3;

lamd1 = CLIGHT/f1;
lamd2 = CLIGHT/f2;
lamd3 = CLIGHT/f3;

a = (f3*f3-f1*f1)*f2*f2/((f2*f2-f1*f1)*f3*f3);
alpha = -a-1;
beta  = a;

GIF = alpha*data.L1*lamd1+beta*data.L2*lamd2+data.L3*lamd3;
outel = data.el;
nanMask = isnan(GIF(:,1));
if any(nanMask)
    GIF(nanMask,:) = [];
    ti(nanMask,:) = [];
    outel(nanMask,:) = [];
end

len = length(GIF);
c = (1:len);
fitfun = polyfit(c,GIF(:,1),7);
polyGIF(:,1) = polyval(fitfun,c);
residual(:,1) = GIF - polyGIF;
[meanGIF(:,1), stdGIF(:,1)] = calmeanstd(residual(:,1), 20);
stdPH = stdGIF / sqrt((alpha*lamd1).^(2)+(beta*lamd2).^(2)+(lamd3).^(3));
%stdPH = stdGIF.^(2) / (alpha*lamd1).^(2)+(beta*lamd2).^(2)+(lamd3).^(3);
outGIF = GIF;
resGIF = residual;
outt = ti;
end

%%
function [meanvec, stdvec] = calmeanstd(delt, wnds)
len = length(delt);
meanvec = zeros(len, 1)*nan;
stdvec = zeros(len,1)*nan;

for i = 1 : len
    tempvec = [];
    if isnan(delt(i))
        meanvec(i) = nan;
        stdvec(i) = nan;
        continue;
    end    
    if i <= wnds
        tempvec = delt(1:(i+wnds), 1);
    elseif i > len-wnds
        tempvec = delt((i-wnds):end, 1);
    else
        tempvec = delt((i-wnds):(i+wnds),1);        
    end
    meanvec(i) = mean(tempvec, 'omitnan');
    stdvec(i) = std(tempvec,'omitnan');    
end
end