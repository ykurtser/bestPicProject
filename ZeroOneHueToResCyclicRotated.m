function [ RotatedHue ] = ZeroOneHueToResCyclicRotated(Hue,Res,RotationValue);
%the rotation is done to make hue levels and WL natural color continuity in
%fit.
RotatedHue = mod(round((Hue*Res)+RotationValue),Res);

end