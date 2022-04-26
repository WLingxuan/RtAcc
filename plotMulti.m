function plotMulti(nf, ti, ss1, ss2, ss3, ss4, ss5, ss6, str1, str2, str3,str4, str5, str6, idx1, idx2, idx3, idx4, idx5, idx6, ns,  sys, name, ci, PRNList)

ni = 1; endidx = 0;

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
        RGB1(i,:) = [1/i 0 0/i];
    end
end
figure1 = figure;

if idx1 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    else
        ni = ni + 1;
    end
    
    hold on;
    for i = 1:ns
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss1(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end        
    end
    ttl = sprintf('%s %s%s',sys,str1,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    axes
    hold off;
end

if idx2 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    else
        ni = ni + 1;
    end
    hold on;
    for i = 1:ns    
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss2(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end   
    end
    ttl = sprintf('%s %s%s',sys,str2,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    hold off;
end

if idx3 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    else
        ni = ni + 1;
    end
    hold on;
    for i = 1:ns    
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss3(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end   
    end
    ttl = sprintf('%s %s%s',sys,str3,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    hold off;
end

if idx4 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    else
        ni = ni + 1;
    end
    hold on;
    for i = 1:ns    
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss4(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end           
    end
    ttl = sprintf('%s %s%s',sys,str4,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    hold off;
end

if idx5 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    else
        ni = ni + 1;
    end
    hold on;
    for i = 1:ns 
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss5(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end  
    end
    ttl = sprintf('%s %s%s',sys,str5,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    hold off;
end

if idx6 == 1 && endidx ~= 1
    subplot(nf, 1, ni);
    if ni == nf
        endidx =1;
    end
    hold on;
    for i = 1:ns    
        if PRNList(i) ~= 0
            scatter(ti(:,1), ss6(:,i),2,'filled', 'MarkerEdgeColor','none', 'MarkerFaceColor', RGB1(plist(i), :));
        end 
    end
    ttl = sprintf('%s %s%s',sys,str6,name);
    title(ttl);
    ylabel({name});
    xlim([517500 605500]);
    grid('on');
    box('on');
    if endidx == 1
        xlabel({'历元(s)'});
    end
    hold off;
end
if ci == 1
    saveas(figure1, "tifs\"+sys+"\"+sys+name, 'tiffn');
    close(figure1);
else
    savefig(figure1, "tifs\"+sys+"\"+sys+name);
end



