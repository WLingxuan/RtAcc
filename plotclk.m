function plotclk(clkfile, n)

fid = fopen(clkfile, 'r');
clki = 1;
time = zeros(n,1);
clk_m = zeros(n,4); clk_mstd = zeros(n,4);
clk_s = zeros(n,4); 
delt = zeros(n,1);

if fid > 0
    while ~feof(fid)
        buff = fgetl(fid);
        if buff(1:4) == "$CLK"
            temp = regexp(buff,'\s+', 'split');
            time(clki) = str2double(temp(1, 3));
            if clki > 1
                delt(clki) = time(clki) - time(clki-1);
            end
            clk_m(clki, 1:4) = str2double(temp(1, 6:9));
            clk_mstd(clki, 1:4) = str2double(temp(1,11:14));
            clk_s(clki, 1:4) = str2double(temp(1, 16:19));
            clki = clki + 1;
        end  
    end    
end
fclose(fid);

figure1 = figure;
%sz = 10;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
%plot1 = scatter(time(:,1),clk_m(:,1),15,'filled');%, [246 83 20]
scatter1 = scatter(time(:,1),clk_m(:,1),8,'filled',...
    'MarkerEdgeColor','none','DisplayName','接收机钟差',...
    'MarkerFaceColor',[231/255 76/255 60/255]);

ylabel({'接收机钟差(m)'});
xlabel({'历元(s)'});
%title({'接收机钟差'});
xlim(axes1, [517500 605500]);
grid('on');
box(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'TickLabelInterpreter','latex');
legend(axes1,'show');
saveas(figure1,"tifs\接收机钟差(m)",'tiffn');

figure2 = figure;
sz = 8;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
%plot1 = scatter(time(:,1),clk_m(:,1),15,'filled');%, [246 83 20]
scatter2 = scatter(time(:,1),clk_m(:,2), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-R',...
    'MarkerFaceColor',[52/255 152/255 219/255]);%rgb(52, 152, 219)
scatter2 = scatter(time(:,1),clk_m(:,3), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-E',...
    'MarkerFaceColor',[46/255 204/255 113/255]);%rgb(46, 204, 113)
scatter2 = scatter(time(:,1),clk_m(:,4), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-C',...
    'MarkerFaceColor',[241/255 196/255 15/255]);%rgb(241, 196, 15)
ylabel({'系统间偏差(m)'});
xlabel({'历元(s)'});
%title({'接收机钟差'});
xlim(axes2, [517500 605500]);
grid('on');
box(axes2,'on');
hold(axes2,'off');
% 设置其余坐标区属性
set(axes2,'TickLabelInterpreter','latex');
legend(axes2,'show');
saveas(figure2,"tifs\系统间偏差（m）",'tiffn');

figure3 = figure;
sz = 8;
axes3 = axes('Parent',figure3);
hold(axes3,'on');
%plot1 = scatter(time(:,1),clk_m(:,1),15,'filled');%, [246 83 20]
scatter3 = scatter(time(:,1),clk_mstd(:,1), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','接收机钟差标准差',...
    'MarkerFaceColor',[231/255 76/255 60/255]);
scatter3 = scatter(time(:,1),clk_mstd(:,2), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-R标准差',...
    'MarkerFaceColor',[52/255 152/255 219/255]);
scatter3 = scatter(time(:,1),clk_mstd(:,3), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-E标准差',...
    'MarkerFaceColor',[46/255 204/255 113/255]);
scatter3 = scatter(time(:,1),clk_mstd(:,4), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-C标准差',...
    'MarkerFaceColor',[241/255 196/255 15/255]);
ylabel({'标准差(m)'});
xlabel({'历元(s)'});
title({'接收机钟差与系统间偏差的标准差'});
xlim(axes3, [517500 605500]);
grid('on');
box(axes3,'on');
hold(axes3,'off');
% 设置其余坐标区属性
set(axes3,'TickLabelInterpreter','latex');
legend(axes3,'show');
saveas(figure3,"tifs\接收机钟差与系统间偏差的标准差",'tiffn');

figure4 = figure;
%sz = 10;
axes4 = axes('Parent',figure4);
hold(axes4,'on');
%plot1 = scatter(time(:,1),clk_m(:,1),15,'filled');%, [246 83 20]
scatter4 = scatter(time(:,1),clk_s(:,1),8,'filled',...
    'MarkerEdgeColor','none','DisplayName','接收机钟差',...
    'MarkerFaceColor',[231/255 76/255 60/255]);
ylabel({'接收机钟差(ns)'});
xlabel({'历元(s)'});
%title({'接收机钟差'});
xlim(axes4, [517500 605500]);
grid('on');
box(axes4,'on');
hold(axes4,'off');
% 设置其余坐标区属性
set(axes4,'TickLabelInterpreter','latex');
legend(axes4,'show');
saveas(figure4,"tifs\接收机钟差(ns)",'tiffn');

figure5 = figure;
sz = 8;
axes5 = axes('Parent',figure5);
hold(axes5,'on');
%plot1 = scatter(time(:,1),clk_m(:,1),15,'filled');%, [246 83 20]
scatter5 = scatter(time(:,1),clk_s(:,2), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-R',...
    'MarkerFaceColor',[52/255 152/255 219/255]);
scatter5 = scatter(time(:,1),clk_s(:,3), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-E',...
    'MarkerFaceColor',[46/255 204/255 113/255]);
scatter5 = scatter(time(:,1),clk_s(:,4), sz,'filled',...
    'MarkerEdgeColor','none','DisplayName','ISB G-C',...
    'MarkerFaceColor',[241/255 196/255 15/255]);
ylabel({'系统间偏差(ns)'});
xlabel({'历元(s)'});
%title({'接收机钟差'});
xlim(axes5, [517500 605500]);
grid('on');
box(axes5,'on');
hold(axes5,'off');
% 设置其余坐标区属性
set(axes5,'TickLabelInterpreter','latex');
legend(axes5,'show');
saveas(figure5,"tifs\系统间偏差（ns）",'tiffn');
