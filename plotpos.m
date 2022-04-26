function plotpos(posfile, POS_R, n)

fid = fopen(posfile, 'r');
%data = [];
time = zeros(n,1);
pos_enu = zeros(n, 3);
pos_enustd = zeros(n,3);
denu = zeros(n,3);
i = 1;

if fid>0
    while ~feof(fid)
        buff = fgetl(fid);
        if buff == ""
          continue;
        elseif buff(1) == '%'
          continue;
        end
        temp = regexp(buff,'\s+', 'split');
        time(i) = str2double(temp(1, 3));
        pos_enu(i,:) = str2double(temp(11:13));
        pos_enustd(i,:) = str2double(temp(14:16));
        i = i+1;
    end
end
fclose(fid);

denu = m_pos2dxyz([m_d2r(pos_enu(:,1)), m_d2r(pos_enu(:,2)), pos_enu(:,3)], POS_R);

%%
figure1 = figure;
sz = 8;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
scatter1 = scatter(time(:,1), pos_enustd(:,1),sz,'filled','MarkerEdgeColor','none','DisplayName','东向标准差','MarkerFaceColor',[231/255 76/255 60/255]);
scatter1 = scatter(time(:,1), pos_enustd(:,2),sz,'filled','MarkerEdgeColor','none','DisplayName','北向标准差','MarkerFaceColor',[52/255 152/255 219/255]);
scatter1 = scatter(time(:,1), pos_enustd(:,3),sz,'filled','MarkerEdgeColor','none','DisplayName','垂向标准差','MarkerFaceColor',[46/255 204/255 113/255]);

ylabel({'位置标准差(m)'});
xlabel({'历元(s)'});
% 取消以下行的注释以保留坐标区的 X 范围
 xlim(axes1,[517500 605500]);
% 取消以下行的注释以保留坐标区的 Y 范围
ylim(axes1,[0 1.1]);
 grid('on');
box(axes1,'on');
hold(axes1,'off');
legend(axes1,'show');
saveas(figure1, "tifs\位置标准差(m)", 'tiffn');
%%
figure2 = figure;
sz = 8;
axes2 = axes('Parent',figure2);
hold(axes2,'on');
scatter2 = scatter(time(:,1), denu(:,1),sz,'filled','MarkerEdgeColor','none','DisplayName','东向RMS','MarkerFaceColor',[231/255 76/255 60/255]);
scatter2 = scatter(time(:,1), denu(:,2),sz,'filled','MarkerEdgeColor','none','DisplayName','北向RMS','MarkerFaceColor',[52/255 152/255 219/255]);
scatter2 = scatter(time(:,1), denu(:,3),sz,'filled','MarkerEdgeColor','none','DisplayName','垂向RMS','MarkerFaceColor',[46/255 204/255 113/255]);

ylabel({'位置RMS(m)'});
xlabel({'历元(s)'});
% 取消以下行的注释以保留坐标区的 X 范围
xlim(axes2,[517500 605500]);
% 取消以下行的注释以保留坐标区的 Y 范围
%ylim(axes1,[0 1.1]);
 grid('on');
box(axes2,'on');
hold(axes2,'off');
legend(axes2,'show');
saveas(figure2, "tifs\位置RMS(m)", 'tiffn');