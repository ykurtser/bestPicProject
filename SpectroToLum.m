function [ ScaledSpectro ] = SpectroToLum(Spectro,res)
WLArr = 1:res;
WLArr = Hue2WaveLength(WLArr,res);
ScaledSpectro = zeros(1,length(Spectro));
lumin = csvread('lumin1nm.csv');
luminScaled = zeros(1,830);
luminScaled(390:830) = lumin(:,2);
for i = 1:length(Spectro)
    ScaledSpectro(i) = Spectro(i)*(luminScaled(WLArr(i)));
end
