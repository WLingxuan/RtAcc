load('outdata.mat')
ts = 1250;
te = 2500;

ti = gccd.ti(ts:te,1);

gprn = 25;
test.G.prn = gprn;
test.G.sys = 'G';
test.G.f1 = 1575420000; 
test.G.f2 = 1227600000; 
test.G.f3 = 1176450000; 
test.G.L1(:,1) = gobs.l1(ts:te,gprn);
test.G.L2(:,1) = gobs.l2(ts:te,gprn);
test.G.L3(:,1) = gobs.l3(ts:te,gprn);
test.G.el(:,1) = gobs.el(ts:te,gprn);
test.G.str(1,:) = char(gobs.str(1)); 
test.G.str(2,:) = char(gobs.str(2)); 
test.G.str(3,:) = char(gobs.str(3)); 
[test.G.GIF, test.G.t, test.G.polyGIF, test.G.resGIF, test.G.meanGIF, test.G.stdGIF, test.G.stdPH, test.G.pel] = phaseGIF(test.G,ti);

rprn = 9;
test.R.prn = rprn;
test.R.sys = 'R';
test.R.f1 = 1600875000; 
test.R.f2 = 1245125000; 
test.R.f3 = 1202025000; 
test.R.L1(:,1) = robs.l1(ts:te,rprn);
test.R.L2(:,1) = robs.l2(ts:te,rprn);
test.R.L3(:,1) = robs.l3(ts:te,rprn);
test.R.el(:,1) = robs.el(ts:te,rprn);
test.R.str(1,:) = char(robs.str(1)); 
test.R.str(2,:) = char(robs.str(2)); 
test.R.str(3,:) = char(robs.str(3)); 
[test.R.GIF, test.R.t, test.R.polyGIF, test.R.resGIF, test.R.meanGIF, test.R.stdGIF, test.R.stdPH, test.R.pel] = phaseGIF(test.R,ti);

eprn = 9;
test.E.prn = eprn;
test.E.sys = 'E';
test.E.f1 = 1575420000; 
test.E.f2 = 1207140000; 
test.E.f3 = 1176450000; 
test.E.L1(:,1) = eobs.l1(ts:te,eprn);
test.E.L2(:,1) = eobs.l2(ts:te,eprn);
test.E.L3(:,1) = eobs.l3(ts:te,eprn);
test.E.el(:,1) = eobs.el(ts:te,eprn);
test.E.str(1,:) = char(eobs.str(1)); 
test.E.str(2,:) = char(eobs.str(2)); 
test.E.str(3,:) = char(eobs.str(3)); 
[test.E.GIF, test.E.t, test.E.polyGIF, test.E.resGIF, test.E.meanGIF, test.E.stdGIF, test.E.stdPH, test.E.pel] = phaseGIF(test.E,ti);

c2prn = 5;
test.C2g.prn = c2prn;
test.C2g.sys = 'C';
test.C2g.f1 = 1561098000; 
test.C2g.f2 = 1207140000; 
test.C2g.f3 = 1268520000; 
GEOti = gccd.ti((ts+240):te,1);
test.C2g.L1(:,1) = c2obs.l1((ts+240):te,c2prn);
test.C2g.L2(:,1) = c2obs.l2((ts+240):te,c2prn);
test.C2g.L3(:,1) = c2obs.l4((ts+240):te,c2prn);
test.C2g.el(:,1) = c2obs.el((ts+240):te,c2prn);
test.C2g.str(1,:) = char(c2obs.str(1)); 
test.C2g.str(2,:) = char(c2obs.str(2)); 
test.C2g.str(3,:) = char(c2obs.str(4)); 
[test.C2g.GIF, test.C2g.t, test.C2g.polyGIF, test.C2g.resGIF, test.C2g.meanGIF, test.C2g.stdGIF, test.C2g.stdPH, test.C2g.pel] = phaseGIF(test.C2g,GEOti);

c2prn = 13;
test.C2i.prn = c2prn;
test.C2i.sys = 'C';
test.C2i.f1 = 1561098000; 
test.C2i.f2 = 1207140000; 
test.C2i.f3 = 1268520000; 
test.C2i.L1(:,1) = c2obs.l1(ts:te,c2prn);
test.C2i.L2(:,1) = c2obs.l2(ts:te,c2prn);
test.C2i.L3(:,1) = c2obs.l4(ts:te,c2prn);
test.C2i.el(:,1) = c2obs.el(ts:te,c2prn);
test.C2i.str(1,:) = char(c2obs.str(1)); 
test.C2i.str(2,:) = char(c2obs.str(2)); 
test.C2i.str(3,:) = char(c2obs.str(4)); 
[test.C2i.GIF, test.C2i.t, test.C2i.polyGIF, test.C2i.resGIF, test.C2i.meanGIF, test.C2i.stdGIF, test.C2i.stdPH, test.C2i.pel] = phaseGIF(test.C2i,ti);

c3prn = 34;
test.C3.prn = c3prn;
test.C3.sys = 'C';
test.C3.f1 = 1575420000; 
test.C3.f2 = 1176450000; 
test.C3.f3 = 1268520000;      
test.C3.L1(:,1) = c3obs.l6(ts:te,c3prn);
test.C3.L2(:,1) = c3obs.l3(ts:te,c3prn);
test.C3.L3(:,1) = c3obs.l4(ts:te,c3prn);
test.C3.el(:,1) = c3obs.el(ts:te,c3prn);
test.C3.str(1,:) = char(c3obs.str(6)); 
test.C3.str(2,:) = char(c3obs.str(3)); 
test.C3.str(3,:) = char(c3obs.str(4)); 
[test.C3.GIF, test.C3.t, test.C3.polyGIF, test.C3.resGIF, test.C3.meanGIF, test.C3.stdGIF, test.C3.stdPH, test.C3.pel] = phaseGIF(test.C3,ti);

plotphaseGIF(test);
