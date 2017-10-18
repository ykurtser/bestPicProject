function [ Arr ] = AllColorTests(  )  
res=256;
 %H=ones(res)*0.8;
 %mod((round(H(1,1)*256)+14),256)
 H = 20;
 
 H = mod((H-18),256); %when showing according to hue values the color starts from red and finishes in red, we want it to start in purple and finish in red.
 H = H/256; %normaliz 0-1
 %%H = fliplr(H); %the hue change we get is opposite direction to wave length change so we flip the rows.
 S=ones(res);
 V=ones(res);
 HSVIM=zeros(res,res,3);
 HSVIM(:,:,1)=H;
 HSVIM(:,:,2)=S;
 HSVIM(:,:,3)=V;
 x_val = 1:res;
 x_val = Hue2WaveLength(1:res,res);
 RGBIM=hsv2rgb(HSVIM);
 figure;
 imagesc(x_val,x_val,fliplr(RGBIM));
 Arr = RGBIM;