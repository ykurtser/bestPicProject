function [ specto_add ] = PixelHSV2SpectroWLArrVal(mean,sat,vol,res )
%setting num of units to be added to the spectogram ( area under gaussian, 
%according to the Image volume, meaning - in max volume we'll get 100 
%spectogram unit, in min volume (black), we'll get no units (no wavelengths)
NumOfUnits = vol;

%this sets the mean of the gaussian


Variance = exp((0.905-sat)*9); %Func we found on order to get: max saturation = delta, min saturation = flat line.
if (Variance == 0)
    Variance = 0.01;
end

x_gaussian = 1:1:res;
y_gaussian = gaussmf(x_gaussian,[Variance res-mean]);
y_gaussian(y_gaussian<0.01) = 0;
y_gaussian(y_gaussian>0.99) = 1;
y_gaussian = (y_gaussian/sum(y_gaussian)) * NumOfUnits; % normalizes the area under graph to be Num of units.
specto_add = y_gaussian;


end

