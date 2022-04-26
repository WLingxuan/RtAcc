function obsdata = getobs(satf, len, ns)
%GETOBS 此处显示有关此函数的摘要
%   此处显示详细说明

fidx1 = 0; fidx2 = 0; fidx3 = 0; fidx4 = 0; fidx5 = 0; fidx6 = 0;
freq_str1(2:3) = 'C'; freq_str2(2:3)= 'C'; freq_str3(2:3)= 'C';freq_str4(2:3)= 'C'; freq_str5(2:3)= 'C'; freq_str6(2:3)= 'C';
PRNList = zeros(1, ns); 
az = zeros(len,ns)*nan; el = zeros(len,ns)*nan; ti = zeros(len, 1);

psdr1 = zeros(len, ns) * nan; phas1 = zeros(len, ns) * nan;
psdr2 = zeros(len, ns) * nan; phas2 = zeros(len, ns) * nan;
psdr3 = zeros(len, ns) * nan; phas3 = zeros(len, ns) * nan;
psdr4 = zeros(len, ns) * nan; phas4 = zeros(len, ns) * nan;
psdr5 = zeros(len, ns) * nan; phas5 = zeros(len, ns) * nan;
psdr6 = zeros(len, ns) * nan; phas6 = zeros(len, ns) * nan;

epoch = 0;
preEphTime = 0;


fid = fopen(satf, 'r');
if fid > 0
    while ~feof(fid)        
        buff = fgetl(fid);
        temp = regexp(buff,'\s+', 'split');
        time = str2double(temp(1, 3));
        satid = char(temp(1, 5));
        prn = str2double(satid(2:end));
        if epoch == 0
            epoch = epoch + 1;
            preEphTime = time;
        elseif time - preEphTime > 0
            epoch = epoch + 1;
            preEphTime = time;            
        end
        ti(epoch, 1) = time;
        az(epoch, prn) = str2double(temp(1,9));
        el(epoch, prn) = str2double(temp(1,11)); 
        if PRNList(1, prn) == 0
            PRNList(1, prn) = prn;
        end
        
        if str2double(temp(1,19)) ~= 0
           if fidx1 == 0
               freq_str1 = temp{1,15};
               fidx1 = 1;
           end
           psdr1(epoch, prn) = str2double(temp(1,19));
           phas1(epoch, prn) = str2double(temp(1,21));
        end
        
        if str2double(temp(1,29)) ~= 0
           if fidx2 == 0
               freq_str2 = temp{1,25};
               fidx2 = 1;
           end
           psdr2(epoch, prn) = str2double(temp(1,19));
           phas2(epoch, prn) = str2double(temp(1,31));
        end
        
        if str2double(temp(1,39)) ~= 0
           if fidx3 == 0
               freq_str3 = temp{1,35};
               fidx3 = 1;
           end
           psdr3(epoch, prn) = str2double(temp(1,39));
           phas3(epoch, prn) = str2double(temp(1,41));
        end
        
        if str2double(temp(1,49)) ~= 0
           if fidx4 == 0
               freq_str4 = temp{1,45};
               fidx4 = 1;
           end
           psdr4(epoch, prn) = str2double(temp(1,49));
           phas4(epoch, prn) = str2double(temp(1,51));
        end
        
        if str2double(temp(1,59)) ~= 0
           if fidx5 == 0
               freq_str5 = temp{1,55};
               fidx5 = 1;
           end
           psdr5(epoch, prn) = str2double(temp(1,59));
           phas5(epoch, prn) = str2double(temp(1,61));
        end
        
        if str2double(temp(1,69)) ~= 0
           if fidx6 == 0
               freq_str6 = temp{1,65};
               fidx6 = 1;
           end
           psdr6(epoch, prn) = str2double(temp(1,69));
           phas6(epoch, prn) = str2double(temp(1,71));
        end
        
    end
end

uid = 0;
if fidx1 == 1
    uid = uid + 1;
    obsdata.p1 = psdr1;
    obsdata.l1 = phas1;
    fstr(1) = sprintf("%s", freq_str1);
    frn(uid) = 1;
end

if fidx2 == 1
    uid = uid + 1;
    obsdata.p2 = psdr2;
    obsdata.l2 = phas2;
    fstr(2) = freq_str2;
    frn(uid) = 2;
end

if fidx3 == 1
    uid = uid + 1;
    obsdata.p3 = psdr3;
    obsdata.l3 = phas3;
    fstr(3) = freq_str3;
    frn(uid) = 3;
end

if fidx4 == 1
    uid = uid + 1;
    obsdata.p4 = psdr4;
    obsdata.l4 = phas4;
    fstr(4) = freq_str4;
    frn(uid) = 4;
end

if fidx5 == 1
    uid = uid + 1;
    obsdata.p5 = psdr5;
    obsdata.l5 = phas5;
    fstr(5) = freq_str5;
    frn(uid) = 5;
end

if fidx6 == 1
    uid = uid + 1;
    obsdata.p6 = psdr6;
    obsdata.l6 = phas6;
    fstr(6) = freq_str6;
    frn(uid) = 6;
end

obsdata.str = fstr;
obsdata.frn = frn;
obsdata.prnlist = PRNList;
obsdata.freqlist = [fidx1 fidx2 fidx3 fidx4 fidx5 fidx6];
obsdata.el = el;
obsdata.az = az;



