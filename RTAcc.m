m_glvs;

B = [50 47 53.0];
L = [4 21 30.8];
H = 158.3;
POS_R = [m_dms2r(B) m_dms2r(L) H];
n = 2880;

fileFolder = fullfile('F:\Data\experiment\Results\');
c2satf  = [fileFolder, dir([fileFolder, 'prestat.c2sat']).name];
c3satf  = [fileFolder, dir([fileFolder, 'prestat.c3sat']).name];
esatf   = [fileFolder, dir([fileFolder, 'prestat.esat']).name];
gsatf   = [fileFolder, dir([fileFolder, 'prestat.gsat']).name];
rsatf   = [fileFolder, dir([fileFolder, 'prestat.rsat']).name];
clkf    = [fileFolder, dir([fileFolder, 'prestat.clk']).name];
posf    = [fileFolder, dir([fileFolder, 'prestat.pos']).name];
stdf    = [fileFolder, dir([fileFolder, 'prestat.std']).name];
velf    = [fileFolder, dir([fileFolder, 'prestat.vel']).name];
preoutf = [fileFolder, dir([fileFolder, 'preout.txt']).name];

c2obsf  = [fileFolder, dir([fileFolder, 'prestat.c2obs']).name];
c3obsf  = [fileFolder, dir([fileFolder, 'prestat.c3obs']).name];
eobsf   = [fileFolder, dir([fileFolder, 'prestat.eobs']).name];
gobsf   = [fileFolder, dir([fileFolder, 'prestat.gobs']).name];
robsf   = [fileFolder, dir([fileFolder, 'prestat.robs']).name];

c2obs = getobs(c2obsf, n, 63);
c3obs = getobs(c3obsf, n, 63);
eobs = getobs(eobsf, n, 63);
gobs = getobs(gobsf, n, 63);
robs = getobs(robsf, n, 63);

c2ccd = getdata(c2satf, n, 63, 'BDS2');
c3ccd = getdata(c3satf, n, 63, 'BDS3');
gccd = getdata(gsatf, n, 32, 'GPS');
rccd = getdata(rsatf, n, 27, 'GLO');
eccd = getdata(esatf, n, 36, 'GAL');
outccd = sprintf("%sdata.mat", "out");

save(outccd, 'c2ccd', 'c3ccd', 'gccd', 'rccd', 'eccd', 'c2obs', 'c3obs', 'eobs', 'gobs', 'robs');

plotsats(c2satf, n, 63, 'BDS2');
plotsats(c3satf, n, 63, 'BDS3');
plotsats(gsatf, n, 32, 'GPS');
plotsats(rsatf, n, 27, 'GLO');
plotsats(esatf, n, 36, 'GAL');
plotvel(velf, n);
plotpos(posf, POS_R, n)
plotclk(clkf, n);

