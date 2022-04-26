function plotStat(Gres, Rres, Eres, Cres, name)

grtitle = "GPS " + name;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter(Gres(:,1), Gres(:,2),5,'filled');
scatter(Gres(:,1), Gres(:,3),5,'filled');
scatter(Gres(:,1), Gres(:,4),5,'filled');
scatter(Gres(:,1), Gres(:,5),5,'filled');
scatter(Gres(:,1), Gres(:,6),5,'filled');
scatter(Gres(:,1), Gres(:,7),5,'filled');
scatter(Gres(:,1), Gres(:,8),5,'filled');
scatter(Gres(:,1), Gres(:,9),5,'filled');
scatter(Gres(:,1), Gres(:,10),5,'filled');
scatter(Gres(:,1), Gres(:,11),5,'filled');
scatter(Gres(:,1), Gres(:,12),5,'filled');
scatter(Gres(:,1), Gres(:,13),5,'filled');
scatter(Gres(:,1), Gres(:,14),5,'filled');
scatter(Gres(:,1), Gres(:,15),5,'filled');
scatter(Gres(:,1), Gres(:,16),5,'filled');
scatter(Gres(:,1), Gres(:,17),5,'filled');
scatter(Gres(:,1), Gres(:,18),5,'filled');
scatter(Gres(:,1), Gres(:,19),5,'filled');
scatter(Gres(:,1), Gres(:,20),5,'filled');
scatter(Gres(:,1), Gres(:,21),5,'filled');
scatter(Gres(:,1), Gres(:,22),5,'filled');
scatter(Gres(:,1), Gres(:,23),5,'filled');
scatter(Gres(:,1), Gres(:,24),5,'filled');
scatter(Gres(:,1), Gres(:,25),5,'filled');
scatter(Gres(:,1), Gres(:,26),5,'filled');
scatter(Gres(:,1), Gres(:,27),5,'filled');
scatter(Gres(:,1), Gres(:,28),5,'filled');
scatter(Gres(:,1), Gres(:,29),5,'filled');
scatter(Gres(:,1), Gres(:,30),5,'filled');
scatter(Gres(:,1), Gres(:,31),5,'filled');
scatter(Gres(:,1), Gres(:,32),5,'filled');
scatter(Gres(:,1), Gres(:,33),5,'filled');

axis([-inf, inf, -20, 20]);
ylabel({'residuals(m)'});
xlabel({'GPST(s)'});
title(grtitle);
box(axes1,'on');
hold(axes1,'off');
legend({'G01','G02','G03','G04','G05','G06','G07','G08','G09','G10',...
        'G11','G12','G13','G14','G15','G16','G17','G18','G19','G20',...
        'G21','G22','G23','G24','G25','G26','G27','G28','G29','G30',...
        'G31','G32'},'Location','southoutside','NumColumns',7, ...
         'EdgeColor',[1 1 1],'FontSize',5);
legend(axes1,'show');
saveas(figure1,grtitle,'tiffn');

%set(gca,'xticklabel',get(gca,'xtick'),'yticklabel',get(gca,'ytick'));

rrtitle = "Glonass " + name;
figure2 = figure;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
scatter(Rres(:,1), Rres(:,2),5,'filled');
scatter(Rres(:,1), Rres(:,3),5,'filled');
scatter(Rres(:,1), Rres(:,4),5,'filled');
scatter(Rres(:,1), Rres(:,5),5,'filled');
scatter(Rres(:,1), Rres(:,6),5,'filled');
scatter(Rres(:,1), Rres(:,7),5,'filled');
scatter(Rres(:,1), Rres(:,8),5,'filled');
scatter(Rres(:,1), Rres(:,9),5,'filled');
scatter(Rres(:,1), Rres(:,10),5,'filled');
scatter(Rres(:,1), Rres(:,11),5,'filled');
scatter(Rres(:,1), Rres(:,12),5,'filled');
scatter(Rres(:,1), Rres(:,13),5,'filled');
scatter(Rres(:,1), Rres(:,14),5,'filled');
scatter(Rres(:,1), Rres(:,15),5,'filled');
scatter(Rres(:,1), Rres(:,16),5,'filled');
scatter(Rres(:,1), Rres(:,17),5,'filled');
scatter(Rres(:,1), Rres(:,18),5,'filled');
scatter(Rres(:,1), Rres(:,19),5,'filled');
scatter(Rres(:,1), Rres(:,20),5,'filled');
scatter(Rres(:,1), Rres(:,21),5,'filled');
scatter(Rres(:,1), Rres(:,22),5,'filled');
scatter(Rres(:,1), Rres(:,23),5,'filled');
scatter(Rres(:,1), Rres(:,24),5,'filled');
scatter(Rres(:,1), Rres(:,25),5,'filled');
scatter(Rres(:,1), Rres(:,26),5,'filled');
scatter(Rres(:,1), Rres(:,27),5,'filled');
scatter(Rres(:,1), Rres(:,28),5,'filled');

axis([-inf, inf, -20, 20]);
ylabel({'residuals(m)'});
xlabel({'GPST(s)'});
title({rrtitle});
box(axes2,'on');
hold(axes2,'off');
legend({'R01','R02','R03','R04','R05','R06','R07','R08','R09','R10',...
        'R11','R12','R13','R14','R15','R16','R17','R18','R19','R20',...
        'R21','R22','R23','R24','R25','R26','R27'},'Location','southoutside', ...
        'NumColumns',7, 'EdgeColor',[1 1 1],'FontSize',5);
legend(axes2,'show');
saveas(figure2,rrtitle,'tiffn');

ertitle = "Galieo " + name;
figure3 = figure;
axes3 = axes('Parent',figure3);
hold(axes3,'on');
scatter(Eres(:,1), Eres(:,2),5,'filled');
scatter(Eres(:,1), Eres(:,3),5,'filled');
scatter(Eres(:,1), Eres(:,4),5,'filled');
scatter(Eres(:,1), Eres(:,5),5,'filled');
scatter(Eres(:,1), Eres(:,6),5,'filled');
scatter(Eres(:,1), Eres(:,7),5,'filled');
scatter(Eres(:,1), Eres(:,8),5,'filled');
scatter(Eres(:,1), Eres(:,9),5,'filled');
scatter(Eres(:,1), Eres(:,10),5,'filled');
scatter(Eres(:,1), Eres(:,11),5,'filled');
scatter(Eres(:,1), Eres(:,12),5,'filled');
scatter(Eres(:,1), Eres(:,13),5,'filled');
scatter(Eres(:,1), Eres(:,14),5,'filled');
scatter(Eres(:,1), Eres(:,15),5,'filled');
scatter(Eres(:,1), Eres(:,16),5,'filled');
scatter(Eres(:,1), Eres(:,17),5,'filled');
scatter(Eres(:,1), Eres(:,18),5,'filled');
scatter(Eres(:,1), Eres(:,19),5,'filled');
scatter(Eres(:,1), Eres(:,20),5,'filled');
scatter(Eres(:,1), Eres(:,21),5,'filled');
scatter(Eres(:,1), Eres(:,22),5,'filled');
scatter(Eres(:,1), Eres(:,23),5,'filled');
scatter(Eres(:,1), Eres(:,24),5,'filled');
scatter(Eres(:,1), Eres(:,25),5,'filled');
scatter(Eres(:,1), Eres(:,26),5,'filled');
scatter(Eres(:,1), Eres(:,27),5,'filled');
scatter(Eres(:,1), Eres(:,28),5,'filled');
scatter(Eres(:,1), Eres(:,29),5,'filled');
scatter(Eres(:,1), Eres(:,30),5,'filled');
scatter(Eres(:,1), Eres(:,31),5,'filled');
scatter(Eres(:,1), Eres(:,32),5,'filled');
scatter(Eres(:,1), Eres(:,33),5,'filled');
scatter(Eres(:,1), Eres(:,34),5,'filled');
scatter(Eres(:,1), Eres(:,35),5,'filled');
scatter(Eres(:,1), Eres(:,36),5,'filled');
scatter(Eres(:,1), Eres(:,37),5,'filled');
axis([-inf, inf, -20, 20]);
ylabel({'residuals(m)'});
xlabel({'GPST(s)'});
title(ertitle);
box(axes3,'on');
hold(axes3,'off');
legend({'E01','E02','E03','E04','E05','E06','E07','E08','E09','E10',...
        'E11','E12','E13','E14','E15','E16','E17','E18','E19','E20',...
        'E21','E22','E23','E24','E25','E26','E27','E28','E29','E30',...
        'E31','E32','E33','E34','E35','E36'},'Location','southoutside', ...
        'NumColumns',7, 'EdgeColor',[1 1 1],'FontSize',5);
legend(axes3,'show');
saveas(figure3,ertitle,'tiffn');

brtitle = "BDS " + name;
figure4 = figure;
axes4 = axes('Parent',figure4);
hold(axes4,'on');
scatter(Cres(:,1), Cres(:,2),5,'filled');
scatter(Cres(:,1), Cres(:,3),5,'filled');
scatter(Cres(:,1), Cres(:,4),5,'filled');
scatter(Cres(:,1), Cres(:,5),5,'filled');
scatter(Cres(:,1), Cres(:,6),5,'filled');
scatter(Cres(:,1), Cres(:,7),5,'filled');
scatter(Cres(:,1), Cres(:,8),5,'filled');
scatter(Cres(:,1), Cres(:,9),5,'filled');
scatter(Cres(:,1), Cres(:,10),5,'filled');
scatter(Cres(:,1), Cres(:,11),5,'filled');
scatter(Cres(:,1), Cres(:,12),5,'filled');
scatter(Cres(:,1), Cres(:,13),5,'filled');
scatter(Cres(:,1), Cres(:,14),5,'filled');
scatter(Cres(:,1), Cres(:,15),5,'filled');
scatter(Cres(:,1), Cres(:,16),5,'filled');
scatter(Cres(:,1), Cres(:,17),5,'filled');
scatter(Cres(:,1), Cres(:,18),5,'filled');
scatter(Cres(:,1), Cres(:,19),5,'filled');
scatter(Cres(:,1), Cres(:,20),5,'filled');
scatter(Cres(:,1), Cres(:,21),5,'filled');
scatter(Cres(:,1), Cres(:,22),5,'filled');
scatter(Cres(:,1), Cres(:,23),5,'filled');
scatter(Cres(:,1), Cres(:,24),5,'filled');
scatter(Cres(:,1), Cres(:,25),5,'filled');
scatter(Cres(:,1), Cres(:,26),5,'filled');
scatter(Cres(:,1), Cres(:,27),5,'filled');
scatter(Cres(:,1), Cres(:,28),5,'filled');
scatter(Cres(:,1), Cres(:,29),5,'filled');
scatter(Cres(:,1), Cres(:,30),5,'filled');
scatter(Cres(:,1), Cres(:,31),5,'filled');
scatter(Cres(:,1), Cres(:,32),5,'filled');
scatter(Cres(:,1), Cres(:,33),5,'filled');
scatter(Cres(:,1), Cres(:,34),5,'filled');
scatter(Cres(:,1), Cres(:,35),5,'filled');
scatter(Cres(:,1), Cres(:,36),5,'filled');
scatter(Cres(:,1), Cres(:,37),5,'filled');
scatter(Cres(:,1), Cres(:,38),5,'filled');
scatter(Cres(:,1), Cres(:,39),5,'filled');
scatter(Cres(:,1), Cres(:,40),5,'filled');
scatter(Cres(:,1), Cres(:,41),5,'filled');
scatter(Cres(:,1), Cres(:,42),5,'filled');
scatter(Cres(:,1), Cres(:,43),5,'filled');
scatter(Cres(:,1), Cres(:,44),5,'filled');
scatter(Cres(:,1), Cres(:,45),5,'filled');
scatter(Cres(:,1), Cres(:,46),5,'filled');
scatter(Cres(:,1), Cres(:,47),5,'filled');
scatter(Cres(:,1), Cres(:,48),5,'filled');
scatter(Cres(:,1), Cres(:,49),5,'filled');
scatter(Cres(:,1), Cres(:,50),5,'filled');
scatter(Cres(:,1), Cres(:,51),5,'filled');
scatter(Cres(:,1), Cres(:,52),5,'filled');
scatter(Cres(:,1), Cres(:,53),5,'filled');
scatter(Cres(:,1), Cres(:,54),5,'filled');
scatter(Cres(:,1), Cres(:,55),5,'filled');
scatter(Cres(:,1), Cres(:,56),5,'filled');
scatter(Cres(:,1), Cres(:,57),5,'filled');
scatter(Cres(:,1), Cres(:,58),5,'filled');
scatter(Cres(:,1), Cres(:,59),5,'filled');
scatter(Cres(:,1), Cres(:,60),5,'filled');
scatter(Cres(:,1), Cres(:,61),5,'filled');
scatter(Cres(:,1), Cres(:,62),5,'filled');
scatter(Cres(:,1), Cres(:,63),5,'filled');
scatter(Cres(:,1), Cres(:,64),5,'filled');
axis([-inf, inf, -20, 20]);
ylabel({'residuals(m)'});
xlabel({'GPST(s)'});
title(brtitle);
box(axes4,'on');
hold(axes4,'off');
legend({'C01','C02','C03','C04','C05','C06','C07','C08','C09','C10',...
        'C11','C12','C13','C14','C15','C16','C17','C18','C19','C20',...
        'C21','C22','C23','C24','C25','C26','C27','C28','C29','C30',...
        'C31','C32','C33','C34','C35','C36','C37','C38','C39','C40',...
        'C41','C42','C43','C44','C45','C46','C47','C48','C49','C50',...
        'C51','C52','C53','C54','C55','C56','C57','C58','C59','C60',...
        'C61','C62','C63'},'Location','southoutside', ...
        'NumColumns',7, 'EdgeColor',[1 1 1],'FontSize',5);
legend(axes4,'show');
saveas(figure4,brtitle,'tiffn');
