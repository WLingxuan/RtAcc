load('outdata.mat')
ti = gccd.ti(1250:2500,1);

%%
%BDS3 - MEO
test.C3.snr(:,1) = c3ccd.snr1(1250:2500, 34);
test.C3.snr(:,2) = c3ccd.snr2(1250:2500, 34);
test.C3.snr(:,3) = c3ccd.snr3(1250:2500, 34);
test.C3.snr(:,4) = c3ccd.snr4(1250:2500, 34);
test.C3.snr(:,5) = c3ccd.snr5(1250:2500, 34);
test.C3.snr(:,6) = c3ccd.snr6(1250:2500, 34);
test.C3.el(:,1) = c3obs.el(1250:2500, 34);
test.C3.cc(:,1) = c3ccd.cc1(1250:2500, 34);
test.C3.cc(:,2) = c3ccd.cc2(1250:2500, 34);
test.C3.cc(:,3) = c3ccd.cc3(1250:2500, 34);
test.C3.cc(:,4) = c3ccd.cc4(1250:2500, 34);
test.C3.cc(:,5) = c3ccd.cc5(1250:2500, 34);
test.C3.cc(:,6) = c3ccd.cc6(1250:2500, 34);
test.C3.pnl12(:,1) = c3ccd.pnl12(1250:2500,34);
test.C3.pnl13(:,1) = c3ccd.pnl13(1250:2500,34);
test.C3.pif12(:,1) = c3ccd.pif12(1250:2500,34);
test.C3.wl12(:,1) = c3ccd.wl12(1250:2500,34);
test.C3.wl13(:,1) = c3ccd.wl13(1250:2500,34);
test.C3.if12(:,1) = c3ccd.if12(1250:2500,34);
test.C3.prn = 34;
test.C3.fstr = c3obs.str;
test.C3.freqlist= c3obs.freqlist;
test.C3.sys = "BDS3";

%%
%BDS2 -- IGSO
test.C2i.snr(:,1) = c2ccd.snr1(1250:2500, 13);
test.C2i.snr(:,2) = c2ccd.snr2(1250:2500, 13);
test.C2i.snr(:,3) = c2ccd.snr3(1250:2500, 13);
test.C2i.snr(:,4) = c2ccd.snr4(1250:2500, 13);
test.C2i.snr(:,5) = c2ccd.snr5(1250:2500, 13);
test.C2i.snr(:,6) = c2ccd.snr6(1250:2500, 13);
test.C2i.el(:,1) = c2obs.el(1250:2500, 13);
test.C2i.cc(:,1) = c2ccd.cc1(1250:2500, 13);
test.C2i.cc(:,2) = c2ccd.cc2(1250:2500, 13);
test.C2i.cc(:,3) = c2ccd.cc3(1250:2500, 13);
test.C2i.cc(:,4) = c2ccd.cc4(1250:2500, 13);
test.C2i.cc(:,5) = c2ccd.cc5(1250:2500, 13);
test.C2i.cc(:,6) = c2ccd.cc6(1250:2500, 13);
test.C2i.pnl12(:,1) = c2ccd.pnl12(1250:2500,13);
test.C2i.pnl13(:,1) = c2ccd.pnl13(1250:2500,13);
test.C2i.pif12(:,1) = c2ccd.pif12(1250:2500,13);
test.C2i.wl12(:,1) = c2ccd.wl12(1250:2500,13);
test.C2i.wl13(:,1) = c2ccd.wl13(1250:2500,13);
test.C2i.if12(:,1) = c2ccd.if12(1250:2500,13);
test.C2i.prn = 13;
test.C2i.fstr = c2obs.str;
test.C2i.freqlist= c2obs.freqlist;
test.C2i.sys = "BDS2";

%%
%BDS2-GEO
test.C2g.snr(:,1) = c2ccd.snr1(1250:2500, 5);
test.C2g.snr(:,2) = c2ccd.snr2(1250:2500, 5);
test.C2g.snr(:,3) = c2ccd.snr3(1250:2500, 5);
test.C2g.snr(:,4) = c2ccd.snr4(1250:2500, 5);
test.C2g.snr(:,5) = c2ccd.snr5(1250:2500, 5);
test.C2g.snr(:,6) = c2ccd.snr6(1250:2500, 5);
test.C2g.el(:,1) = c2obs.el(1250:2500, 5);
test.C2g.cc(:,1) = c2ccd.cc1(1250:2500, 5);
test.C2g.cc(:,2) = c2ccd.cc2(1250:2500, 5);
test.C2g.cc(:,3) = c2ccd.cc3(1250:2500, 5);
test.C2g.cc(:,4) = c2ccd.cc4(1250:2500, 5);
test.C2g.cc(:,5) = c2ccd.cc5(1250:2500, 5);
test.C2g.cc(:,6) = c2ccd.cc6(1250:2500, 5);
test.C2g.pnl12(:,1) = c2ccd.pnl12(1250:2500,5);
test.C2g.pnl13(:,1) = c2ccd.pnl13(1250:2500,5);
test.C2g.pif12(:,1) = c2ccd.pif12(1250:2500,5);
test.C2g.wl12(:,1) = c2ccd.wl12(1250:2500,5);
test.C2g.wl13(:,1) = c2ccd.wl13(1250:2500,5);
test.C2g.if12(:,1) = c2ccd.if12(1250:2500,5);
test.C2g.prn = 5;
test.C2g.fstr = c2obs.str;
test.C2g.freqlist= c2obs.freqlist;
test.C2g.sys = "BDS2";

%%
%GPS 
test.G.snr(:,1) = gccd.snr1(1250:2500, 25);
test.G.snr(:,2) = gccd.snr2(1250:2500, 25);
test.G.snr(:,3) = gccd.snr3(1250:2500, 25);
test.G.snr(:,4) = gccd.snr4(1250:2500, 25);
test.G.snr(:,5) = gccd.snr5(1250:2500, 25);
test.G.snr(:,6) = gccd.snr6(1250:2500, 25);
test.G.el(:,1) = gobs.el(1250:2500,  25);
test.G.cc(:,1) = gccd.cc1(1250:2500, 25);
test.G.cc(:,2) = gccd.cc2(1250:2500, 25);
test.G.cc(:,3) = gccd.cc3(1250:2500, 25);
test.G.cc(:,4) = gccd.cc4(1250:2500, 25);
test.G.cc(:,5) = gccd.cc5(1250:2500, 25);
test.G.cc(:,6) = gccd.cc6(1250:2500, 25);
test.G.pnl12(:,1) = gccd.pnl12(1250:2500,25);
test.G.pnl13(:,1) = gccd.pnl13(1250:2500,25);
test.G.pif12(:,1) = gccd.pif12(1250:2500,25);
test.G.wl12(:,1) = gccd.wl12(1250:2500,25);
test.G.wl13(:,1) = gccd.wl13(1250:2500,25);
test.G.if12(:,1) = gccd.if12(1250:2500,25);
test.G.prn = 25;
test.G.fstr = gobs.str;
test.G.freqlist= gobs.freqlist;
test.G.sys = "GPS";

%%
%GLO
test.R.snr(:,1) = rccd.snr1(1250:2500, 9);
test.R.snr(:,2) = rccd.snr2(1250:2500, 9);
test.R.snr(:,3) = rccd.snr3(1250:2500, 9);
test.R.snr(:,4) = rccd.snr4(1250:2500, 9);
test.R.snr(:,5) = rccd.snr5(1250:2500, 9);
test.R.snr(:,6) = rccd.snr6(1250:2500, 9);
test.R.el(:,1) = robs.el(1250:2500,    9);
test.R.cc(:,1) = rccd.cc1(1250:2500,   9);
test.R.cc(:,2) = rccd.cc2(1250:2500,   9);
test.R.cc(:,3) = rccd.cc3(1250:2500,   9);
test.R.cc(:,4) = rccd.cc4(1250:2500,   9);
test.R.cc(:,5) = rccd.cc5(1250:2500,   9);
test.R.cc(:,6) = rccd.cc6(1250:2500,   9);
test.R.pnl12(:,1) = rccd.pnl12(1250:2500,9);
test.R.pnl13(:,1) = rccd.pnl13(1250:2500,9);
test.R.pif12(:,1) = rccd.pif12(1250:2500,9);
test.R.wl12(:,1) = rccd.wl12(1250:2500,9);
test.R.wl13(:,1) = rccd.wl13(1250:2500,9);
test.R.if12(:,1) = rccd.if12(1250:2500,9);
test.R.prn = 9;
test.R.fstr = robs.str;
test.R.freqlist= robs.freqlist;
test.R.sys = "GLO";

%%
%GAL
test.E.snr(:,1) = eccd.snr1(1250:2500, 24);
test.E.snr(:,2) = eccd.snr2(1250:2500, 24);
test.E.snr(:,3) = eccd.snr3(1250:2500, 24);
test.E.snr(:,4) = eccd.snr4(1250:2500, 24);
test.E.snr(:,5) = eccd.snr5(1250:2500, 24);
test.E.snr(:,6) = eccd.snr6(1250:2500, 24);
test.E.el(:,1) = eobs.el(1250:2500,    24);
test.E.cc(:,1) = eccd.cc1(1250:2500,   24);
test.E.cc(:,2) = eccd.cc2(1250:2500,   24);
test.E.cc(:,3) = eccd.cc3(1250:2500,   24);
test.E.cc(:,4) = eccd.cc4(1250:2500,   24);
test.E.cc(:,5) = eccd.cc5(1250:2500,   24);
test.E.cc(:,6) = eccd.cc6(1250:2500,   24);
test.E.pnl12(:,1) = eccd.pnl12(1250:2500,24);
test.E.pnl13(:,1) = eccd.pnl13(1250:2500,24);
test.E.pif12(:,1) = eccd.pif12(1250:2500,24);
test.E.wl12(:,1) = eccd.wl12(1250:2500,24);
test.E.wl13(:,1) = eccd.wl13(1250:2500,24);
test.E.if12(:,1) = eccd.if12(1250:2500,24);
test.E.prn = 24;
test.E.fstr = eobs.str;
test.E.freqlist= eobs.freqlist;
test.E.sys = "GAL";

[GPres, GPvar, GLCt] = ResVarEXE(test.G, ti);
[GPolyvar ,GDiffvar, GCCt, Gstrout] = CCresvar(test.G,ti);
GregreTable = ELregre(GCCt,test.G.el,test.G.snr,GPolyvar, GDiffvar, GPvar, Gstrout, 'G',25);

[RPolyvar ,RDiffvar, RCCt, Rstrout] = CCresvar(test.R,ti);
[RPres, RPvar, RLCt] = ResVarEXE(test.R, ti);
RregreTable = ELregre(RCCt,test.R.el,test.R.snr,RPolyvar, RDiffvar, RPvar, Rstrout, 'R',9);

[EPolyvar ,EDiffvar, ECCt, Estrout] = CCresvar(test.E,ti);
[EPres, EPvar, ELCt] = ResVarEXE(test.E, ti);
EregreTable = ELregre(ECCt,test.E.el,test.E.snr,EPolyvar, EDiffvar, EPvar, Estrout, 'E',24);

[C3Polyvar ,C3Diffvar, C3CCt, C3strout] = CCresvar(test.C3,ti);
[C3Pres,  C3Pvar,  C3LCt]  = ResVarEXE(test.C3, ti);
C3regreTable = ELregre(C3CCt,test.C3.el,test.C3.snr,C3Polyvar, C3Diffvar, C3Pvar, C3strout, 'C3',34);

[C2iPolyvar ,C2iDiffvar, C2iCCt, C2istrout] = CCresvar(test.C2i,ti);
[C2iPres, C2iPvar, C2iLCt] = ResVarEXE(test.C2i, ti);
C2iregreTable = ELregre(C2iCCt,test.C2i.el,test.C2i.snr,C2iPolyvar, C2iDiffvar, C2iPvar, C2istrout, 'C2',13);

[C2gPolyvar ,C2gDiffvar, C2gCCt, C2gstrout] = CCresvar(test.C2g,ti);
[C2gPres, C2gPvar, C2gLCt] = ResVarEXE(test.C2g, ti);
C2gregreTable = ELregre(C2gCCt,test.C2g.el,test.C2g.snr,C2gPolyvar, C2gDiffvar, C2gPvar, C2gstrout, 'C2',5);
% 
% RETB = table;
% RETB.GPS = GregreTable;
% RETB.GLO = RregreTable;
% RETB.GAL = EregreTable;
% RETB.CMP3 = C3regreTable;
% RETB.C2i = C2iregreTable;
% RETB.C2g = C2gregreTable;
% writetable(RETB, '系数阵.txt');
%ResVarEXC(test.G,ti)