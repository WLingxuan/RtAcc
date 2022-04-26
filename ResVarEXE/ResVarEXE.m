function [Pres,Pvar, LCt] = ResVarEXE(data,ti)
%RESVAREXE 此处显示有关此函数的摘要
%   此处显示详细说明
nf = 0;
strlist = ["","","","","",""];

for i = 1 : 6
    nf = nf + data.freqlist(i);
    if data.freqlist(i) == 1
        strlist(i) = data.fstr(i);     
    end
end

[Pres, Pvar, LCt]=GIFana(data, strlist,ti);

end

