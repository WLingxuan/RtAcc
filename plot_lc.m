function plot_lc(ti, lc, ns, sys, ttl, name, PRNList)

nplot = 0;
plist = PRNList;
for i = 1:ns
    if PRNList(i) ~= 0
        nplot = nplot +1;
        plist(i) = nplot;
    end
end
RGB1 = zeros(nplot, 3);
if nplot>2
    RGB1 = cbrewer('div', 'RdYlBu', nplot, 'linear');
else
    for i = 1 : nplot
        RGB1(i,:) = [0.999/i 0.999/i 0.999/i];
    end
end


figure1 = figure;
sz = 2;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
for i = 1:ns
    if PRNList(i) ~= 0
        scatter(ti(:,1), lc(:,i),sz,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
    end   
end
ttlo = sprintf('%s %s %s', sys, ttl, name);
title(ttlo);
ylabel(name);
xlabel({'历元(s)'});
% 取消以下行的注释以保留坐标区的 X 范围
xlim(axes1,[517500 605500]);
grid('on');
box(axes1,'on');
hold(axes1,'off');
%legend(axes1,'show');
saveas(figure1, "tifs\"+sys+"\"+sys+ttl+name, 'tiffn');
close(figure1);