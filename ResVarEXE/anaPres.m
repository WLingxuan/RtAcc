function [max_res,min_res,mean_res,std_res, mean_cov] = anaPres(len, stopel, el, Pres, Pcov)
%ANAPRES 此处显示有关此函数的摘要
%   此处显示详细说明
n = 0;
start_ep = 0;
end_ep = 0;
for i = 1:len
    if el(i) < stopel
        continue;
    elseif el(i) >=stopel && start_ep == 0
        n = n+1;
        start_ep = i;
    else
        n = n+1;
        end_ep = i;        
    end    
end

anaEl = el(start_ep:end_ep,1);
anaPres = Pres(start_ep:end_ep,:);
anaPcov = Pcov(start_ep:end_ep,:);

max_res = max(anaPres);
min_res = min(anaPres);
mean_res = mean(anaPres);
mean_cov = mean(anaPcov);
std_res(1) = sqrt(var(anaPres(:,1)));
std_res(2) = sqrt(var(anaPres(:,2)));
std_res(3) = sqrt(var(anaPres(:,3)));
end

