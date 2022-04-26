function plotsats(satf, len, ns, sys)

fidx1 = 0; fidx2 = 0; fidx3 = 0; fidx4 = 0; fidx5 = 0; fidx6 = 0;
freq_str1(2:3) = 'C'; freq_str2(2:3)= 'C'; freq_str3(2:3)= 'C';freq_str4(2:3)= 'C'; freq_str5(2:3)= 'C'; freq_str6(2:3)= 'C';
GEOsats = [1 2 3 4 5 59 60 61];
IGSOsats = [6 7 8 9 10 13 16 31 38 39 40 56];

%%
PRNList = zeros(1, ns);
az = zeros(len,ns)*nan; el = zeros(len,ns)*nan; ti = zeros(len, 1);

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
plotlegend(ns, sys, PRNList);
nf = fidx1 + fidx2 + fidx3 + fidx4 + fidx5 + fidx6;
ptfi1 = 0; ptfi2 = 0; ptfi3 = 0; ptfi4 = 0; ptfi5 = 0; ptfi6 = 0;
%%
if sys == "BDS2" || sys == "BDS3"
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
    plotMulti(nf, ti, cc1, cc2, cc3, cc4, cc5, cc6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO伪距-相位组合(m)", 1, plistGEO);
    plotMulti(nf, ti, mp12, mp13, mp23, mp14, mp24, mp34, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO多路径组合(m)", 1, plistGEO);
    plotMulti(nf, ti, dion1, dion2, dion3, dion4, dion5, dion6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO伪距电离层改正(m)", 1, plistGEO);
    plotMulti(nf, ti, osb1, osb2, osb3, osb4, osb5, osb6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO伪距UPD改正(m)", 1, plistGEO);
    plotMulti(nf, ti, snr1, snr2, snr3, snr4, snr5, snr6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO信噪比(dHz)", 1, plistGEO);
    plotMulti(nf, ti, resp1, resp2, resp3, resp4, resp5, resp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO伪距后验残差(m)", 0, plistGEO);
    plotMulti(nf, ti, varp1, varp2, varp3, varp4, varp5, varp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " GEO伪距后验标准差(m)", 0, plistGEO);

    plotMulti(nf, ti, cc1, cc2, cc3, cc4, cc5, cc6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO伪距-相位组合(m)", 1, plistIGSO);
    plotMulti(nf, ti, mp12, mp13, mp23, mp14, mp24, mp34, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO多路径组合(m)", 1, plistIGSO);
    plotMulti(nf, ti, dion1, dion2, dion3, dion4, dion5, dion6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO伪距电离层改正(m)", 1, plistIGSO);
    plotMulti(nf, ti, osb1, osb2, osb3, osb4, osb5, osb6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO伪距UPD改正(m)", 1, plistIGSO);
    plotMulti(nf, ti, snr1, snr2, snr3, snr4, snr5, snr6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO信噪比(dHz)", 1, plistIGSO);
    plotMulti(nf, ti, resp1, resp2, resp3, resp4, resp5, resp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO伪距后验残差(m)", 0, plistIGSO);
    plotMulti(nf, ti, varp1, varp2, varp3, varp4, varp5, varp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " IGSO伪距后验标准差(m)", 0, plistIGSO);

    plotMulti(nf, ti, cc1, cc2, cc3, cc4, cc5, cc6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO伪距-相位组合(m)", 1, plistMEO);
    plotMulti(nf, ti, mp12, mp13, mp23, mp14, mp24, mp34, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO多路径组合(m)", 1, plistMEO);
    plotMulti(nf, ti, dion1, dion2, dion3, dion4, dion5, dion6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO伪距电离层改正(m)", 1, plistMEO);
    plotMulti(nf, ti, osb1, osb2, osb3, osb4, osb5, osb6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO伪距UPD改正(m)", 1, plistMEO);
    plotMulti(nf, ti, snr1, snr2, snr3, snr4, snr5, snr6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO信噪比(dHz)", 1, plistMEO);
    plotMulti(nf, ti, resp1, resp2, resp3, resp4, resp5, resp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO伪距后验残差(m)", 0, plistMEO);
    plotMulti(nf, ti, varp1, varp2, varp3, varp4, varp5, varp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " MEO伪距后验标准差(m)", 0, plistMEO);
    if sys == "BDS3"
        ptfi1 = fidx6; ptstr1 = freq_str6;  %B1C
        ptfi2 = fidx3; ptstr2 = freq_str3;  %B2a
        ptfi3 = fidx4; ptstr3 = freq_str4;  %B3
        ptfi4 = fidx2; ptstr4 = freq_str2;  %B2b
        ptfi5 = fidx5; ptstr5 = freq_str5;  %B2a+b
        ptfi6 = 0;     ptstr6 = freq_str1;  %B1I
    end
    if sys == "BDS2"
        ptfi1 = fidx1; ptstr1 = freq_str1;  %B1C
        ptfi2 = fidx2; ptstr2 = freq_str2;  %B2I
        ptfi3 = fidx4; ptstr3 = freq_str4;  %B3
        ptfi4 = 0;     ptstr4 = freq_str4;  %0
        ptfi5 = 0;     ptstr5 = freq_str5;  %0
        ptfi6 = 0;     ptstr6 = freq_str6;  %0
    end
    tit12 = sprintf('%2s&%2s',ptstr1(2:3),ptstr2(2:3));
    tit13 = sprintf('%2s&%2s',ptstr1(2:3),ptstr3(2:3));
    tit23 = sprintf('%2s&%2s',ptstr2(2:3),ptstr3(2:3));
    tit14 = sprintf('%2s&%2s',ptstr1(2:3),ptstr4(2:3));
    tit24 = sprintf('%2s&%2s',ptstr2(2:3),ptstr4(2:3));
    tit34 = sprintf('%2s&%2s',ptstr3(2:3),ptstr4(2:3));
    tit123 = sprintf('%2s&%2s%',ptstr1(2:3),ptstr2(2:3),ptstr3(2:3));
    
    if ptfi1 ==1 && ptfi2 ==1
        plot_lc(ti, gf12, ns, sys,    tit12, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw12, ns, sys,    tit12, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs12, ns, sys, tit12, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl12, ns, sys,    tit12, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl12, ns, sys,    tit12, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if12, ns, sys,    tit12, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif12, ns, sys,   tit12, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl12, ns, sys,   tit12, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf12, ns, sys,    tit12, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw12, ns, sys,    tit12, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs12, ns, sys, tit12, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl12, ns, sys,    tit12, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl12, ns, sys,    tit12, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if12, ns, sys,    tit12, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif12, ns, sys,   tit12, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl12, ns, sys,   tit12, "伪距窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, gf12, ns, sys,    tit12, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw12, ns, sys,    tit12, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs12, ns, sys, tit12, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl12, ns, sys,    tit12, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl12, ns, sys,    tit12, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if12, ns, sys,    tit12, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif12, ns, sys,   tit12, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl12, ns, sys,   tit12, "伪距窄巷组合观测值(m)", plistGEO);
    end
    if ptfi1 == 1 && ptfi3 == 1
        plot_lc(ti, gf13, ns, sys,    tit13, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw13, ns, sys,    tit13, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs13, ns, sys, tit13, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl13, ns, sys,    tit13, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl13, ns, sys,    tit13, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if13, ns, sys,    tit13, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif13, ns, sys,   tit13, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl13, ns, sys,   tit13, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf13, ns, sys,    tit13, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw13, ns, sys,    tit13, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs13, ns, sys, tit13, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl13, ns, sys,    tit13, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl13, ns, sys,    tit13, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if13, ns, sys,    tit13, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif13, ns, sys,   tit13, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl13, ns, sys,   tit13, "伪距窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, gf13, ns, sys,    tit13, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw13, ns, sys,    tit13, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs13, ns, sys, tit13, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl13, ns, sys,    tit13, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl13, ns, sys,    tit13, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if13, ns, sys,    tit13, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif13, ns, sys,   tit13, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl13, ns, sys,   tit13, "伪距窄巷组合观测值(m)", plistIGSO);
    end
    if ptfi2 == 1 && ptfi3 == 1
        plot_lc(ti, gf23, ns, sys,    tit23, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw23, ns, sys,    tit23, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs23, ns, sys, tit23, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl23, ns, sys,    tit23, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl23, ns, sys,    tit23, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if23, ns, sys,    tit23, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif23, ns, sys,   tit23, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl23, ns, sys,   tit23, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf23, ns, sys,    tit23, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw23, ns, sys,    tit23, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs23, ns, sys, tit23, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl23, ns, sys,    tit23, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl23, ns, sys,    tit23, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if23, ns, sys,    tit23, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif23, ns, sys,   tit23, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl23, ns, sys,   tit23, "伪距窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, gf23, ns, sys,    tit23, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw23, ns, sys,    tit23, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs23, ns, sys, tit23, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl23, ns, sys,    tit23, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl23, ns, sys,    tit23, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if23, ns, sys,    tit23, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif23, ns, sys,   tit23, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl23, ns, sys,   tit23, "伪距窄巷组合观测值(m)", plistIGSO);
    end
    if ptfi1 == 1 && ptfi4 == 1
        plot_lc(ti, gf14, ns, sys,    tit14, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw14, ns, sys,    tit14, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs14, ns, sys, tit14, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl14, ns, sys,    tit14, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl14, ns, sys,    tit14, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if14, ns, sys,    tit14, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif14, ns, sys,   tit14, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl14, ns, sys,   tit14, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf14, ns, sys,    tit14, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw14, ns, sys,    tit14, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs14, ns, sys, tit14, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl14, ns, sys,    tit14, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl14, ns, sys,    tit14, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if14, ns, sys,    tit14, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif14, ns, sys,   tit14, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl14, ns, sys,   tit14, "伪距窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, gf14, ns, sys,    tit14, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw14, ns, sys,    tit14, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs14, ns, sys, tit14, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl14, ns, sys,    tit14, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl14, ns, sys,    tit14, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if14, ns, sys,    tit14, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif14, ns, sys,   tit14, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl14, ns, sys,   tit14, "伪距窄巷组合观测值(m)", plistIGSO);
    end
    if ptfi2 == 1 && ptfi4 == 1
        plot_lc(ti, gf24, ns, sys,    tit24, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw24, ns, sys,    tit24, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs24, ns, sys, tit24, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl24, ns, sys,    tit24, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl24, ns, sys,    tit24, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if24, ns, sys,    tit24, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif24, ns, sys,   tit24, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl24, ns, sys,   tit24, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf24, ns, sys,    tit24, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw24, ns, sys,    tit24, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs24, ns, sys, tit24, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl24, ns, sys,    tit24, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl24, ns, sys,    tit24, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if24, ns, sys,    tit24, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif24, ns, sys,   tit24, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl24, ns, sys,   tit24, "伪距窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, gf24, ns, sys,    tit24, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw24, ns, sys,    tit24, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs24, ns, sys, tit24, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl24, ns, sys,    tit24, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl24, ns, sys,    tit24, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if24, ns, sys,    tit24, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif24, ns, sys,   tit24, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl24, ns, sys,   tit24, "伪距窄巷组合观测值(m)", plistIGSO);
    end
    if ptfi3 == 1 && ptfi4 == 1
        plot_lc(ti, gf34, ns, sys,    tit34, "载波无几何组合观测值(m)", plistMEO);
        plot_lc(ti, mw34, ns, sys,    tit34, "MW组合观测值(m)", plistMEO);
        plot_lc(ti, mw_cs34, ns, sys, tit34, "MW组合观测值(cycle)", plistMEO);
        plot_lc(ti, nl34, ns, sys,    tit34, "载波窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, wl34, ns, sys,    tit34, "载波宽巷组合观测值(m)", plistMEO);
        plot_lc(ti, if34, ns, sys,    tit34, "载波消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pif34, ns, sys,   tit34, "伪距消电离层组合观测值(m)", plistMEO);
        plot_lc(ti, pnl34, ns, sys,   tit34, "伪距窄巷组合观测值(m)", plistMEO);
        plot_lc(ti, gf34, ns, sys,    tit34, "载波无几何组合观测值(m)", plistGEO);
        plot_lc(ti, mw34, ns, sys,    tit34, "MW组合观测值(m)", plistGEO);
        plot_lc(ti, mw_cs34, ns, sys, tit34, "MW组合观测值(cycle)", plistGEO);
        plot_lc(ti, nl34, ns, sys,    tit34, "载波窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, wl34, ns, sys,    tit34, "载波宽巷组合观测值(m)", plistGEO);
        plot_lc(ti, if34, ns, sys,    tit34, "载波消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pif34, ns, sys,   tit34, "伪距消电离层组合观测值(m)", plistGEO);
        plot_lc(ti, pnl34, ns, sys,   tit34, "伪距窄巷组合观测值(m)", plistGEO);
        plot_lc(ti, gf34, ns, sys,    tit34, "载波无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, mw34, ns, sys,    tit34, "MW组合观测值(m)", plistIGSO);
        plot_lc(ti, mw_cs34, ns, sys, tit34, "MW组合观测值(cycle)", plistIGSO);
        plot_lc(ti, nl34, ns, sys,    tit34, "载波窄巷组合观测值(m)", plistIGSO);
        plot_lc(ti, wl34, ns, sys,    tit34, "载波宽巷组合观测值(m)", plistIGSO);
        plot_lc(ti, if34, ns, sys,    tit34, "载波消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pif34, ns, sys,   tit34, "伪距消电离层组合观测值(m)", plistIGSO);
        plot_lc(ti, pnl34, ns, sys,   tit34, "伪距窄巷组合观测值(m)", plistIGSO);
    end
    if nf > 3
        plot_lc(ti, exgf, ns, sys, tit123, "三频无几何组合观测值(m)", plistMEO);
        plot_lc(ti, expc, ns, sys, tit123, "三频伪距相位组合观测值(m)", plistMEO);
        plot_lc(ti, trigif, ns, sys, tit123, "三频无几何无电离层组合观测值(m)", plistMEO);
        plot_lc(ti, exgf, ns, sys, tit123, "三频无几何组合观测值(m)", plistGEO);
        plot_lc(ti, expc, ns, sys, tit123, "三频伪距相位组合观测值(m)", plistGEO);
        plot_lc(ti, trigif, ns, sys, tit123, "三频无几何无电离层组合观测值(m)", plistGEO);
        plot_lc(ti, exgf, ns, sys, tit123, "三频无几何组合观测值(m)", plistIGSO);
        plot_lc(ti, expc, ns, sys, tit123, "三频伪距相位组合观测值(m)", plistIGSO);
        plot_lc(ti, trigif, ns, sys, tit123, "三频无几何无电离层组合观测值(m)", plistIGSO);
    end    
%% 
else
    plotMulti(nf, ti, cc1, cc2, cc3, cc4, cc5, cc6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 伪距-相位组合(m)", 1, PRNList);
    plotMulti(nf, ti, mp12, mp13, mp23, mp14, mp24, mp34, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 多路径组合(m)", 1, PRNList);
    plotMulti(nf, ti, dion1, dion2, dion3, dion4, dion5, dion6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 伪距电离层改正(m)", 1, PRNList);
    plotMulti(nf, ti, osb1, osb2, osb3, osb4, osb5, osb6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 伪距UPD改正(m)", 1, PRNList);
    plotMulti(nf, ti, snr1, snr2, snr3, snr4, snr5, snr6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 信噪比(dHz)", 1, PRNList);
    plotMulti(nf, ti, resp1, resp2, resp3, resp4, resp5, resp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 伪距后验残差(m)", 0, PRNList);
    plotMulti(nf, ti, varp1, varp2, varp3, varp4, varp5, varp6, freq_str1(2:3), freq_str2(2:3), freq_str3(2:3),freq_str4(2:3), freq_str5(2:3), freq_str6(2:3), fidx1, fidx2, fidx3, fidx4, fidx5, fidx6, ns,  sys,  " 伪距后验标准差(m)", 0, PRNList);
    
    if sys == "GAL"
        ptfi1 = fidx1; ptstr1 = freq_str1;  %E1
        ptfi2 = fidx2; ptstr2 = freq_str2;  %E5b
        ptfi3 = fidx3; ptstr3 = freq_str3;  %E5a
        ptfi4 = fidx4; ptstr4 = freq_str4;  %E6
        ptfi5 = 0;     ptstr5 = freq_str5;  %E5a+b
        ptfi6 = 0;     ptstr6 = freq_str6;  %0
    end
    if sys == "GLO"
        ptfi1 = fidx1; ptstr1 = freq_str1;  %R1
        ptfi2 = fidx2; ptstr2 = freq_str2;  %R2
        ptfi3 = fidx3; ptstr3 = freq_str3;  %R3
        if fidx1 == 0 && fidx2 == 0 && fidx4 == 1 && fidx5 == 1
            ptfi1 = fidx4; ptstr1 = freq_str4;  %R1a
            ptfi2 = fidx5; ptstr2 = freq_str5;  %R2a
        end
        ptfi4 = 0;  ptstr4 = freq_str4;       %0
        ptfi5 = 0;  ptstr5 = freq_str5;       %0
        ptfi6 = 0;  ptstr6 = freq_str6;       %0
    end
    if sys == "GPS"
        ptfi1 = fidx1; ptstr1 = freq_str1;  %B1C
        ptfi2 = fidx2; ptstr2 = freq_str2;  %B2I
        ptfi3 = fidx3; ptstr3 = freq_str3;  %B3
        ptfi4 = 0;    ptstr4 = freq_str4;   %0
        ptfi5 = 0;    ptstr5 = freq_str5;   %0
        ptfi6 = 0;    ptstr6 = freq_str6;   %0
    end
    
    tit12 = sprintf('%2s&%2s',ptstr1(2:3),ptstr2(2:3));
    tit13 = sprintf('%2s&%2s',ptstr1(2:3),ptstr3(2:3));
    tit23 = sprintf('%2s&%2s',ptstr2(2:3),ptstr3(2:3));
    tit14 = sprintf('%2s&%2s',ptstr1(2:3),ptstr4(2:3));
    tit24 = sprintf('%2s&%2s',ptstr2(2:3),ptstr4(2:3));
    tit34 = sprintf('%2s&%2s',ptstr3(2:3),ptstr4(2:3));
    tit123 = sprintf('%2s&%2s%',ptstr1(2:3),ptstr2(2:3),ptstr3(2:3));
    
    if ptfi1 ==1 && ptfi2 ==1
        plot_lc(ti, gf12, ns, sys,    tit12, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw12, ns, sys,    tit12, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs12, ns, sys, tit12, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl12, ns, sys,    tit12, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl12, ns, sys,    tit12, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if12, ns, sys,    tit12, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif12, ns, sys,   tit12, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl12, ns, sys,   tit12, "伪距窄巷组合观测值(m)", PRNList);
    end
    if ptfi1 == 1 && ptfi3 == 1
        plot_lc(ti, gf13, ns, sys,    tit13, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw13, ns, sys,    tit13, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs13, ns, sys, tit13, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl13, ns, sys,    tit13, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl13, ns, sys,    tit13, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if13, ns, sys,    tit13, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif13, ns, sys,   tit13, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl13, ns, sys,   tit13, "伪距窄巷组合观测值(m)", PRNList);
    end
    if ptfi2 == 1 && ptfi3 == 1
        plot_lc(ti, gf23, ns, sys,    tit23, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw23, ns, sys,    tit23, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs23, ns, sys, tit23, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl23, ns, sys,    tit23, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl23, ns, sys,    tit23, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if23, ns, sys,    tit23, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif23, ns, sys,   tit23, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl23, ns, sys,   tit23, "伪距窄巷组合观测值(m)", PRNList);
    end
    if ptfi1 == 1 && ptfi4 == 1
        plot_lc(ti, gf14, ns, sys,    tit14, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw14, ns, sys,    tit14, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs14, ns, sys, tit14, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl14, ns, sys,    tit14, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl14, ns, sys,    tit14, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if14, ns, sys,    tit14, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif14, ns, sys,   tit14, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl14, ns, sys,   tit14, "伪距窄巷组合观测值(m)", PRNList);
    end
    if ptfi2 == 1 && ptfi4 == 1
        plot_lc(ti, gf24, ns, sys,    tit24, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw24, ns, sys,    tit24, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs24, ns, sys, tit24, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl24, ns, sys,    tit24, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl24, ns, sys,    tit24, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if24, ns, sys,    tit24, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif24, ns, sys,   tit24, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl24, ns, sys,   tit24, "伪距窄巷组合观测值(m)", PRNList);
    end
    if ptfi3 == 1 && ptfi4 == 1
        plot_lc(ti, gf34, ns, sys,    tit34, "载波无几何组合观测值(m)", PRNList);
        plot_lc(ti, mw34, ns, sys,    tit34, "MW组合观测值(m)", PRNList);
        plot_lc(ti, mw_cs34, ns, sys, tit34, "MW组合观测值(cycle)", PRNList);
        plot_lc(ti, nl34, ns, sys,    tit34, "载波窄巷组合观测值(m)", PRNList);
        plot_lc(ti, wl34, ns, sys,    tit34, "载波宽巷组合观测值(m)", PRNList);
        plot_lc(ti, if34, ns, sys,    tit34, "载波消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pif34, ns, sys,   tit34, "伪距消电离层组合观测值(m)", PRNList);
        plot_lc(ti, pnl34, ns, sys,   tit34, "伪距窄巷组合观测值(m)", PRNList);
    end
    if nf > 3
        plot_lc(ti, exgf, ns, sys, tit123, "三频无几何组合观测值(m)", PRNList);
        plot_lc(ti, expc, ns, sys, tit123, "三频伪距相位组合观测值(m)", PRNList);
        plot_lc(ti, trigif, ns, sys, tit123, "三频无几何无电离层组合观测值(m)", PRNList);
    end
end
%% plot resp, mp, cc, osb dion, 

%% plot lc




