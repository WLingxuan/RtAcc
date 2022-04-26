function sdata = getdata(satf, len, ns, sys)

fidx1 = 0; fidx2 = 0; fidx3 = 0; fidx4 = 0; fidx5 = 0; fidx6 = 0;
freq_str1(2:3) = 'C'; freq_str2(2:3)= 'C'; freq_str3(2:3)= 'C';freq_str4(2:3)= 'C'; freq_str5(2:3)= 'C'; freq_str6(2:3)= 'C';
GEOsats = [1 2 3 4 5 59 60 61];
IGSOsats = [6 7 8 9 10 13 16 31 38 39 40 56];

%%
PRNList = zeros(1, ns);
az = zeros(len,ns)*nan; el = zeros(len,ns)*nan; ti = zeros(len, 1);

%fq1 = zeros(len,na)*nan; fq2 = zeros(len,na)*nan; fq3 = zeros(len,na)*nan;
%fq4 = zeros(len,na)*nan; fq5 = zeros(len,na)*nan; fq6 = zeros(len,na)*nan;

resp1 = zeros(len, ns) * nan; varp1 = zeros(len, ns) * nan;
resp2 = zeros(len, ns) * nan; varp2 = zeros(len, ns) * nan;
resp3 = zeros(len, ns) * nan; varp3 = zeros(len, ns) * nan;
resp4 = zeros(len, ns) * nan; varp4 = zeros(len, ns) * nan;
resp5 = zeros(len, ns) * nan; varp5 = zeros(len, ns) * nan;
resp6 = zeros(len, ns) * nan; varp6 = zeros(len, ns) * nan;

index_str1 = 0; index_str2 = 0; index_str3 = 0;
index_str4 = 0; index_str5 = 0; index_str6 = 0;
snr1 = zeros(len,ns)*nan;       snr2 = zeros(len,ns)*nan;    snr3 = zeros(len,ns)*nan;    snr4 = zeros(len,ns)*nan;       snr5 = zeros(len,ns)*nan;    snr6 = zeros(len,ns)*nan;
osb1 = zeros(len,ns)*nan;       osb2 = zeros(len,ns)*nan;    osb3 = zeros(len,ns)*nan;    osb4 = zeros(len,ns)*nan;       osb5 = zeros(len,ns)*nan;    osb6 = zeros(len,ns)*nan;
dion1= zeros(len,ns)*nan;       dion2= zeros(len,ns)*nan;    dion3= zeros(len,ns)*nan;    dion4= zeros(len,ns)*nan;       dion5= zeros(len,ns)*nan;    dion6= zeros(len,ns)*nan;
gf12 = zeros(len,ns)*nan;       gf13 = zeros(len,ns)*nan;    gf23 = zeros(len,ns)*nan;    gf14 = zeros(len,ns)*nan;       gf24 = zeros(len,ns)*nan;    gf34 = zeros(len,ns)*nan; 
mw12 = zeros(len,ns)*nan;       mw13 = zeros(len,ns)*nan;    mw23 = zeros(len,ns)*nan;    mw14 = zeros(len,ns)*nan;       mw24 = zeros(len,ns)*nan;    mw34 = zeros(len,ns)*nan; 
wl12 = zeros(len,ns)*nan;       wl13 = zeros(len,ns)*nan;    wl23 = zeros(len,ns)*nan;    wl14 = zeros(len,ns)*nan;       wl24 = zeros(len,ns)*nan;    wl34 = zeros(len,ns)*nan; 
nl12 = zeros(len,ns)*nan;       nl13 = zeros(len,ns)*nan;    nl23 = zeros(len,ns)*nan;    nl14 = zeros(len,ns)*nan;       nl24 = zeros(len,ns)*nan;    nl34 = zeros(len,ns)*nan; 
if12 = zeros(len,ns)*nan;       if13 = zeros(len,ns)*nan;    if23 = zeros(len,ns)*nan;    if14 = zeros(len,ns)*nan;       if24 = zeros(len,ns)*nan;    if34 = zeros(len,ns)*nan; 
cc1 = zeros(len,ns)*nan;         cc2 = zeros(len,ns)*nan;     cc3 = zeros(len,ns)*nan;    cc4 = zeros(len,ns)*nan;         cc5 = zeros(len,ns)*nan;     cc6 = zeros(len,ns)*nan; 
mp12 = zeros(len,ns)*nan;       mp13 = zeros(len,ns)*nan;    mp23 = zeros(len,ns)*nan;    mp14 = zeros(len,ns)*nan;       mp24 = zeros(len,ns)*nan;    mp34 = zeros(len,ns)*nan; 
pif12 = zeros(len,ns)*nan;     pif13 = zeros(len,ns)*nan;   pif23 = zeros(len,ns)*nan;    pif14 = zeros(len,ns)*nan;     pif24 = zeros(len,ns)*nan;   pif34 = zeros(len,ns)*nan; 
pnl12 = zeros(len,ns)*nan;     pnl13 = zeros(len,ns)*nan;   pnl23 = zeros(len,ns)*nan;    pnl14 = zeros(len,ns)*nan;     pnl24 = zeros(len,ns)*nan;   pnl34 = zeros(len,ns)*nan; 
mw_cs12 = zeros(len,ns)*nan; mw_cs13 = zeros(len,ns)*nan; mw_cs23 = zeros(len,ns)*nan;    mw_cs14 = zeros(len,ns)*nan; mw_cs24 = zeros(len,ns)*nan; mw_cs34 = zeros(len,ns)*nan; 
exgf = zeros(len, ns) * nan;    expc = zeros(len,ns)*nan;  trigif = zeros(len,ns)*nan;    

epoch = 0;
preEphTime = 0;

%%

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
           if index_str1 == 0
               freq_str1 = temp{1,15};
               index_str1 = 1;
               fidx1 = 1;
           end
           str1(epoch, prn)  = temp(1,15);

           snr1(epoch, prn)  = str2double(temp(1,17));
           resp1(epoch, prn) = str2double(temp(1,19));
           varp1(epoch, prn) = str2double(temp(1,21));
           osb1(epoch, prn)  = str2double(temp(1,23));
           dion1(epoch, prn) = str2double(temp(1,25));
           cc1(epoch, prn)   = str2double(temp(1,193));
        end
        if str2double(temp(1,33)) ~= 0
            if index_str2 == 0
               freq_str2 = temp{1,29};
               index_str2 = 1;
               fidx2 = 1;
           end
           str2(epoch, prn)  = temp(1,29);
           snr2(epoch, prn)  = str2double(temp(1,31));
           resp2(epoch, prn) = str2double(temp(1,33));
           varp2(epoch, prn) = str2double(temp(1,35));
           osb2(epoch, prn)  = str2double(temp(1,37));
           dion2(epoch, prn) = str2double(temp(1,39));
           cc2(epoch, prn)   = str2double(temp(1,195));
        end
        if str2double(temp(1,47)) ~= 0
           if index_str3 == 0
               freq_str3 = temp{1,43};
               index_str3 = 1;
               fidx3 = 1;
           end
           str3(epoch, prn)  = temp(1,43);
           snr3(epoch, prn)  = str2double(temp(1,45));
           resp3(epoch, prn) = str2double(temp(1,47));
           varp3(epoch, prn) = str2double(temp(1,49));
           osb3(epoch, prn)  = str2double(temp(1,51));
           dion3(epoch, prn) = str2double(temp(1,53));
           cc3(epoch, prn)   = str2double(temp(1,197));
        end
		if str2double(temp(1,61)) ~= 0
           if index_str4 == 0
               freq_str4 = temp{1,57};
               index_str4 = 1;
               fidx4 = 1;
           end
           str4(epoch, prn)  = temp(1,57);
           snr4(epoch, prn)  = str2double(temp(1,59));
           resp4(epoch, prn) = str2double(temp(1,61));
           varp4(epoch, prn) = str2double(temp(1,63));
           osb4(epoch, prn)  = str2double(temp(1,65));
           dion4(epoch, prn) = str2double(temp(1,67));
           cc4(epoch, prn)   = str2double(temp(1,199));
        end
		if str2double(temp(1,75)) ~= 0
           if index_str5 == 0
               freq_str5 = temp{1,71};
               index_str5 = 1;
               fidx5 = 1;
           end
           str5(epoch, prn)  = temp(1,71);
           snr5(epoch, prn)  = str2double(temp(1,73));
           resp5(epoch, prn) = str2double(temp(1,75));
           varp5(epoch, prn) = str2double(temp(1,77));
           osb5(epoch, prn)  = str2double(temp(1,79));
           dion5(epoch, prn) = str2double(temp(1,81));
           cc5(epoch, prn)   = str2double(temp(1,201));
        end
		if str2double(temp(1,89)) ~= 0
           if index_str6 == 0
               freq_str6 = temp{1,85};
               index_str6 = 1;
               fidx6 = 1;
           end
           str6(epoch, prn)  = temp(1,85);
           snr6(epoch, prn)  = str2double(temp(1,87));
           resp6(epoch, prn) = str2double(temp(1,89));
           varp6(epoch, prn) = str2double(temp(1,91));
           osb6(epoch, prn)  = str2double(temp(1,93));
           dion6(epoch, prn) = str2double(temp(1,95));
           cc6(epoch, prn)   = str2double(temp(1,203));
        end
        
        if str2double(temp(1,97)) ~= 0
           gf12(epoch, prn)    = str2double(temp(1,97));
           mw12(epoch, prn)    = str2double(temp(1,109));
           mw_cs12(epoch, prn) = str2double(temp(1,121));
           wl12(epoch, prn)    = str2double(temp(1,133));
           nl12(epoch, prn)    = str2double(temp(1,145));
           if12(epoch, prn)    = str2double(temp(1,157));
           pif12(epoch, prn)   = str2double(temp(1,169));
           pnl12(epoch, prn)   = str2double(temp(1,181));
           mp12(epoch, prn)    = str2double(temp(1,205));
           %cycleslip detection
           %gf
           %mw
           %hd
           %thrs
           %...
        end
        if str2double(temp(1,99)) ~= 0
           gf13(epoch, prn)    = str2double(temp(1,99));
           mw13(epoch, prn)    = str2double(temp(1,111));
           mw_cs13(epoch, prn) = str2double(temp(1,123));
           wl13(epoch, prn)    = str2double(temp(1,135));
           nl13(epoch, prn)    = str2double(temp(1,147));
           if13(epoch, prn)    = str2double(temp(1,159));
           pif13(epoch, prn)   = str2double(temp(1,171));
           pnl13(epoch, prn)   = str2double(temp(1,183));
           mp13(epoch, prn)    = str2double(temp(1,207));
        end
        if str2double(temp(1,101)) ~= 0
           gf23(epoch, prn) = str2double(temp(1,101));
           mw23(epoch, prn) = str2double(temp(1,113));
           mw_cs23(epoch, prn) = str2double(temp(1,125));
           wl23(epoch, prn) = str2double(temp(1,137));
           nl23(epoch, prn) = str2double(temp(1,149));
           if23(epoch, prn) = str2double(temp(1,161));
           pif23(epoch, prn) = str2double(temp(1,173));
           pnl23(epoch, prn) = str2double(temp(1,185));
           mp23(epoch, prn) = str2double(temp(1,209));           
        end
		if str2double(temp(1,103)) ~= 0
            gf14(epoch, prn) = str2double(temp(1,103));
            mw14(epoch, prn) = str2double(temp(1,115));
            mw_cs14(epoch, prn) = str2double(temp(1,127));
            wl14(epoch, prn) = str2double(temp(1,139));
            nl14(epoch, prn) = str2double(temp(1,151));
            if14(epoch, prn) = str2double(temp(1,163));
            pif14(epoch, prn) = str2double(temp(1,175));
            pnl14(epoch, prn) = str2double(temp(1,187));
            mp14(epoch, prn) = str2double(temp(1,211));
        end
		if str2double(temp(1,105)) ~= 0
            gf24(epoch, prn) = str2double(temp(1,105));
            mw24(epoch, prn) = str2double(temp(1,117));
            mw_cs24(epoch, prn) = str2double(temp(1,129));
            wl24(epoch, prn) = str2double(temp(1,141));
            nl24(epoch, prn) = str2double(temp(1,153));
            if24(epoch, prn) = str2double(temp(1,165));
            pif24(epoch, prn) = str2double(temp(1,177));
            pnl24(epoch, prn) = str2double(temp(1,189));
            mp24(epoch, prn) = str2double(temp(1,213));           
        end
		if str2double(temp(1,107)) ~= 0
            gf34(epoch, prn) = str2double(temp(1,107));
            mw34(epoch, prn) = str2double(temp(1,119));
            mw_cs34(epoch, prn) = str2double(temp(1,131));
            wl34(epoch, prn) = str2double(temp(1,143));
            nl34(epoch, prn) = str2double(temp(1,155));
            if34(epoch, prn) = str2double(temp(1,167));
            pif34(epoch, prn) = str2double(temp(1,179));
            pnl34(epoch, prn) = str2double(temp(1,191));
            mp34(epoch, prn) = str2double(temp(1,215));
        end
        if str2double(temp(1,217)) ~= 0
           exgf(epoch, prn) = str2double(temp(1,217));
           expc(epoch, prn) = str2double(temp(1,219));
           trigif(epoch, prn) = str2double(temp(1,221));
           %exlcwl
        end
    end
end
%tname = sprintf("%sCCdata.mat", sys);
sdata.ti = ti;
sdata.cc1 = cc1; sdata.cc2 = cc2; sdata.cc3 = cc3; sdata.cc4 = cc4; sdata.cc5 = cc5; sdata.cc6 = cc6; 
sdata.resp1 = resp1; sdata.resp2 = resp2; sdata.resp3 = resp3; 
sdata.resp4 = resp4; sdata.resp5 = resp5; sdata.resp6 = resp6; 
sdata.varp1 = varp1; sdata.varp2 = varp2; sdata.varp3 = varp3; 
sdata.varp4 = varp4; sdata.varp5 = varp5; sdata.varp6 = varp6; 
sdata.snr1 = snr1; sdata.snr2 = snr2; sdata.snr3 = snr3; 
sdata.snr4 = snr4; sdata.snr5 = snr5; sdata.snr6 = snr6; 
sdata.fstr = [freq_str1 freq_str2 freq_str3 freq_str4 freq_str5 freq_str6];

sdata.pnl12 = pnl12; sdata.pnl13 = pnl13; sdata.pnl23 = pnl23; 
sdata.pnl14 = pnl14; sdata.pnl24 = pnl24; sdata.pnl34 = pnl34; 

sdata.wl12 = wl12; sdata.wl13 = wl13; sdata.wl23 = wl23; 
sdata.wl14 = wl14; sdata.wl24 = wl24; sdata.wl34 = wl34; 

sdata.if12 = if12; sdata.if13 = if13; sdata.if23 = if23; 
sdata.if14 = if14; sdata.if24 = if24; sdata.if34 = if34; 

sdata.pif12 = pif12; sdata.pif13 = pif13; sdata.pif23 = pif23; 
sdata.pif14 = pif14; sdata.pif24 = pif24; sdata.pif34 = pif34; 
%save(tname);
