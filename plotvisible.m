function plotvisible(ne, ns, obsd, ti, sys)
%PLOTVISIBLE 此处显示有关此函数的摘要
%   此处显示详细说明
freqlist = obsd.freqlist;
for i = 1:ns
    for j = 1: ne
        for k = 1:6
            GNSS.sat(i).frn(j,k) = nan;
        end        
    end
end

for i = 1:ns
    for j = 1: ne
        rec = -0.3;
        if freqlist(1) ~= 0
            if isnan(obsd.p1(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,1) = i-rec;
                rec = rec-0.15;
            end 
        end
        if freqlist(2) ~= 0
            if isnan(obsd.p2(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,2) = i-rec;
                rec = rec-0.15;
            end 
        end
        if freqlist(3) ~= 0
            if isnan(obsd.p3(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,3) = i-rec;
                rec = rec-0.15;
            end 
        end
        if freqlist(4) ~= 0
            if isnan(obsd.p4(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,4) = i-rec;
                rec = rec-0.15;
            end 
        end
        if freqlist(5) ~= 0
            if isnan(obsd.p5(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,5) = i-rec;
                rec = rec-0.15;
            end 
        end
        if freqlist(6) ~= 0
            if isnan(obsd.p6(j,i))
                continue;
            else
                GNSS.sat(i).frn(j,6) = i-rec;
                rec = rec-0.15;
            end 
        end        
    end 
end

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
RGB1 = cbrewer('qual', 'Dark2', 6, 'linear');
legendindex = zeros(1,6);
lgid = 1;
for i = 1:ns
    for k = 1:6
        if freqlist(k) ~= 0
            plot(ti,GNSS.sat(i).frn(:, k),...
                'LineWidth', 1.5,...
                'Color', RGB1(k,:));%...'DisplayName',obsd.str(k));
            if legendindex(1,k) == 0
                str(lgid) = obsd.str(k);
                lgid = lgid +1;
                %lgd = ;
                %legend(sprintf(str));
                legendindex(1,k) = 1;
            end
        end
    end
end
legend(str, 'Location', 'bestoutside', 'Orientation', 'horizontal');
%ti(:,1),
ylabel('PRN');
xlabel('历元(30s)');
tit = sprintf('%s卫星频段可视情况', sys);
title(tit);
box(axes1,'on');
hold(axes1,'off');
grid('on');
xlim([517500 605500]);
%ylim([0.3 ns+0.3]);
%legend('show');
savefig(figure1, "tifs\"+sys+"\"+tit);
saveas(figure1, "tifs\"+sys+"\"+tit, 'tiffn');

end

