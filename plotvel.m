function plotvel(velfile, n)

fid = fopen(velfile, 'r');
time = zeros(n,1);
vel_enu = zeros(n, 3);
vel_enustd = zeros(n,3);
i = 1;

if fid>0
    while ~feof(fid)
        buff = fgetl(fid);
        temp = regexp(buff,'\s+', 'split');
        time(i) = str2double(temp(1, 3));
        vel_enu(i,:) = str2double(temp(14:16));
        vel_enustd(i,:) = str2double(temp(17:19));
        i = i+1;
    end
end
fclose(fid);


%%
figure1 = figure;
sz = 8;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter1 = scatter(time(:,1), vel_enu(:,3),sz,'filled','MarkerEdgeColor','none','DisplayName','垂向速度','MarkerFaceColor',[46/255 204/255 113/255]);
scatter1 = scatter(time(:,1), vel_enu(:,1),sz,'filled','MarkerEdgeColor','none','DisplayName','东向速度','MarkerFaceColor',[231/255 76/255 60/255]);
scatter1 = scatter(time(:,1), vel_enu(:,2),sz,'filled','MarkerEdgeColor','none','DisplayName','北向速度','MarkerFaceColor',[52/255 152/255 219/255]);

ylabel({'速度(m/s)'});
xlabel({'历元(s)'});
% 取消以下行的注释以保留坐标区的 X 范围
 xlim(axes1,[517500 605500]);
 grid('on');
box(axes1,'on');
hold(axes1,'off');
legend(axes1,'show');
saveas(figure1, "tifs\速度", 'tiffn');
%%
figure2 = figure;
sz = 8;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
scatter2 = scatter(time(:,1), vel_enustd(:,1),sz,'filled','MarkerEdgeColor','none','DisplayName','东向速度标准差','MarkerFaceColor',[231/255 76/255 60/255]);
scatter2 = scatter(time(:,1), vel_enustd(:,2),sz,'filled','MarkerEdgeColor','none','DisplayName','北向速度标准差','MarkerFaceColor',[52/255 152/255 219/255]);
scatter2 = scatter(time(:,1), vel_enustd(:,3),sz,'filled','MarkerEdgeColor','none','DisplayName','垂向速度标准差','MarkerFaceColor',[46/255 204/255 113/255]);

ylabel({'速度标准差(m/s)'});
xlabel({'历元(s)'});
% 取消以下行的注释以保留坐标区的 X 范围
xlim(axes2,[517500 605500]);
 grid('on');
box(axes2,'on');
hold(axes2,'off');
legend(axes2,'show');
saveas(figure2, "tifs\速度标准差", 'tiffn');