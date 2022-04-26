function plotlegend(ns, sys, PRNList)
GEOsats = [1 2 3 4 5 59 60 61];
IGSOsats = [6 7 8 9 10 13 16 31 38 39 40 56];

if sys == "GPS"
    opsys = 'G';
elseif sys == "GAL"
    opsys = 'E'; 
elseif sys == "GLO"
    opsys = 'R'; 
elseif sys == "BDS2"
    opsys = 'C'; 
elseif sys == "BDS3"
    opsys = 'C ';
end
if sys ~= "BDS2" && sys ~= "BDS3"
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
    
    a = zeros(2, ns)*nan;
    b = [1 ; 2];
    sz = 2;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    for i = 1:ns
        if PRNList(i) ~= 0
        lgdi = sprintf('%s%02d',opsys,PRNList(i));
        scatter(b(:,1), a(:,i),sz,'filled',...
            'MarkerEdgeColor','none','DisplayName',lgdi,...
            'MarkerFaceColor', RGB1(plist(i), :)); 
        end
    end
    
    grid('on');
    box(axes1,'on');
    hold(axes1,'off');
    legend1 = legend(axes1,'show');
    set(legend1,'Orientation','horizontal','NumColumns',6,'Interpreter','latex',...
        'FontSize',6,...
        'Location','best');
    
    saveas(figure1, "tifs\"+sys+"\"+opsys+"LEGEND", 'tiffn');
    close(figure1);
else
    plistGEO = PRNList;
    plistIGSO= PRNList;
    plistMEO = PRNList;
    for i = 1 : ns
        if ismember(PRNList(i), GEOsats) == 1
            plistGEO(i) = PRNList(i);
            plistIGSO(i) = 0;
            plistMEO(i) = 0;
        elseif ismember(PRNList(i), IGSOsats) == 1
            plistGEO(i) = 0;
            plistIGSO(i) = PRNList(i);
            plistMEO(i) = 0;
        else
            plistGEO(i) = 0;
            plistIGSO(i) = 0;
            plistMEO(i) = PRNList(i);
        end
    end
    
    nplot = 0;
    plist = plistGEO;
    for i = 1:ns
        if plistGEO(i) ~= 0
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
    a = zeros(2, ns)*nan;
    b = [1 ; 2];
    sz = 2;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    for i = 1:ns
        if plistGEO(i) ~= 0
        lgdi = sprintf('%s%02d',opsys,plistGEO(i));
        scatter(b(:,1), a(:,i),sz,'filled',...
            'MarkerEdgeColor','none','DisplayName',lgdi,...
            'MarkerFaceColor', RGB1(plist(i), :)); 
        end
    end
    grid('on');
    box(axes1,'on');
    hold(axes1,'off');
    legend1 = legend(axes1,'show');
    set(legend1,'Orientation','horizontal','NumColumns',6,'Interpreter','latex',...
        'FontSize',6,...
        'Location','best');
    
    saveas(figure1, "tifs\"+sys+"\"+opsys+"geo-LEGEND", 'tiffn');
    close(figure1);
    
    nplot = 0;
    plist = plistIGSO;
    for i = 1:ns
        if plistIGSO(i) ~= 0
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
    a = zeros(2, ns)*nan;
    b = [1 ; 2];
    sz = 2;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    for i = 1:ns
        if plistIGSO(i) ~= 0
        lgdi = sprintf('%s%02d',opsys,plistIGSO(i));
        scatter(b(:,1), a(:,i),sz,'filled',...
            'MarkerEdgeColor','none','DisplayName',lgdi,...
            'MarkerFaceColor', RGB1(plist(i), :)); 
        end
    end
    grid('on');
    box(axes1,'on');
    hold(axes1,'off');
    legend1 = legend(axes1,'show');
    set(legend1,'Orientation','horizontal','NumColumns',6,'Interpreter','latex',...
        'FontSize',6,...
        'Location','best');
    saveas(figure1, "tifs\"+sys+"\"+opsys+"igso-LEGEND", 'tiffn');
    close(figure1);    
    
    nplot = 0;
    plist = plistMEO;
    for i = 1:ns
        if plistMEO(i) ~= 0
            nplot = nplot +1;
            plist(i) = nplot;
        end
    end
    RGB1 = cbrewer('div', 'RdYlBu', nplot, 'linear');
    figure1 = figure;
    a = zeros(2, ns)*nan;
    b = [1 ; 2];
    sz = 2;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    for i = 1:ns
        if plistMEO(i) ~= 0
        lgdi = sprintf('%s%02d',opsys,plistMEO(i));
        scatter(b(:,1), a(:,i),sz,'filled',...
            'MarkerEdgeColor','none','DisplayName',lgdi,...
            'MarkerFaceColor', RGB1(plist(i), :)); 
        end
    end
    grid('on');
    box(axes1,'on');
    hold(axes1,'off');
    legend1 = legend(axes1,'show');
    set(legend1,'Orientation','horizontal','NumColumns',6,'Interpreter','latex',...
        'FontSize',6,...
        'Location','best');
    
    saveas(figure1, "tifs\"+sys+"\"+opsys+"meo-LEGEND", 'tiffn');
    close(figure1);
end